// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsViewmodel on _SettingsViewmodelBase, Store {
  Computed<bool> _$logoutLoadingComputed;

  @override
  bool get logoutLoading =>
      (_$logoutLoadingComputed ??= Computed<bool>(() => super.logoutLoading,
              name: '_SettingsViewmodelBase.logoutLoading'))
          .value;
  Computed<bool> _$otpLoadingComputed;

  @override
  bool get otpLoading =>
      (_$otpLoadingComputed ??= Computed<bool>(() => super.otpLoading,
              name: '_SettingsViewmodelBase.otpLoading'))
          .value;
  Computed<bool> _$otpErrorComputed;

  @override
  bool get otpError =>
      (_$otpErrorComputed ??= Computed<bool>(() => super.otpError,
              name: '_SettingsViewmodelBase.otpError'))
          .value;
  Computed<bool> _$passwordLoadingComputed;

  @override
  bool get passwordLoading =>
      (_$passwordLoadingComputed ??= Computed<bool>(() => super.passwordLoading,
              name: '_SettingsViewmodelBase.passwordLoading'))
          .value;
  Computed<bool> _$passwordErrorComputed;

  @override
  bool get passwordError =>
      (_$passwordErrorComputed ??= Computed<bool>(() => super.passwordError,
              name: '_SettingsViewmodelBase.passwordError'))
          .value;
  Computed<PlayerModel> _$playerComputed;

  @override
  PlayerModel get player =>
      (_$playerComputed ??= Computed<PlayerModel>(() => super.player,
              name: '_SettingsViewmodelBase.player'))
          .value;
  Computed<bool> _$playerEmailLoadingComputed;

  @override
  bool get playerEmailLoading => (_$playerEmailLoadingComputed ??=
          Computed<bool>(() => super.playerEmailLoading,
              name: '_SettingsViewmodelBase.playerEmailLoading'))
      .value;
  Computed<OTPResponseModel> _$otpCodeComputed;

  @override
  OTPResponseModel get otpCode =>
      (_$otpCodeComputed ??= Computed<OTPResponseModel>(() => super.otpCode,
              name: '_SettingsViewmodelBase.otpCode'))
          .value;
  Computed<bool> _$verifyOTPLoadingComputed;

  @override
  bool get verifyOTPLoading => (_$verifyOTPLoadingComputed ??= Computed<bool>(
          () => super.verifyOTPLoading,
          name: '_SettingsViewmodelBase.verifyOTPLoading'))
      .value;
  Computed<bool> _$otpVerifyErrorComputed;

  @override
  bool get otpVerifyError =>
      (_$otpVerifyErrorComputed ??= Computed<bool>(() => super.otpVerifyError,
              name: '_SettingsViewmodelBase.otpVerifyError'))
          .value;

  final _$logoutFutureAtom = Atom(name: '_SettingsViewmodelBase.logoutFuture');

  @override
  ObservableFuture<bool> get logoutFuture {
    _$logoutFutureAtom.reportRead();
    return super.logoutFuture;
  }

  @override
  set logoutFuture(ObservableFuture<bool> value) {
    _$logoutFutureAtom.reportWrite(value, super.logoutFuture, () {
      super.logoutFuture = value;
    });
  }

  final _$sendOtpAtom = Atom(name: '_SettingsViewmodelBase.sendOtp');

  @override
  ObservableFuture<bool> get sendOtp {
    _$sendOtpAtom.reportRead();
    return super.sendOtp;
  }

  @override
  set sendOtp(ObservableFuture<bool> value) {
    _$sendOtpAtom.reportWrite(value, super.sendOtp, () {
      super.sendOtp = value;
    });
  }

  final _$changePasswordFutureAtom =
      Atom(name: '_SettingsViewmodelBase.changePasswordFuture');

  @override
  ObservableFuture<bool> get changePasswordFuture {
    _$changePasswordFutureAtom.reportRead();
    return super.changePasswordFuture;
  }

  @override
  set changePasswordFuture(ObservableFuture<bool> value) {
    _$changePasswordFutureAtom.reportWrite(value, super.changePasswordFuture,
        () {
      super.changePasswordFuture = value;
    });
  }

  final _$playerEmailFutureAtom =
      Atom(name: '_SettingsViewmodelBase.playerEmailFuture');

  @override
  ObservableFuture<PlayerModel> get playerEmailFuture {
    _$playerEmailFutureAtom.reportRead();
    return super.playerEmailFuture;
  }

  @override
  set playerEmailFuture(ObservableFuture<PlayerModel> value) {
    _$playerEmailFutureAtom.reportWrite(value, super.playerEmailFuture, () {
      super.playerEmailFuture = value;
    });
  }

  final _$verifyOTPFutureAtom =
      Atom(name: '_SettingsViewmodelBase.verifyOTPFuture');

  @override
  ObservableFuture<OTPResponseModel> get verifyOTPFuture {
    _$verifyOTPFutureAtom.reportRead();
    return super.verifyOTPFuture;
  }

  @override
  set verifyOTPFuture(ObservableFuture<OTPResponseModel> value) {
    _$verifyOTPFutureAtom.reportWrite(value, super.verifyOTPFuture, () {
      super.verifyOTPFuture = value;
    });
  }

  final _$validateEmailFutureAtom =
      Atom(name: '_SettingsViewmodelBase.validateEmailFuture');

  @override
  ObservableFuture<bool> get validateEmailFuture {
    _$validateEmailFutureAtom.reportRead();
    return super.validateEmailFuture;
  }

  @override
  set validateEmailFuture(ObservableFuture<bool> value) {
    _$validateEmailFutureAtom.reportWrite(value, super.validateEmailFuture, () {
      super.validateEmailFuture = value;
    });
  }

  final _$updateLangAtom = Atom(name: '_SettingsViewmodelBase.updateLang');

  @override
  ObservableFuture<bool> get updateLang {
    _$updateLangAtom.reportRead();
    return super.updateLang;
  }

  @override
  set updateLang(ObservableFuture<bool> value) {
    _$updateLangAtom.reportWrite(value, super.updateLang, () {
      super.updateLang = value;
    });
  }

  final _$_SettingsViewmodelBaseActionController =
      ActionController(name: '_SettingsViewmodelBase');

  @override
  void updateUserLanguage({String lang}) {
    final _$actionInfo = _$_SettingsViewmodelBaseActionController.startAction(
        name: '_SettingsViewmodelBase.updateUserLanguage');
    try {
      return super.updateUserLanguage(lang: lang);
    } finally {
      _$_SettingsViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$_SettingsViewmodelBaseActionController.startAction(
        name: '_SettingsViewmodelBase.logout');
    try {
      return super.logout();
    } finally {
      _$_SettingsViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendOTP({String email, String password, bool resend = false}) {
    final _$actionInfo = _$_SettingsViewmodelBaseActionController.startAction(
        name: '_SettingsViewmodelBase.sendOTP');
    try {
      return super.sendOTP(email: email, password: password, resend: resend);
    } finally {
      _$_SettingsViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void verifyOTP({int code}) {
    final _$actionInfo = _$_SettingsViewmodelBaseActionController.startAction(
        name: '_SettingsViewmodelBase.verifyOTP');
    try {
      return super.verifyOTP(code: code);
    } finally {
      _$_SettingsViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePassword({String newPassword, String currentPassword}) {
    final _$actionInfo = _$_SettingsViewmodelBaseActionController.startAction(
        name: '_SettingsViewmodelBase.changePassword');
    try {
      return super.changePassword(
          newPassword: newPassword, currentPassword: currentPassword);
    } finally {
      _$_SettingsViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
logoutFuture: ${logoutFuture},
sendOtp: ${sendOtp},
changePasswordFuture: ${changePasswordFuture},
playerEmailFuture: ${playerEmailFuture},
verifyOTPFuture: ${verifyOTPFuture},
validateEmailFuture: ${validateEmailFuture},
updateLang: ${updateLang},
logoutLoading: ${logoutLoading},
otpLoading: ${otpLoading},
otpError: ${otpError},
passwordLoading: ${passwordLoading},
passwordError: ${passwordError},
player: ${player},
playerEmailLoading: ${playerEmailLoading},
otpCode: ${otpCode},
verifyOTPLoading: ${verifyOTPLoading},
otpVerifyError: ${otpVerifyError}
    ''';
  }
}
