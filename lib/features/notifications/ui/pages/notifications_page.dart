import 'package:core_sdk/utils/app_localizations.dart';
import 'package:core_sdk/utils/constants.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/pagination_mixin.dart';
import 'package:core_sdk/utils/widgets/pagination_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/notifications/data/models/notification_model.dart';
import 'package:mawaheb_app/features/notifications/viewmodels/notifications_viewmodel.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    Key key,
  }) : super(key: key);

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const NotificationsPage());

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends MobxState<NotificationsPage, NotificationsViewmodel> with PaginationMixin {
  @override
  void initState() {
    super.initState();
    initPagination();
    viewmodel.getnotifications(fresh: true);
  }

  @override
  void dispose() {
    disposePagination();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     key: viewmodel.scaffoldKey,
  //     backgroundColor: Colors.white,
  //     body: MawahebFutureBuilder(
  //       future: viewmodel.notificationsFuture,
  //       onRetry: () => viewmodel.getnotifications(fresh: true),
  //       onSuccess: (ListBaseResponseModel<NotificationModel> notifications) {
  //         return PaginationList<NotificationModel>(
  //           canLoadMore: viewmodel.canLoadMoreNotifications,
  //           dataList: notifications.data,
  //           scrollController: scrollController,
  //           padding: 0,
  //           emptyWidget: Center(child: Text(context.translate('lbl_empty_notifications'))),
  //           cardBuilder: (notification) => notificationTile(
  //             body: notification.message,
  //             title: notification.subject,
  //             date: dateFormatter(notification.sendDate, AppLocalizations.of(context)),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  void onLoadMore() => viewmodel.getnotifications();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(context.fullHeight * 0.01),
          itemCount: 10,
          itemBuilder: (context, index) {
            return notificationTile(body: null, date: null, title: null);
          }),
    );
  }

  Widget notificationTile({
    @required String title,
    @required String body,
    @required String date,
  }) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? 'club Name',
            style: textTheme.headline1.copyWith(fontSize: 12, letterSpacing: 0.3),
          ),
          Text(
            date ?? '9:45AM',
            style: textTheme.bodyText1.copyWith(color: Colors.grey, fontSize: 10),
          )
        ],
      ),
      subtitle: Text(
        body ?? 'Club name booked you',
        style: textTheme.headline6.copyWith(fontSize: 12),
      ),
    );
  }
}

String dateFormatter(String dateStr, AppLocalizations localizations) {
  if (dateStr == null || dateStr.isEmpty) {
    return '';
  }
  final date = DateTime.parse(dateStr);
  final diff = DateTime.now().difference(date);
  final locale = localizations.locale.languageCode == LANGUAGE_ARABIC ? 'ar_AR' : 'en_US';
  final bool isArabic = localizations.locale.languageCode == LANGUAGE_ARABIC;
  if (diff.inMinutes <= 59)
    return diff.inMinutes > 1
        ? isArabic
            ? '${localizations.translate('lbl_ago')} ${diff.inMinutes} ${localizations.translate('lbl_minutes')}'
            : '${diff.inMinutes} ${localizations.translate('lbl_minutes_ago')}'
        : localizations.translate('lbl_just_now');
  else if (diff.inHours < 24)
    return diff.inHours > 1
        ? isArabic
            ? '${localizations.translate('lbl_ago')} ${diff.inHours} ${localizations.translate('lbl_houre')}'
            : '${diff.inHours} ${localizations.translate('lbl_hours_ago')}'
        : localizations.translate('lbl_an_hour_ago');
  else if (diff.inDays <= 7)
    return '${DateFormat.EEEE(locale).format(date)} ${localizations.translate('lbl_time_at')} ${DateFormat.jm(locale).format(date)}';
  return '${DateFormat.d(locale).add_MMM().format(date)} ${localizations.translate('lbl_time_at')} ${DateFormat.jm(locale).format(date)}';
}
