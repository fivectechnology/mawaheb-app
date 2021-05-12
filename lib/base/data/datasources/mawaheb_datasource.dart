import 'dart:convert';

import 'package:core_sdk/data/datasource/base_remote_data_source.dart';
import 'package:core_sdk/data/datasource/base_remote_data_source_impl.dart';
import 'package:core_sdk/error/exceptions.dart';
import 'package:core_sdk/error/failures.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/dio/token_option.dart';
import 'package:core_sdk/utils/network_result.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';

class MawahebRemoteDataSource extends BaseRemoteDataSourceImpl {
  MawahebRemoteDataSource({
    required Dio client,
    required Logger logger,
    required this.prefsRepository,
  }) : super(
          client: client,
          logger: logger,
        );

  final PrefsRepository? prefsRepository;

  @override
  Map<String, dynamic> wrapWithBaseData(data) {
    // final wrappedData = Map<String, dynamic>();
    // final siteIdParam = siteId ?? prefsRepository.siteId ?? -1;
    // wrappedData['langCode'] = prefsRepository.languageCode ?? LANGUAGE_DEFAULT;
    // if (siteIdParam > 0) wrappedData['siteId'] = siteIdParam;
    // if (data != null) wrappedData['data'] = data;
    // return wrappedData;
    return data;
  }

  @override
  Future<NetworkResult<T?>> request<T>({
    required METHOD method,
    required String endpoint,
    data,
    int? siteId,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Mapper<T?>? mapper,
    String? messageErrorKey = 'msg_something_wrong',
    // String messageErrorKey,
    bool withAuth = true,
    bool wrapData = true,
  }) async {
    return _checkNetwork<T?>(() async {
      late Response response;
      dynamic jsonResponse;
      try {
        final Options options =
            withAuth ? TokenOption.toOptions().copyWith(headers: headers) : Options(headers: headers);
        print('data = $data');
        print('endpoint = $endpoint');

        switch (method) {
          case METHOD.GET:
            response = await performGetRequest(
              endpoint: endpoint,
              params: params,
              options: options,
            );
            break;
          case METHOD.POST:
            response = await performPostRequest(
              endpoint: endpoint,
              data: wrapData ? wrapWithBaseData(data) : data,
              params: params,
              options: options,
            );
            break;
          case METHOD.PUT:
            response = await performPutRequest(
              endpoint: endpoint,
              data: wrapData ? wrapWithBaseData(data) : data,
              params: params,
              options: options,
            );
            break;
          case METHOD.DELETE:
            response = await performDeleteRequest(
              endpoint: endpoint,
              data: wrapData ? wrapWithBaseData(data) : data,
              params: params,
              options: options,
            );
            break;
        }

        if (mapper == null) {
          if (response.statusCode == 200) {
            return Success<T?>(null);
          } else {
            NetworkError(ServerFailure(messageErrorKey));
          }
        }

        jsonResponse = jsonDecode(response.data);
        if (jsonResponse is! Map && mapper == null) {
          return Success(jsonResponse as T?);
        }

        if ((jsonResponse['status'] as int?) != 0) {
          // TODO(abd): we should check -1 status with proper data message to make relogin
          throw ServerException(_getErrorMessage(jsonResponse));
        }

        return Success(mapper!(jsonResponse));
      } catch (e) {
        //logger.e('my debug new error $response $jsonResponse');
        logger.e('BaseDataSourceWithMapperImpl => request<$T> => ERROR = $e');
        try {
          return NetworkError(ServerFailure(_getErrorMessage(jsonResponse)));
        } catch (ex) {
          logger.e(
              'BaseDataSourceWithMapperImpl FINAL CATCH ERROR => request<$T> => ERROR = e:$e \n $response \n $jsonResponse');
          // return e is ServerException
          //     ? NetworkError(ServerFailure(e.message))
          //     : NetworkError(ServerFailure(e.message ?? messageErrorKey));
          return e is ServerException
              ? NetworkError(ServerFailure(e.message))
              : NetworkError(ServerFailure(messageErrorKey));
        }
      }
    });
  }

  Future<NetworkResult<T>> _checkNetwork<T>(
    Future<NetworkResult<T>> Function() body,
  ) async {
    return body();
  }

  Future<NetworkResult<T?>> mawahebRequest<T>({
    required METHOD method,
    bool mawahebModel = true,
    bool public = false,
    bool withAuth = true,
    bool wrapData = false,
    int? id,
    String? modelName,
    String? endpoint,
    EndPointAction? action,
    data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Mapper<T?>? mapper,
  }) {
    return request<T?>(
      endpoint: endpoint ??
          getModelEndPoint(
            action: action,
            id: id,
            mawahebModel: mawahebModel,
            modelName: modelName!,
            public: public,
          ),
      method: method,
      data: data,
      headers: headers,
      mapper: mapper,
      withAuth: withAuth,
      params: params,
      wrapData: wrapData,
    );
  }

  String getModelEndPoint({
    required String modelName,
    required int? id,
    required EndPointAction? action,
    required bool mawahebModel,
    required bool public,
  }) {
    return (public ? BASE_PUBLIC_API : BASE_REST_API) +
        (mawahebModel ? MAWAHEB_BASE_DB : BASE_DB) +
        modelName +
        (id != null ? '/$id' : '') +
        (action != null ? '/${action.raw}' : '');
  }

  String? _getErrorMessage(Map<String, dynamic> response) {
    try {
      return (response['status'] as int == -1) ? response['data']['message'] : response['errors']['error'];
    } catch (ex) {
      return 'msg_something_wrong';
    }
  }

  Future<NetworkResult<VersionResponse?>> getVersion({
    required String modelName,
    required int? modelId,
    bool mawahebModel = true,
    bool asList = false,
  }) {
    return mawahebRequest(
      method: METHOD.POST,
      modelName: modelName,
      id: modelId,
      action: EndPointAction.fetch,
      mapper: asList ? ListBaseResponseModel.versionMapper : BaseResponseModel.versionMapper,
      data: VersionResponse.body,
      mawahebModel: mawahebModel,
    );
  }
}
