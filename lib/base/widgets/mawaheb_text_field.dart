import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class MawahebTextField extends StatefulWidget {
  const MawahebTextField(
      {Key key,
      this.hintText,
      this.onChanged,
      this.isSuffixIcon,
      this.initialValue,
      this.context,
      this.hintColor,
      this.textEditingController,
      this.useObscure = false,
      this.onTab,
      this.focusNode,
      this.validator})
      : super(key: key);

  final String hintText;
  final bool useObscure;
  final bool isSuffixIcon;
  final BuildContext context;
  final Color hintColor;
  final Function onChanged;
  final String Function(String) validator;
  final TextEditingController textEditingController;
  final String initialValue;
  final Function onTab;
  final FocusNode focusNode;

  @override
  _MawahebTextFieldState createState() => _MawahebTextFieldState();
}

class _MawahebTextFieldState extends State<MawahebTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onTap: widget.onTab,
      // ignore: avoid_bool_literals_in_conditional_expressions
      obscureText: widget.useObscure ? !showPassword : false,
      validator: widget.validator,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        hintText: context.translate(widget.hintText),
        hintStyle: TextStyle(
            color: widget.hintColor ?? Colors.black,
            fontWeight: FontWeight.w200,
            fontFamily: 'Poppins'),
        suffixIcon: widget.isSuffixIcon == true
            ? IconButton(
                onPressed: () => setState(
                    () => showPassword = !showPassword), //widget.onPressed,
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black),
              )
            : null,
      ),
    );
  }
}

// Widget mawahebTextField({
//   String hintText,
//   bool isSuffixIcon,
//   Function onPressed,
//   bool showPassword,
//   BuildContext context,
//   Color hintColor,
//   TextEditingController textEditingController,
// }) {
//   return TextFormField(
//     // ignore: avoid_bool_literals_in_conditional_expressions
//     obscureText: showPassword == null ? false : !showPassword,

//     controller: textEditingController,
//     decoration: InputDecoration(
//       enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//       hintText: context.translate(hintText),
//       hintStyle: TextStyle(color: hintColor ?? Colors.black, fontWeight: FontWeight.w200, fontFamily: 'Poppins'),
//       suffixIcon: isSuffixIcon == true
//           ? IconButton(
//               onPressed: onPressed,
//               icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility, color: Colors.black),
//             )
//           : null,
//     ),
//   );
// }
