import 'dart:io';

import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/base/domain/repositories/prefs_repository.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/otp_response_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mawaheb_app/features/auth/forgot_password/ui/pages/reset_password_page.dart';
import 'package:mawaheb_app/features/auth/otp/ui/pages/otp_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/register_page.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';

import '../auth_page.dart';

part 'auth_viewmodel.g.dart';

abstract class PageSliderModel {
  const PageSliderModel(this.value);

  final int value;
}

class PageSliderForawardModel extends PageSliderModel {
  const PageSliderForawardModel() : super(1);
}

class PageSliderBackwardModel extends PageSliderModel {
  const PageSliderBackwardModel() : super(-1);
}

@injectable
class AuthViewmodel extends _AuthViewmodelBase with _$AuthViewmodel {
  AuthViewmodel(
    Logger logger,
    AuthRepository authRepository,
    PrefsRepository prefsRepository,
    ProfileRepository profileRepository,
  ) : super(logger, authRepository, prefsRepository, profileRepository);
}

abstract class _AuthViewmodelBase extends BaseViewmodel with Store {
  _AuthViewmodelBase(Logger logger, this._authRepository, this._prefsRepository, this._profileRepository)
      : super(logger);

  final AuthRepository _authRepository;
  final PrefsRepository _prefsRepository;
  final ProfileRepository _profileRepository;

  //* OBSERVERS *//

  @observable
  File image;

  String forgetPasswordEmail;

  @observable
  Future<int> imageId;

  @observable
  PageSliderModel registerSliderModel;

  @observable
  ObservableFuture<bool> loginFuture;

  @observable
  ObservableFuture<bool> sendOtp;

  @observable
  ObservableFuture<bool> validateEmailFuture;

  @observable
  ObservableFuture<PlayerModel> registerFuture;

  @observable
  ObservableFuture<List<SportModel>> sportFuture;

  @observable
  ObservableFuture<List<SportPositionModel>> positionFuture;

  @observable
  ObservableFuture<List<CategoryModel>> categoryFuture;

  @observable
  ObservableFuture<List<CountryModel>> countryFuture;

  @observable
  ObservableFuture<List<EmirateModel>> emirateFuture;

  @observable
  ObservableFuture<OTPResponseModel> verifyOTPFuture;

  @observable
  ObservableFuture<bool> forgetPasswordFuture;

  // @observable
  // ObservableFuture<bool> reset;

  //* COMPUTED *//

  @computed
  bool get loginLoading => loginFuture?.isPending ?? false;

  @computed
  bool get loginError => loginFuture?.isFailure ?? false;

  @computed
  bool get otpLoading => sendOtp?.isPending ?? false;

  @computed
  bool get otpError => sendOtp?.isFailure ?? false;

  @computed
  PlayerModel get player => registerFuture?.value;

  @computed
  bool get registerLoading => registerFuture?.isPending ?? false;

  @computed
  List<SportModel> get sports => sportFuture?.value;

  @computed
  List<CountryModel> get countries => countryFuture?.value;

  @computed
  List<SportPositionModel> get positions => positionFuture?.value;

  @computed
  List<CategoryModel> get categories => categoryFuture?.value;

  @computed
  List<EmirateModel> get emirates => emirateFuture?.value;

  @computed
  OTPResponseModel get otpCode => verifyOTPFuture?.value ?? false;

  @computed
  bool get verifyOTPLoading => verifyOTPFuture?.isPending ?? false;

  @computed
  bool get forgetPasswordLoading => forgetPasswordFuture?.isPending ?? false;

  @computed
  bool get forgetPasswordError => forgetPasswordFuture?.isFailure ?? false;

  @computed
  File get imageFile => image;

  //* ACTIONS *//

  @action
  void getSports() => sportFuture = futureWrapper(
        () => _authRepository.getSports().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getPostions() => positionFuture = futureWrapper(
        () => _authRepository.getPositions().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getCountries() => countryFuture = futureWrapper(
        () => _authRepository.getCountries().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getCategories() => categoryFuture = futureWrapper(
        () => _authRepository.getCategories().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void getEmirates() => emirateFuture = futureWrapper(
        () => _authRepository.getEmirates().whenSuccess((res) => res.data),
        catchBlock: (err) => showSnack(err, duration: 2.seconds),
      );

  @action
  void login({String userName, String password, String type}) {
    loginFuture = futureWrapper(
      () => _authRepository
          .login(userName: userName, password: password, type: type)
          .whenSuccess((_) => true.apply(() => getContext(
                (context) => context.pushNamedAndRemoveUntil(BasePage.route, (_) => false),
              ))),
      catchBlock: (err) => getContext(
        (context) => showSnack(context.translate('msg_login_error'), duration: 2.seconds),
      ),
    );
  }

  @action
  void sendOTP({
    String email,
    String password,
    bool resend = false,
  }) {
    if (!resend) {
      registerFuture = ObservableFuture.value(PlayerModel.fromUi(email: email, password: password));
    }
    sendOtp = futureWrapper(
      () => _authRepository.sendOTP(email: player.email).whenSuccess(
            (res) => res.apply(() {
              logger.d('otp success with res: $res');
              if (!resend) {
                changeRegisterSlider(const PageSliderForawardModel());
              } else {
                //showSnack()
              }
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
      useLoader: true,
    );
  }

  @action
  void validateEmail({
    String email,
    String password,
  }) {
    validateEmailFuture = futureWrapper(
      () => _authRepository.validateEmail(email: email).whenSuccess(
            (res) => res.apply(() {
              logger.d('otp success with res: $res');
              sendOTP(
                email: email,
                password: password,
              );
            }),
          ),
      catchBlock: (err) => getContext((context) => showSnack(
            context.translate('msg_signUp_error'),
            duration: 2.seconds,
            scaffoldKey: RegisterPage.scaffoldKey,
          )),
      unknownErrorHandler: (err) => getContext((context) => showSnack(
            context.translate('msg_signUp_error'),
            duration: 2.seconds,
            scaffoldKey: RegisterPage.scaffoldKey,
          )),
      useLoader: true,
    );
  }

  @action
  void verifyOTP({int code}) {
    verifyOTPFuture = futureWrapper(
      () => _authRepository.verifyOTP(email: player.email, code: code).whenSuccess(
            (res) => res.data.apply(() async {
              await _authRepository
                  .signUp(email: player.email, password: player.password, code: res.data.data, type: 'PLAYER')
                  .whenSuccess(
                    (_) => changeRegisterSlider(const PageSliderForawardModel()),
                  );
            }),
          ),
      catchBlock: (err) => getContext((context) => showSnack(context.translate('msg_otp_error'), duration: 2.seconds)),
      useLoader: true,
    );
  }

  @action
  void changeRegisterSlider(PageSliderModel pageSliderModel) => registerSliderModel = pageSliderModel;

  @action
  void addPersonalInfo({
    String dateOfBirth,
    String gender,
    String name,
    String phone,
    CountryModel country,
    CategoryModel categoryModel,
  }) {
    registerFuture = futureWrapper(
      () => _authRepository
          .addPersonalInfo(
              version: _prefsRepository.player.version,
              id: _prefsRepository.player.id,
              dateOfBirth: dateOfBirth,
              gender: gender,
              name: name,
              country: country,
              categoryModel: categoryModel,
              phone: phone)
          .whenSuccess(
            (res) => res.data.first.apply(() {
              logger.d('personal info success with res: $res');
              changeRegisterSlider(const PageSliderForawardModel());
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void addAddressInfo({String address, String area, EmirateModel emirateModel}) {
    registerFuture = futureWrapper(
      () => _authRepository
          .addAddressInfo(
            version: registerFuture.value.version,
            id: registerFuture.value.id,
            emirateModel: emirateModel,
            area: area,
            address: address,
          )
          .whenSuccess(
            (res) => res.data.first.apply(() {
              logger.d('address success with res: $res');
              changeRegisterSlider(const PageSliderForawardModel());
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void addSportInfo({
    int weight,
    int height,
    String hand,
    String leg,
    String brief,
    SportModel sport,
    SportPositionModel position,
  }) {
    registerFuture = futureWrapper(
      () => _authRepository
          .addSportInfo(
              version: registerFuture.value.version,
              id: registerFuture.value.id,
              weight: weight,
              height: height,
              hand: hand,
              leg: leg,
              brief: brief,
              sport: sport,
              sportPositionModel: position)
          .whenSuccess(
            (res) => res.data.first.apply(
              () => getContext(
                (context) => context.pushNamedAndRemoveUntil(BasePage.route, (_) => false),
              ),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void forgetPassword({String email}) {
    forgetPasswordFuture = futureWrapper(
      () => _authRepository.forgetPassword(email: email).whenSuccess(
            (res) => res.apply(() {
              logger.d('otp success with res: $res');
              forgetPasswordEmail = email;

              getContext((context) => context.navigator.push(OtpPage.pageRoute(this)));
            }),
          ),
      catchBlock: (err) => getContext((context) => showSnack(
            context.translate('msg_email_not_reg'),
            duration: 2.seconds,
            scaffoldKey: ForgotPasswordPage.scaffoldKey,
          )),
      unknownErrorHandler: (err) => getContext((context) => showSnack(
            context.translate('msg_email_not_reg'),
            duration: 2.seconds,
            scaffoldKey: ForgotPasswordPage.scaffoldKey,
          )),
      useLoader: true,
    );
  }

  @action
  void verifyOTPPassword({int code}) {
    logger.d('otp verify enterre');

    verifyOTPFuture = futureWrapper(
      () => _authRepository.verifyOTP(email: forgetPasswordEmail, code: code).whenSuccess(
            (res) => res.data.apply(() async {
              getContext((context) => context.navigator.push(ResetPasswordPagee.pageRoute(this)));
            }),
          ),
      catchBlock: (err) => getContext((context) => showSnack(
            context.translate('msg_otp_error'),
            duration: 2.seconds,
            scaffoldKey: OtpPage.scaffoldKey,
          )),
      unknownErrorHandler: (err) => getContext((context) => showSnack(
            context.translate('msg_otp_error'),
            duration: 2.seconds,
            scaffoldKey: OtpPage.scaffoldKey,
          )),
      useLoader: true,
    );
  }

  @action
  void resetPassword({String password, String email, int code}) {
    forgetPasswordFuture = futureWrapper(() => _authRepository
        .resetPassword(email: forgetPasswordEmail, code: verifyOTPFuture.value.data, password: password)
        .whenSuccess((res) => apply(() {
              getContext((context) => App.navKey.currentState.pushNamedAndRemoveUntil(AuthPage.route, (_) => false));
            })));
  }

  @action
  // ignore: missing_return
  Future<int> uploadFile({
    File file,
    int fileSize,
    String fileName,
    String fileType,
  }) {
    imageId = _profileRepository
        .uploadFile(file: file, fileSize: fileSize, fileType: fileType, fileName: fileName)
        .then((res) async {
      print('file upoladed');

      await _profileRepository
          .updateImageProfile(imageId: res, version: player.version, id: player.id)
          .whenSuccess((res) => res.data.first.apply(() {
                registerFuture = ObservableFuture.value(res.data.first);
                print('image updated');
              }));
      // updateProfileImage(
      //     id: player.id, version: player.version, imageId: await imageId);
      return res;
    });
  }
}
