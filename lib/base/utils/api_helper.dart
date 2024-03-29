import 'package:flutter/foundation.dart';

typedef EndPointFunction = String Function(String);

const int PAGE_SIZE = 20;

// const int VIDEO_SIZE = 15000000;

const int MAX_VIDEO_NUMBER = 3;
// const String BASE_API = 'http://54.237.125.179:8080/mawaheb';
const String BASE_API = 'https://demo.fivectech.com:9003/mawaheb';

const String BASE_DB = '/com.axelor.';
const String MAWAHEB_BASE_DB = '/com.axelor.mawaheb.base.db.';

const String WEB_SERVICE = '/ws';
const String PUBLIC_SERVICE = '/public';

const String BASE_REST_API = '$BASE_API$WEB_SERVICE/rest';
const String BASE_PUBLIC_API = '$BASE_API$WEB_SERVICE$PUBLIC_SERVICE';

enum EndPointAction { search, remove, fetch, upload }

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
const String LOGIN_ENDPOINT = BASE_PUBLIC_API + '/auth/login';
const String LOGOUT_ENDPOINT = BASE_API + '/open-platform-demo/logout';
const String OTP_SEND_ENDPOINT = BASE_PUBLIC_API + '/auth/otp/send';
const String OTP_VERIFY_ENDPOINT = BASE_PUBLIC_API + '/auth/otp/verify';

//* SETTINGS *//
const String TERMS_OF_SERVICES_ENDPOINT = 'https://google.com';
