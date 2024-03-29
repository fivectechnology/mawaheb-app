import 'dart:io';

import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
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
import 'package:mawaheb_app/features/auth/register/ui/pages/register_page.dart';
import 'package:mawaheb_app/features/auth/subscription/ui/pages/test_subscription.dart';
import 'package:mawaheb_app/features/profile/data/models/subscription_model.dart';
import 'package:mawaheb_app/features/profile/data/models/transaction_model.dart';
import 'package:mawaheb_app/features/profile/data/models/video_model.dart';
import 'package:mawaheb_app/features/profile/domain/repositories/proifile_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';

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
  _AuthViewmodelBase(Logger logger, this._authRepository, this.prefsRepository,
      this._profileRepository)
      : super(logger);

  final AuthRepository _authRepository;
  final PrefsRepository prefsRepository;
  final ProfileRepository _profileRepository;

  //* OBSERVERS *//

  @observable
  File? image;

  String? forgetPasswordEmail;

  @observable
  Future<int>? imageId;

  @observable
  PageSliderModel? registerSliderModel;

  @observable
  PageSliderModel? forgotPasswordSliderModel;

  @observable
  ObservableFuture<bool>? loginFuture;

  @observable
  ObservableFuture<String>? sendOtp;

  @observable
  ObservableFuture<bool>? validateEmailFuture;

  @observable
  ObservableFuture<List<VideoModel>>? fetchVideoFuture;

  @observable
  ObservableFuture<PlayerModel>? registerFuture;

  @observable
  ObservableFuture<List<SportModel>>? sportFuture;

  @observable
  ObservableFuture<List<SportPositionModel>>? positionFuture;

  @observable
  ObservableFuture<List<CategoryModel>>? categoryFuture;

  @observable
  ObservableFuture<List<CountryModel>>? countryFuture;

  @observable
  ObservableFuture<List<EmirateModel>>? emirateFuture;

  @observable
  ObservableFuture<OTPResponseModel>? verifyOTPFuture;

  @observable
  ObservableFuture<bool>? forgetPasswordFuture;

  @observable
  ObservableFuture<bool>? deleteVideoFuture;

  @observable
  ObservableFuture<SubscriptionModel>? subscriptionFuture;

  @observable
  ObservableFuture<TransactionModel>? transactionFuture;

  @observable
  ObservableFuture<bool>? confirmTransactionFuture;

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
  bool get otpVerifyError => verifyOTPFuture?.isFailure ?? false;

  @computed
  PlayerModel? get player => registerFuture?.value;

  @computed
  bool get registerLoading => registerFuture?.isPending ?? false;

  @computed
  List<SportModel>? get sports => sportFuture?.value;

  @computed
  List<CountryModel>? get countries => countryFuture?.value;

  @computed
  List<SportPositionModel>? get positions => positionFuture?.value;

  @computed
  List<CategoryModel>? get categories => categoryFuture?.value;

  @computed
  List<EmirateModel>? get emirates => emirateFuture?.value;

  @computed
  OTPResponseModel get otpCode =>
      verifyOTPFuture?.value ?? false as OTPResponseModel;

  @computed
  bool get verifyOTPLoading => verifyOTPFuture?.isPending ?? false;

  @computed
  bool get forgetPasswordLoading => forgetPasswordFuture?.isPending ?? false;

  @computed
  bool get forgetPasswordError => forgetPasswordFuture?.isFailure ?? false;

  @computed
  List<VideoModel> get videos => fetchVideoFuture?.value ?? [];

  @computed
  bool get videosLoading => fetchVideoFuture?.isPending ?? false;

  @computed
  SubscriptionModel? get subscription => subscriptionFuture?.value;

  @computed
  TransactionModel? get transaction => transactionFuture?.value;

  @computed
  bool get transactionLoading => confirmTransactionFuture?.isPending ?? false;

  @computed
  bool get transactionError => confirmTransactionFuture?.isFailure ?? false;

  @computed
  bool get positionsLoading => positionFuture?.isPending ?? false;

  @computed
  bool get sportLoading => sportFuture?.isPending ?? false;

  @computed
  File? get imageFile => image;

  @computed
  bool get deleteVideoLoading => deleteVideoFuture?.isPending ?? false;

  @computed
  bool get deleteVideoError => deleteVideoFuture?.isFailure ?? false;

  @computed
  String? get otpCodeMessage {
    final value = sendOtp?.value;
    if (value != null) {
      return ' ' + value.substring(value.length - 4);
    }
    return null;
  }

  //* ACTIONS *//

  @action
  void getSports() => sportFuture = futureWrapper(
        () => _authRepository.getSports().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getPositions({int? sportId}) => positionFuture = futureWrapper(
        () => _authRepository
            .getPositions(sportId: sportId)
            .whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getCountries() => countryFuture = futureWrapper(
        () => _authRepository.getCountries().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getCategories() => categoryFuture = futureWrapper(
        () => _authRepository.getCategories().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getEmirates() => emirateFuture = futureWrapper(
        () => _authRepository.getEmirates().whenSuccess((res) => res!.data!),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void getSubscription() => subscriptionFuture = futureWrapper(
        () => _authRepository
            .getSubscription()
            .whenSuccess((res) => res!.data!.first),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      );

  @action
  void login(
      {required String userName,
      required String password,
      required String type}) {
    loginFuture = futureWrapper(
      () => _authRepository
          .login(userName: userName, password: password, type: type)
          .whenSuccess((_) => true.apply(() => getContext((context) {
                logger.d(
                    'my debug user status ${prefsRepository.player?.status}');
                // context.pushNamedAndRemoveUntil(BasePage.route, (_) => false);

                if (prefsRepository.player?.status == 'INACTIVE') {
                  context.pushNamed(RegisterPage.route, arguments: this);
                } else {
                  context.pushNamedAndRemoveUntil(BasePage.route, (_) => false);
                }
              }))),
      catchBlock: (err) => getContext(
        (context) => showSnack(context.translate('msg_login_error'),
            duration: 2.seconds),
      ),
    );
  }

  @action
  void sendOTP({
    String? email,
    String? password,
    bool resend = false,
  }) {
    if (!resend) {
      registerFuture = ObservableFuture.value(
          PlayerModel.fromUi(email: email, password: password));
    }
    sendOtp = futureWrapper(
      () => _authRepository.sendOTP(email: player?.email ?? email).whenSuccess(
            (res) => res?.apply(() {
              logger.d('otp success with res: $res');
              if (!resend) {
                changeRegisterSlider(const PageSliderForawardModel());
                changeForgotPasswordSlider(const PageSliderForawardModel());
              } else {
                //showSnack()
              }
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
      useLoader: true,
    );
  }

  @action
  void validateEmail({
    String? email,
    String? password,
  }) {
    validateEmailFuture = futureWrapper(
      () => _authRepository.validateEmail(email: email).whenSuccess(
            (res) => res?.apply(() {
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
  void verifyOTP({int? code}) {
    verifyOTPFuture = futureWrapper(
      () => _authRepository
          .verifyOTP(email: player!.email, code: code)
          .whenSuccess(
        (res) async {
          await _authRepository
              .signUp(
                  email: player!.email!,
                  password: player!.password!,
                  code: res!.data.data!,
                  type: 'PLAYER')
              .whenSuccess(
                (_) => changeRegisterSlider(const PageSliderForawardModel()),
              );

          return res.data;
        },
      ),
      catchBlock: (err) {
        getContext((context) {
          showSnack(
            context.translate('msg_otp_error'),
            duration: 2.seconds,
            scaffoldKey: ForgotPasswordPage.scaffoldKey,
          );
          // showSnack(
          //   context.translate('msg_otp_error'),
          //   duration: 2.seconds,
          //   scaffoldKey: RegisterPage.scaffoldKey,
          // );
        });
        // throw Exception('');
      },
      unknownErrorHandler: (err) => getContext((context) {
        showSnack(
          context.translate('msg_otp_error'),
          duration: 2.seconds,
          scaffoldKey: ForgotPasswordPage.scaffoldKey,
        );
        // showSnack(
        //   context.translate('msg_otp_error'),
        //   duration: 2.seconds,
        //   scaffoldKey: RegisterPage.scaffoldKey,
        // );
      }),
      useLoader: true,
    );
  }

  @action
  void changeRegisterSlider(PageSliderModel pageSliderModel) =>
      registerSliderModel = pageSliderModel;

  @action
  void changeForgotPasswordSlider(PageSliderModel pageSliderModel) =>
      forgotPasswordSliderModel = pageSliderModel;

  @action
  void addPersonalInfo({
    String? dateOfBirth,
    String? gender,
    String? name,
    String? phone,
    CountryModel? country,
    CategoryModel? categoryModel,
  }) {
    registerFuture = futureWrapper(
      () => _authRepository
          .addPersonalInfo(
              version: prefsRepository.player!.version,
              id: prefsRepository.player!.id,
              dateOfBirth: dateOfBirth,
              gender: gender,
              name: name,
              country: country,
              categoryModel: categoryModel,
              phone: phone)
          .whenSuccess(
            (res) => res!.data!.first.apply(() {
              logger.d('personal info success with res: $res');
              changeRegisterSlider(const PageSliderForawardModel());
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void addAddressInfo(
      {String? address, String? area, EmirateModel? emirateModel}) {
    registerFuture = futureWrapper(
      () => _authRepository
          .addAddressInfo(
            version: registerFuture!.value!.version,
            id: registerFuture!.value!.id,
            emirateModel: emirateModel,
            area: area,
            address: address,
          )
          .whenSuccess(
            (res) => res!.data!.first.apply(() {
              logger.d('address success with res: $res');
              changeRegisterSlider(const PageSliderForawardModel());
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void addSportInfo({
    int? weight,
    int? height,
    String? hand,
    String? leg,
    String? brief,
    SportModel? sport,
    SportPositionModel? position,
  }) {
    registerFuture = futureWrapper(
      () => _authRepository
          .addSportInfo(
              version: registerFuture!.value!.version,
              id: registerFuture!.value!.id,
              weight: weight,
              height: height,
              hand: hand,
              leg: leg,
              brief: brief,
              sport: sport,
              sportPositionModel: position)
          .whenSuccess(
            (res) => res!.data!.first.apply(() {
              prefsRepository.setPlayer(res.data!.first);
              if (subscription!.amount == 0) {
                print('debug subscription player ${subscription!.amount}');
                _authRepository
                    .subscriptionPlayer(
                        playerId: res.data!.first.id,
                        subscriptionId: subscription!.id)
                    .whenSuccess((res) => getContext(
                          (context) => context.pushNamedAndRemoveUntil(
                              BasePage.route, (_) => false),
                        ));
              } else {
                _authRepository
                    .subscriptionPlayer(
                        playerId: res.data!.first.id,
                        subscriptionId: subscription!.id)
                    .whenSuccess((res) => getContext(
                          (context) => context.pushNamed(SubscriptionPage.route,
                              arguments: this),
                        ));
              }
            }

                //   getContext(
                // (context) => context.pushNamedAndRemoveUntil(
                //     BasePage.route, (_) => false),
                ),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void forgetPassword({String? email}) {
    forgetPasswordFuture = futureWrapper(
      () => _authRepository.forgetPassword(email: email).whenSuccess(
            (res) => res?.apply(() {
              logger.d('otp success with res: $res');
              forgetPasswordEmail = email;

              changeForgotPasswordSlider(const PageSliderForawardModel());
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
  void verifyOTPPassword({int? code}) {
    logger.d('otp verify enterre');

    verifyOTPFuture = futureWrapper(
      () => _authRepository
          .verifyOTP(email: forgetPasswordEmail, code: code)
          .whenSuccess(
            (res) => res?.data.apply(() async {
              // getContext((context) => context.navigator.push(ResetPasswordPagee.pageRoute(this)));
              changeForgotPasswordSlider(const PageSliderForawardModel());
            }),
          ),
      catchBlock: (err) {
        getContext((context) {
          // showSnack(
          //   context.translate('msg_otp_error'),
          //   duration: 2.seconds,
          //   scaffoldKey: RegisterPage.scaffoldKey,
          // );
          showSnack(
            context.translate('msg_otp_error'),
            duration: 2.seconds,
            scaffoldKey: ForgotPasswordPage.scaffoldKey,
          );
        });
      },
      unknownErrorHandler: (err) {
        getContext((context) {
          showSnack(
            context.translate('msg_otp_error'),
            duration: 2.seconds,
            scaffoldKey: RegisterPage.scaffoldKey,
          );
          showSnack(
            context.translate('msg_otp_error'),
            duration: 2.seconds,
            scaffoldKey: ForgotPasswordPage.scaffoldKey,
          );
        });
      },
      useLoader: true,
    );
  }

  @action
  void resetPassword({String? password, String? email, int? code}) {
    forgetPasswordFuture = futureWrapper(
      () => _authRepository
          .resetPassword(
              email: forgetPasswordEmail,
              code: verifyOTPFuture!.value!.data,
              password: password)
          .whenSuccess((res) => res?.apply(() {
                // getContext((context) => App.navKey.currentState.pushNamedAndRemoveUntil(AuthPage.route, (_) => false));
                getContext((context) => App.navKey.currentState!.pop());
              })),
      useLoader: true,
    );
  }

  @action
  // ignore: missing_return
  Future<int>? uploadFile({
    int? playerId,
    int? playerVersion,
    File? file,
    int? fileSize,
    String? fileName,
    String? fileType,
  }) {
    imageId = _profileRepository.uploadFile(file: file).then((res1) async {
      final res = res1.getOrThrow();
      print('file upoladed');

      await _profileRepository
          .updateImageProfile(
              imageId: res, version: playerVersion! + 1, id: playerId)
          .whenSuccess((res) => res?.data!.first.apply(() {
                registerFuture = ObservableFuture.value(res.data!.first);
                print('image updated');
              }));
      // updateProfileImage(
      //     id: player.id, version: player.version, imageId: await imageId);
      return res;
    });
  }

  @action
  // ignore: missing_return
  Future<int>? uploadVideo({
    File? file,
    int? fileSize,
    String? fileName,
    String? fileType,
    int? videoVersion,
    int? videoId,
    bool? withDelete,
  }) {
    imageId = _profileRepository.uploadFile(file: file).then((res1) async {
      final res = res1.getOrThrow();
      await _profileRepository
          .uploadVideoPlayer(playerId: player!.id, videoId: res)
          .whenSuccess((res) => apply(() {
                getContext((context) => showSnack(
                    context.translate('msg_video_uploaded'),
                    scaffoldKey: RegisterPage.scaffoldKey,
                    duration: 2.seconds));
                fetchVideos(playerId: player!.id);
                Navigator.of(RegisterPage.keyLoader.currentContext!,
                        rootNavigator: true)
                    .pop();
              }));

      return res;
    });
  }

  @action
  void deleteVideo({int? videoVersion, int? videoId}) {
    deleteVideoFuture = futureWrapper(
      () => _profileRepository
          .deleteVideoPlayer(
            videoId: videoId,
            videoVersion: player!.id,
          )
          .whenSuccess(
            (res) => res?.apply(() {
              getContext((context) => showSnack(
                  context.translate('msg_video_deleted'),
                  scaffoldKey: RegisterPage.scaffoldKey,
                  duration: 2.seconds));
              fetchVideos(playerId: player!.id);
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void fetchVideos({int? playerId}) {
    fetchVideoFuture = futureWrapper(
      () => _profileRepository
          .fetchPlayerVideos(playerId: playerId)
          .whenSuccess((res) => res?.data ?? []),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  Future<void> clearUserData() async {
    await prefsRepository.clearUserData();
  }

  @action
  void playerTransaction() {
    transactionFuture = futureWrapper(
      () => _authRepository
          .playerTransaction(playerId: player!.id, amount: subscription!.amount)
          .whenSuccess(
            (res) => res?.data!.first.apply(() {
              print('5.2');
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }

  @action
  void confirmTransaction() {
    confirmTransactionFuture = futureWrapper(
      () => _authRepository
          .confirmTransaction(
              transactionId: transaction!.id,
              transactionVersion: transaction!.version)
          .whenSuccess(
            (res) => res?.apply(() {
              getContext(
                (context) => context.pushNamedAndRemoveUntil(
                    BasePage.route, (_) => false),
              );
            }),
          ),
      catchBlock: (err) => showSnack(err!, duration: 2.seconds),
    );
  }
}
