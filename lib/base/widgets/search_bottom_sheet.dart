import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchBottomSheet<T extends Object> extends StatefulWidget {
  const SearchBottomSheet({
    Key? key,
    required this.items,
    required this.title,
    required this.hintText,
  }) : super(key: key);

  static Future<T?> show<T extends Object>(
    BuildContext context, {
    required List<T> items,
    required String title,
    required String hintText,
  }) =>
      showMaterialModalBottomSheet(
        context: context,
        builder: (_) => SearchBottomSheet<T>(hintText: hintText, items: items, title: title),
      );

  final List<T> items;
  final String title;
  final String hintText;

  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState<T extends Object> extends State<SearchBottomSheet<T>> {
  late List<T> results;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    results = widget.items;
    _controller.addListener(() {
      filter(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.fullHeight * 0.9,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.translate(widget.title), style: context.textTheme.headline1),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: context.translate(widget.hintText),
                      hintStyle: context.textTheme.bodyText1!.copyWith(color: Colors.grey, fontSize: 12),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                        gapPadding: 0.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                        gapPadding: 0.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: results
                    .map(
                      (e) => InkWell(
                        onTap: () => context.pop<T>(e),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(e.toString(), style: context.textTheme.bodyText1),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            // Expanded(
            //   child: Align(
            //     alignment: FractionalOffset.bottomCenter,
            //     child: MawahebButton(
            //       textColor: Colors.white,
            //       buttonColor: Colors.grey[300],
            //       borderColor: Colors.white,
            //       text: 'lbl_add',
            //       onPressed: onPress,
            //       context: context,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void filter(String query) {
    List<T> finalResult;
    if (query.isNullOrEmpty) {
      finalResult = widget.items;
    } else {
      finalResult = widget.items.where((element) => element.toString().contains(query)).toList();
    }

    setState(() => results = finalResult);
  }
}
