import 'package:core_sdk/data/datasource/base_remote_data_source_impl.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';

class MawahebRemoteDataSource extends BaseRemoteDataSourceImpl {
  MawahebRemoteDataSource({
    @required Dio client,
    @required DataConnectionChecker connectionChecker,
    @required Logger logger,
    @required this.prefsRepository,
  }) : super(
          client: client,
          connectionChecker: connectionChecker,
          logger: logger,
        );

  final PrefsRepository prefsRepository;

  @override
  Map<String, dynamic> wrapWithBaseData(data, int siteId) {
    // final wrappedData = Map<String, dynamic>();
    // final siteIdParam = siteId ?? prefsRepository.siteId ?? -1;
    // wrappedData['langCode'] = prefsRepository.languageCode ?? LANGUAGE_DEFAULT;
    // if (siteIdParam > 0) wrappedData['siteId'] = siteIdParam;
    // if (data != null) wrappedData['data'] = data;
    // return wrappedData;
    return data;
  }
}
