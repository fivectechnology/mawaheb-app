import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/features/auth/auth_page.dart';
import 'package:mawaheb_app/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mawaheb_app/features/auth/otp/ui/pages/otp_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/about_us_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/public_info_page.dart';
import 'package:mawaheb_app/features/splash/ui/pages/splash_page.dart';

import '../../features/auth/login/ui/pages/login_page.dart';

class PageRouter {
  static Route<dynamic> route(RouteSettings value) {
    switch (value.name) {
      case SplashPage.route:
        return SplashPage.pageRoute;

      case AuthPage.route:
        return AuthPage.pageRoute;

      case BasePage.route:
        return BasePage.pageRoute;

      case ForgotPasswordPage.route:
        return ForgotPasswordPage.pageRoute;

      case LoginPage.route:
        return LoginPage.pageRoute;

      case PublicInfoPage.route:
        return PublicInfoPage.pageRoute;

      case OtpPage.route:
        return OtpPage.pageRoute;

      case AboutUsPage.route:
        return AboutUsPage.pageRoute;

      default:
        return _errorRoute(value.name);
    }
  }

  static Route<dynamic> _errorRoute(String routeName) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Routing Error!')),
          body: Center(
            child: Text('ERROR: No page route found for "$routeName"'),
          ),
        );
      },
    );
  }
}
