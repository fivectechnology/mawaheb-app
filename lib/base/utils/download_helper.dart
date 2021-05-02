import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:core_sdk/error/failures.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/base/utils/permissions_helper.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class DownloadHelper {
  DownloadHelper(this._prefsRepository) {
    _init();
  }

  static const String DOWNLOADER_SEND_PORT = 'downloader_send_port';
  final processingTasks = <String, String>{};
  final PrefsRepository _prefsRepository;
  final _port = ReceivePort();
  String _localPath;
  bool _prepared = false;

  Future<void> _init() async {
    await FlutterDownloader.initialize();
    FlutterDownloader.registerCallback(downloadCallback);
    _bindBackgroundIsolate();
    // _prepare();
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName(DOWNLOADER_SEND_PORT);
    send.send([id, status, progress]);
  }

  void _bindBackgroundIsolate() {
    final bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, DOWNLOADER_SEND_PORT);
    if (!isSuccess) {
      IsolateNameServer.removePortNameMapping(DOWNLOADER_SEND_PORT);
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((data) {
      print('Downloading => taskId = ${data[0]}, status = ${data[1]}, progress = ${data[2]}');
      if (data[1] != DownloadTaskStatus.running) {
        processingTasks.remove(data[0]);
      }
    });
  }

  Future<void> _prepare() async {
    try {
      if (await Permission.storage.request().isGranted) {
        _localPath = (await findLocalPath(forDownload: true)) + '/Mawaheb';
        final savedDir = Directory(_localPath);
        if (!savedDir.existsSync()) {
          savedDir.create();
        }
        _prepared = true;
      } else
        throw Exception('Error: Unable to get STORAGE permission!');
    } catch (e) {
      print('');
    }
  }

  Future<NetworkResult<bool>> requestDownload({
    @required int id,
    @required int parentId,
  }) async {
    final fileUrl = _fixUrl(id: id, parentId: parentId);
    try {
      if (!_prepared) {
        await _prepare();
      }
      if (processingTasks.containsValue(fileUrl)) {
        return Success(false);
      }
      final taskId = await FlutterDownloader.enqueue(
        url: fileUrl,
        headers: {'Authorization': 'Basic ${_prefsRepository.token}'},
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true,
      );
      processingTasks[taskId] = fileUrl;
      return Success(true);
    } catch (e) {
      return NetworkError(PermissionFailure('Error: Unable to get STORAGE permission!'));
    }
  }

  String _fixUrl({
    @required int id,
    @required int parentId,
  }) =>
      BASE_REST_API +
      '/com.axelor.meta.db.MetaFile/$id/content/download?parentId=$parentId&parentModel=com.axelor.mawaheb.base.db.DownloadCentreItem';
}

class PermissionFailure extends Failure {
  PermissionFailure(String message) : super(message);
}
