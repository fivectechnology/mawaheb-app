import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
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
  ) : super(logger, authRepository);
}

abstract class _AuthViewmodelBase extends BaseViewmodel with Store {
  _AuthViewmodelBase(Logger logger, this._authRepository) : super(logger);

  final AuthRepository _authRepository;

  //* OBSERVERS *//

  @observable
  PageSliderModel registerSliderModel;

  @observable
  ObservableFuture<bool> loginFuture;

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
  ObservableFuture<String> otpFuture;

  @observable
  ObservableFuture<int> verifyOTPFuture;

  //* COMPUTED *//

  @computed
  bool get loginLoading => loginFuture?.isPending ?? false;

  @computed
  bool get loginError => loginFuture?.isFailure ?? false;

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
  bool get otpLoading => otpFuture?.isPending ?? false;

  @computed
  bool get otpError => otpFuture?.isFailure ?? false;

  @computed
  int get otpCode => verifyOTPFuture?.value ?? false;

  @computed
  bool get verifyOTPLoading => verifyOTPFuture?.isPending ?? false;

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
  void login({String userName, String password}) {
    loginFuture = futureWrapper(
      () => _authRepository.login(userName: userName, password: password).whenSuccess(
            (res) => res.apply(
              () => getContext(
                (context) => context.pushNamedAndRemoveUntil(BasePage.route, (_) => false),
              ),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void sendOTP({
    String name,
    String email,
    String password,
    bool resend = false,
  }) {
    if (!resend) {
      registerFuture = ObservableFuture.value(PlayerModel.fromUi(email: email, name: name, password: password));
    }
    otpFuture = futureWrapper(
      () => _authRepository.sendOTP(email: player.email).whenSuccess(
            (res) => res.data.apply(() {
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
  void verifyOTP({int code}) {
    print('my debug asdfasdfasf');
    logger.d('otp verify enterre');

    verifyOTPFuture = futureWrapper(
      () => _authRepository.verifyOTP(email: player.email, code: code).whenSuccess(
            (res) => res.apply(() async {
              logger.d('otp verify success with res: $res');
              await _authRepository.signUp(
                displayName: player.name,
                email: player.email,
                password: player.password,
                code: res.data.toString(),
              );
              await _authRepository.login(userName: player.email, password: player.password);
              changeRegisterSlider(const PageSliderForawardModel());
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
      useLoader: true,
    );
  }

  @action
  void signUp({String displayName, String email, String password, String code}) {
    registerFuture = futureWrapper(
      () => _authRepository
          .signUp(
            displayName: displayName,
            email: email,
            password: password,
            code: code,
          )
          .whenSuccess(
            (res) => res.data.first.apply(() {
              logger.d('signUp success with res: $res');
              changeRegisterSlider(const PageSliderForawardModel());
            }),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
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
              version: registerFuture.value.version,
              id: registerFuture.value.id,
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
  void addSportInfo(
      {int weight, int height, String hand, String leg, String brief, SportModel sport, SportPositionModel position}) {
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
}
