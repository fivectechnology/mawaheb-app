import 'package:flutter/foundation.dart';

typedef EndPointFunction = String Function(String);

const String BASE_API = 'http://54.237.125.179:8080/mawaheb';
const String BASE_DB = '/com.axelor.';
const String MAWAHEB_BASE_DB = '/com.axelor.mawaheb.base.db.';

const String WEB_SERVICE = '/ws';
const String PUBLIC_SERVICE = '/public';

const String BASE_REST_API = '$BASE_API$WEB_SERVICE/rest';
const String BASE_PUBLIC_API = '$BASE_API$WEB_SERVICE$PUBLIC_SERVICE';

enum EndPointAction { search, remove, fetch }

extension OrderStatusExtension on EndPointAction {
  String get raw => describeEnum(this);

  static EndPointAction valueOf(int data) {
    for (final EndPointAction value in EndPointAction.values) {
      if (value.index == data) {
        return value;
      }
    }
    //throw ArgumentError('$data is not a valid ModuleType value');
    return EndPointAction.search;
  }
}

//* AUTH *//
const String LOGIN_ENDPOINT = BASE_API + '/callback';
const String LOGOUT_ENDPOINT = BASE_API + '/open-platform-demo/logout';
const String OTP_SEND_ENDPOINT = BASE_PUBLIC_API + '/auth/otp/send';
const String OTP_VERIFY_ENDPOINT = BASE_PUBLIC_API + '/auth/otp/verify';

//* USER *//
const String PROFILE_UPDATE_ENDPOINT = BASE_REST_API + BASE_DB + 'auth.db.User';
