import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class MawahebTextField extends StatefulWidget {
  const MawahebTextField(
      {Key? key,
      this.hintText,
      this.onChanged,
      this.isSuffixIcon,
      this.initialValue,
      this.context,
      this.hintColor,
      this.textEditingController,
      this.useObscure = false,
      this.onTab,
      this.keyboardType,
      this.focusNode,
      this.validator})
      : super(key: key);

  final String? hintText;
  final bool useObscure;
  final bool? isSuffixIcon;
  final BuildContext? context;
  final Color? hintColor;
  final Function? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final String? initialValue;
  final Function? onTab;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;

  @override
  _MawahebTextFieldState createState() => _MawahebTextFieldState();
}

class _MawahebTextFieldState extends State<MawahebTextField> {
  bool showPassword = false;
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType ?? TextInputType.text,
      focusNode: widget.focusNode ?? _focusNode,
      onTap: widget.onTab as void Function()?,
      // ignore: avoid_bool_literals_in_conditional_expressions
      obscureText: widget.useObscure ? !showPassword : false,
      validator: widget.validator,
      onChanged: widget.onChanged as void Function(String)?,
      initialValue: widget.initialValue,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        labelText: context.translate(widget.hintText!),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        labelStyle: TextStyle(
            height: 0.5,
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

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
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
