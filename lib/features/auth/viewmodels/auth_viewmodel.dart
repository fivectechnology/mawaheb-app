import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:core_sdk/utils/extensions/object.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/add_sport_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/address_info_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/player_info_page.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';

part 'auth_viewmodel.g.dart';

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
      () => _authRepository
          .login(userName: userName, password: password)
          .whenSuccess(
            (res) => res.apply(
              () => getContext(
                (context) => context.pushNamedAndRemoveUntil(
                    BasePage.route, (_) => false),
              ),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void signUp({String username, String email, String password}) {
    registerFuture = futureWrapper(
      () => _authRepository
          .signUp(
              userName: username,
              email: email,
              password: password,
              code: username + '123')
          .whenSuccess((res) => res.data.first)
          .whenComplete(() => getContext(
                    (context) => context.pushPage(const PlayerInfoPage()),
                  )
              // => res.apply(
              //       () => getContext(
              //         (context) => context.pushPage(const PlayerInfoPage()),
              //       ),
              //     ),
              ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void addPersonalInfo(
      {String dateOfBirth,
      String gender,
      String name,
      String phone,
      CountryModel country,
      CategoryModel categoryModel}) {
    registerFuture = futureWrapper(
      () => _authRepository
          .addPersonalInfo(
              version: player.version,
              id: player.id,
              dateOfBirth: dateOfBirth,
              gender: gender,
              name: name,
              country: country,
              categoryModel: categoryModel,
              phone: phone)
          .whenSuccess(
            (res) => res.apply(
              () => getContext(
                (context) => context.pushPage(const AddressInfoPage()),
              ),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void addAddressInfo(
      {String address, String area, EmirateModel emirateModel}) {
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
            (res) => res.apply(
              () => getContext(
                (context) => context.pushPage(const AddSportPage()),
              ),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }

  @action
  void addSportInfo(
      {String weight,
      String height,
      String hand,
      String leg,
      SportModel sport,
      SportPositionModel position}) {
    registerFuture = futureWrapper(
      () => _authRepository
          .addSportInfo(
              version: registerFuture.value.version,
              id: registerFuture.value.id,
              weight: weight,
              height: height,
              hand: hand,
              leg: leg,
              sport: sport,
              sportPositionModel: position)
          .whenSuccess(
            (res) => res.apply(
              () => getContext(
                (context) => context.pushPage(const BasePage()),
              ),
            ),
          ),
      catchBlock: (err) => showSnack(err, duration: 2.seconds),
    );
  }
}
