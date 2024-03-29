import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:dio/dio.dart';
import 'package:mawaheb_app/base/data/datasources/mawaheb_datasource.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';

abstract class SplashDataSource extends BaseRemoteDataSource {}

@LazySingleton(as: SplashDataSource)
class SplashDataSourceImpl extends MawahebRemoteDataSource implements SplashDataSource {
  SplashDataSourceImpl({
    required Dio client,
    required PrefsRepository prefsRepository,
    required Logger logger,
  }) : super(
          prefsRepository: prefsRepository,
          client: client,
          logger: logger,
        );
}
