typedef EndPointFunction = String Function(String);

const String BASE_API = 'http://54.237.125.179:8080/mawaheb';

const String WEB_SERVICE = '/ws';
const String PUBLIC_SERVICE = '/public';

const String BASE_REST_API = '$BASE_API$WEB_SERVICE/rest';
const String BASE_PUBLIC_API = '$BASE_API$WEB_SERVICE$PUBLIC_SERVICE';

//* NOTIFICATIONS-DEVICE *//
const String REGISTER_DEVICE_ENDPOINT = BASE_PUBLIC_API + '/notification/devices/create';
const String LINK_DEVICE_ENDPOINT = BASE_REST_API + '/com.axelor.mawaheb.base.db.NotificationDevice';
const String UNLINK_DEVICE_ENDPOINT = BASE_REST_API + '/com.axelor.mawaheb.base.db.NotificationDevice';
// ignore: prefer_function_declarations_over_variables
EndPointFunction deviceGetEndPoint =
    (String id) => BASE_REST_API + '/com.axelor.mawaheb.base.db.NotificationDevice/$id/fetch';

//* NOTIFICATIONS-MESSAGES *//
const String MESSAGES_ALL_ENDPOINT = BASE_REST_API + '/com.axelor.mawaheb.base.db.NotificationMessage/search';
const String MESSAGES_READ = BASE_REST_API + '/com.axelor.mawaheb.base.db.NotificationMessage';
const String MESSAGES_COUNT = BASE_REST_API + '/com.axelor.mawaheb.base.db.Metadata/search';
const String MESSAGES_COUNT_RESET = BASE_REST_API + '/com.axelor.mawaheb.base.db.Metadata';
// ignore: prefer_function_declarations_over_variables
EndPointFunction messageDelete =
    (String id) => BASE_REST_API + '/com.axelor.mawaheb.base.db.NotificationMessage/$id/remove';

//* AUTH *//
const String LOGIN_ENDPOINT = BASE_API + '/callback';
const String LOGOUT_ENDPOINT = BASE_API + '/open-platform-demo/logout';
const String OTP_SEND_ENDPOINT = BASE_PUBLIC_API + '/auth/otp/send';
const String OTP_VERIFY_ENDPOINT = BASE_PUBLIC_API + '/auth/otp/verify';

//* PUBLIC *//
const String ABOUT_US_ENDPOINT = BASE_REST_API + '/com.axelor.mawaheb.base.db.AboutUs/search';
const String CONTACT_US_ENDPOINT = BASE_REST_API + '/com.axelor.mawaheb.base.db.ContactUs/search';
const String DOWNLOAD_CENTER_ENDPOINT = BASE_REST_API + '/com.axelor.mawaheb.base.db.downloadcentre.Item/search';
const String PHOTO_GALLERY_ENDPOINT = BASE_REST_API + '/com.axelor.mawaheb.base.db.photogallery.Photo/search';
const String STRATIGIC_PARTNER_ENDPOINT =
    BASE_REST_API + '/com.axelor.mawaheb.base.db.strategicpartners.StrategicPartner/search';

//* PARTNERS *//
const String PARTNERS_ENDPOINT = BASE_REST_API + '/com.axelor.mawaheb.base.db.partners.Partner/search';
