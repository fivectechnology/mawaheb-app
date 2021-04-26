import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/auth_page.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:mawaheb_app/features/settings/ui/change_email_page.dart';
import 'package:mawaheb_app/features/settings/ui/change_password_page.dart';
import 'package:mawaheb_app/features/settings/ui/setting_otp_page.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

part 'settings_viewmodel.g.dart';

@injectable
class SettingsViewmodel extends _SettingsViewmodelBase
    with _$SettingsViewmodel {
  SettingsViewmodel(
    Logger logger,
    SettingsRepository settingsRepository,
    AuthRepository authRepository,
    PrefsRepository prefsRepository,
  ) : super(
          logger,
          settingsRepository,
          authRepository,
          prefsRepository,
        );
}

abstract class _SettingsViewmodelBase extends BaseViewmodel with Store {
  _SettingsViewmodelBase(
    Logger logger,
    this._settingsRepository,
    this._authRepository,
    this._prefsRepository,
  ) : super(logger);
  final SettingsRepository _settingsRepository;
  final AuthRepository _authRepository;
  final PrefsRepository _prefsRepository;

  //* OBSERVERS *//
  @observable
  ObservableFuture<bool> logoutFuture;

  @observable
  ObservableFuture<bool> sendOtp;

  @observable
  ObservableFuture<bool> changePasswordFuture;

  @observable
  ObservableFuture<PlayerModel> playerEmailFuture;

  @observable
  ObservableFuture<OTPResponseModel> verifyOTPFuture;

  @observable
  ObservableFuture<OTPResponseModel> changeEmailFuture;

  @observable
  ObservableFuture<bool> validateEmailFuture;

  //* COMPUTED *//
  @computed
  bool get logoutLoading => logoutFuture?.isPending ?? false;

  @computed
  bool get otpLoading => sendOtp?.isPending ?? false;

  @computed
  bool get otpError => sendOtp?.isFailure ?? false;

  @computed
  bool get passwordLoading => changePasswordFuture?.isPending ?? false;

  @computed
  bool get passwordError => changePasswordFuture?.isFailure ?? false;

  @computed
  bool get changeEmailLoading => changeEmailFuture?.isPending ?? false;

  @computed
  bool get changeEmailError => changeEmailFuture?.isFailure ?? false;

  @computed
  PlayerModel get player => playerEmailFuture?.value;

  @computed
  bool get playerEmailLoading => playerEmailFuture?.isPending ?? false;

  @computed
  OTPResponseModel get otpCode => verifyOTPFuture?.value ?? false;

  @computed
  bool get verifyOTPLoading => verifyOTPFuture?.isPending ?? false;

  //* ACTIONS *//
  @action
  void logout() {
    logoutFuture = futureWrapper(
      () => _authRepository.logout().then(
            (res) => res.apply(() {
              App.navKey.currentState
                  .pushNamedAndRemoveUntil(AuthPage.route, (_) => false);
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void sendOTP({
    String email,
    String password,
    bool resend = false,
  }) {
    if (!resend) {
      playerEmailFuture = ObservableFuture.value(PlayerModel.fromUi(
        email: email,
        password: password,
      ));
    }
    sendOtp = futureWrapper(
      () => _settingsRepository
          .sendOTP(email: player.email, password: player.password)
          .whenSuccess(
            (res) => res.apply(() {
              logger.d('otp success with res: $res');
              if (!resend) {
                getContext((context) =>
                    context.navigator.push(SettingOtpPage.pageRoute(this)));
              } else {
                //showSnack()
              }
            }),
          ),
      catchBlock: (err) => getContext((context) => showSnack(
            context.translate('msg_change_email_error'),
            duration: 2.seconds,
            scaffoldKey: ChangeEmailPage.scaffoldKey,
          )),
      unknownErrorHandler: (err) => getContext(
        (context) => showSnack(
          context.translate('msg_change_email_error'),
          duration: 2.seconds,
          scaffoldKey: ChangeEmailPage.scaffoldKey,
        ),
      ),
      useLoader: true,
    );
  }

  @action
  void verifyOTP({int code}) {
    logger.d('otp verify enterre');

    verifyOTPFuture = futureWrapper(
      () => _settingsRepository
          .verifyOTP(email: player.email, code: code)
          .whenSuccess(
            (res) => res.data.apply(() async {
              logger.d('otp verify success with res: $res');
              await _settingsRepository
                  .changeEmail(email: player.email, code: res.data.data)
                  .whenSuccess((res) => res.apply(() {
                        logout();
                      }));
            }),
          ),
      catchBlock: (err) => getContext((context) => showSnack(
          context.translate('msg_otp_error'),
          duration: 2.seconds,
          scaffoldKey: SettingOtpPage.scaffoldKey)),
      unknownErrorHandler: (err) => getContext(
        (context) => showSnack(context.translate('msg_otp_error'),
            duration: 2.seconds, scaffoldKey: SettingOtpPage.scaffoldKey),
      ),
      useLoader: true,
    );
  }

  @action
  void changePassword({String newPassword, String currentPassword}) {
    changeEmailFuture = futureWrapper(
      () => _settingsRepository
          .changePassword(
              newPassword: newPassword,
              currentPassword: currentPassword,
              id: _prefsRepository.player.id)
          .whenSuccess(
            (res) => res.apply(() async {
              logout();
              logger.d('change password success with res: $res');
            }),
          ),
      catchBlock: (err) => getContext((context) => showSnack(
          context.translate('msg_change_password_error'),
          duration: 2.seconds,
          scaffoldKey: ChangePasswordPage.scaffoldKey)),
      unknownErrorHandler: (err) => getContext(
        (context) => showSnack(context.translate('msg_change_password_error'),
            duration: 2.seconds, scaffoldKey: ChangePasswordPage.scaffoldKey),
      ),
      useLoader: true,
    );
  }
}
