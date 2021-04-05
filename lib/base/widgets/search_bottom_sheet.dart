import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'mawaheb_button.dart';

void searchModalBottomSheet(
    {BuildContext context, String title, Function onPress, List list}) {
  showMaterialModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SizedBox(
            height: context.fullHeight * 0.9,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.fullWidth * 0.08,
                  vertical: context.fullHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.translate(title),
                    style: context.textTheme.headline1
                        .copyWith(fontSize: 20, letterSpacing: 0.2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.fullHeight * 0.02),
                    child: SizedBox(
                      height: context.fullHeight * 0.06,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: context.translate('lbl_search_sport'),
                            hintStyle: context.textTheme.bodyText1
                                .copyWith(color: Colors.grey, fontSize: 12),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.fullHeight * 0.6,
                    child: ListView.builder(
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.fullHeight * 0.02),
                              child: Text(
                                'Sport Name',
                                style: context.textTheme.bodyText1,
                              ),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: MawahebButton(
                        textColor: Colors.white,
                        buttonColor: Colors.grey[300],
                        borderColor: Colors.white,
                        text: 'lbl_add',
                        onPressed: onPress,
                        context: context,
                      ),
                    ),
                  )
                ],
              ),
            ));
      });
}
