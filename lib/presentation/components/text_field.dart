import 'package:flutter/material.dart';
import 'package:social/data/models/user.dart';

import '../../const/Pallet.dart';

class AppTextField extends StatelessWidget {
  AppTextField({
    Key? key,
    required this.emailController,
    required this.validator,
    this.obscureText = false,
    required this.title,
  }) : super(key: key);

  final TextEditingController emailController;
  final FormFieldValidator<String> validator;
  final String title;
  bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: Pallet.Shado),
        focusedBorder: textBorder,
        enabledBorder: textBorder,
      ),
      validator: validator,
      obscureText: obscureText,
      controller: emailController,
    );
  }

  OutlineInputBorder textBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Pallet.Shado.withOpacity(0.5),
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
  );
}

class ProfileEditingTextField extends StatelessWidget {
  ProfileEditingTextField({
    Key? key,
    required this.bioController,
    required this.currentUser,
    this.prefixIcon,
    this.labelText,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController bioController;
  final Users currentUser;
  String? labelText;
  Function(String)? onChanged;
  Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: bioController,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
