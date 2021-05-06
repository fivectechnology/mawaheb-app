import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class DownlaodButton extends StatefulWidget {
  const DownlaodButton({
    Key key,
    @required this.viewmodel,
    @required this.id,
    @required this.parentId,
  }) : super(key: key);

  final PublicInfoViewmodel viewmodel;
  final int id;
  final int parentId;

  @override
  _DownlaodButtonState createState() => _DownlaodButtonState();
}

class _DownlaodButtonState extends State<DownlaodButton> {
  int progress;
  bool get isLoading => progress != null;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: isLoading
          ? null
          : () {
              widget.viewmodel.downloadFile(
                id: widget.id,
                parentId: widget.parentId,
                onReceiveProgress: (int progress) {
                  setState(() {
                    this.progress = progress;
                  });
                },
                onSuccess: (filePath) {
                  setState(() {
                    progress = null;
                  });
                },
              );
            },
      color: YELLOW,
      disabledColor: LIGHT_GREY,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            progress == null ? context.translate('lbl_download') : context.translate('lbl_downloading'),
            style: context.textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ProgressBar(
            visibility: isLoading,
            padding: 8.0,
            color: WHITE,
          ),
        ],
      ),
    );
  }
}
