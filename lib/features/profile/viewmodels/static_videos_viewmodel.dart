import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:core_sdk/utils/extensions/string.dart';
import 'package:supercharged/supercharged.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';

part 'static_videos_viewmodel.g.dart';

@injectable
class StaticVideosViewmodel extends _StaticVideosViewmodelBase with _$StaticVideosViewmodel {
  StaticVideosViewmodel(
    Logger logger,
  ) : super(logger);
}

abstract class _StaticVideosViewmodelBase extends BaseViewmodel with Store {
  _StaticVideosViewmodelBase(Logger logger) : super(logger);

  //* OBSERVERS *//

  @observable
  String videoUrl = 'https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_5MB.mp4';

  //* COMPUTED *//
  @computed
  bool get canPlay => !videoUrl.isNullOrEmpty;

  //* ACTIONS *//
  @action
  void changeUrl(String url) {
    videoUrl = url;
  }
}
