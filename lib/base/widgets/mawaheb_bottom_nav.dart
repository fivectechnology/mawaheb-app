import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';

class MawahebBottomNavigationBar extends StatelessWidget {
  const MawahebBottomNavigationBar({Key? key, required this.appViewModel})
      : super(key: key);

  final AppViewmodel? appViewModel;

  @override
  Widget build(BuildContext context) {
    final bool isPlayer = appViewModel!.isPlayer;
    return Observer(
      builder: (_) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: WHITE,
          currentIndex: appViewModel!.pageIndex.index,
          onTap: (int index) =>
              appViewModel!.navigateTo(PageIndex.values[index]),
          selectedLabelStyle: const TextStyle(
            fontSize: 12.0,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 10.0),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: GREY,
          items: [
            bottomNavigationBarTile(
              title:
                  context.translate(getBottomTitle(PageIndex.home, isPlayer)),
              index: PageIndex.home.index,
              icon: appViewModel!.isPlayer
                  ? 'assets/icons/ic_profile.svg'
                  : 'assets/icons/ic_profile.svg',
              activeIcon: appViewModel!.isPlayer
                  ? 'assets/icons/ic_active_profile.svg'
                  : 'assets/icons/ic_active_profile.svg',
            ),
            bottomNavigationBarTile(
              title: context
                  .translate(getBottomTitle(PageIndex.notifications, isPlayer)),
              index: PageIndex.notifications.index,
              // icon: 'assets/icons/ic_notification.svg',
              // activeIcon: 'assets/icons/ic_notification.svg',
              child: navigationButtonWithCount(
                PageIndex.notifications.index,
                count: appViewModel!.notificationsCount,
                icon: 'assets/icons/ic_notification.svg',
              ),
              activeChild: navigationButtonWithCount(
                PageIndex.notifications.index,
                count: appViewModel!.notificationsCount,
                icon: 'assets/icons/ic_notification.svg',
              ),
            ),
            bottomNavigationBarTile(
              title: context
                  .translate(getBottomTitle(PageIndex.public_info, isPlayer)),
              index: PageIndex.public_info.index,
              child: const Icon(Icons.info, size: 20.0, color: GREY),
              activeChild:
                  const Icon(Icons.info, size: 20.0, color: Colors.black),
            ),
            bottomNavigationBarTile(
              title: context
                  .translate(getBottomTitle(PageIndex.settings, isPlayer)),
              index: PageIndex.settings.index,
              icon: 'assets/icons/ic_setting.svg',
              activeIcon: 'assets/icons/ic_setting.svg',
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavigationBarTile({
    required String title,
    required int index,
    String? icon,
    Widget? child,
    String? activeIcon,
    Widget? activeChild,
  }) {
    return BottomNavigationBarItem(
      backgroundColor: WHITE,
      icon: addPadding(
        child ??
            SvgPicture.asset(
              icon!,
              width: 24.0,
              height: 20.0,
              fit: BoxFit.cover,
              color:
                  appViewModel!.pageIndex.index == index ? Colors.black : GREY,
            ),
      ),
      activeIcon: addPadding(
        activeChild ??
            SvgPicture.asset(
              activeIcon!,
              width: 24.0,
              height: 20.0,
              fit: BoxFit.cover,
              color:
                  appViewModel!.pageIndex.index == index ? Colors.black : GREY,
            ),
      ),
      label: title,
    );
  }

  Widget addPadding(Widget child) =>
      Padding(padding: const EdgeInsets.only(top: 2.0), child: child);

  Widget navigationButtonWithCount(int index,
      {required String icon, required int count}) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: const Alignment(0.35, -2),
            children: [
              Center(
                child: SvgPicture.asset(
                  icon,
                  width: 24.0,
                  height: 20.0,
                  fit: BoxFit.cover,
                  color: appViewModel!.pageIndex.index == index
                      ? Colors.black
                      : GREY,
                ),
              ),
              if (count > 0)
                Container(
                  width: count > 10 ? 19.0 : 18.0,
                  height: count > 10 ? 19.0 : 18.0,
                  // width: count > 10 ? 19.0 : 18.0,
                  // height: count > 10 ? 19.0 : 18.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: RED.withOpacity(0.9)),
                  child: Center(
                    child: Text(
                      count > 10 ? '+10' : count.toString(),
                      style: TextStyle(
                        color: WHITE,
                        fontSize: count > 10 ? 8.0 : 10.0,
                        fontWeight:
                            count > 10 ? FontWeight.w400 : FontWeight.bold,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
