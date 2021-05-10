import 'dart:async';
import 'dart:io';

import 'package:core_sdk/error/failures.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/base/utils/permissions_helper.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

@lazySingleton
class DownloadHelper {
  DownloadHelper(
    this._prefsRepository,
    this._client,
  );

  final PrefsRepository _prefsRepository;
  final Dio _client;

  Future<String> getPath() async {
    try {
      if (await Permission.storage.request().isGranted) {
        final path = (await findLocalPath(forDownload: true)) + '/Mawaheb/';
        final savedDir = Directory(path);
        if (!savedDir.existsSync()) {
          savedDir.create();
        }
        return path;
      } else
        throw Exception('Error: Unable to get STORAGE permission!');
    } catch (e) {
      print(e);
      throw Exception('Error: Unable to get STORAGE permission!');
    }
  }

  Future<NetworkResult<bool>> requestDownload({
    required int? id,
    required int? parentId,
    required void Function(int progress) onReceiveProgress,
    required Function(String? filePath) onSuccess,
    bool openWhenFinish = true,
  }) async {
    try {
      final fileUrl = _fixUrl(id: id, parentId: parentId);
      final String folderPath = await getPath();
      String? filePath;
      onReceiveProgress(1);
      final res = await _client.download(
        fileUrl,
        (Headers headers) {
          final String contentHeader = headers.value('content-disposition')!;
          final resPath = contentHeader.substring(contentHeader.lastIndexOf('=') + 2, contentHeader.length - 1);
          filePath = folderPath + '${DateTime.now().microsecondsSinceEpoch}_${resPath.trim()}';
          return filePath;
        },
        options: Options(
          method: 'GET',
          headers: {
            'Authorization': 'Basic ${_prefsRepository.token}',
            'Accept': '*/*',
          },
        ),
        // onReceiveProgress: (int count, int total) {
        //   onReceiveProgress(count);
        // },
      ).then((res) {
        if (openWhenFinish) {
          OpenFile.open(filePath);
        }
        return res;
      }).whenComplete(() => onSuccess(filePath));
      print('my debug success download res ${res.data},');
      return Success(true);
    } catch (e) {
      print('my debug fail download res $e');

      return NetworkError(PermissionFailure('Error: Unable to get STORAGE permission!'));
    }
  }

  String _fixUrl({
    required int? id,
    required int? parentId,
  }) =>
      BASE_REST_API +
      '/com.axelor.meta.db.MetaFile/$id/content/download?parentId=$parentId&parentModel=com.axelor.mawaheb.base.db.DownloadCentreItem';
}

class PermissionFailure extends Failure {
  PermissionFailure(String message) : super(message);
}
