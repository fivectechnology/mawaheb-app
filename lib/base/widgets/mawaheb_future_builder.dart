import 'package:core_sdk/error/failures.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/widgets/mobx_future_builder.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:core_sdk/utils/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mobx/mobx.dart';

class MawahebFutureBuilder<T> extends StatelessWidget {
  const MawahebFutureBuilder({
    Key? key,
    required this.future,
    required this.onSuccess,
    required this.onRetry,
    this.onError,
    this.onLoading,
  }) : super(key: key);

  final ObservableFuture<T>? future;
  final Widget Function(T?) onSuccess;
  final Widget Function(dynamic)? onError;
  final Widget Function()? onLoading;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MobxFutureBuilder(
      future: future!,
      onSuccess: onSuccess,
      onError: onError ??
          ((err) => ErrorView(
                errorMessage: context.translate(getErrorMessage(err)!),
                onRetry: onRetry,
              )),
      onLoading: onLoading ?? () => const Center(child: MawahebLoader()),
    );
  }

  String? getErrorMessage(dynamic error) {
    if (error is CallException && error.cause is NetworkFailure)
      return 'msg_no_internet';
    else if (error is CallException && error.cause is ServerFailure)
      return error.cause.message;
    else
      return 'msg_something_wrong';
  }
}
