import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:social/const/Pallet.dart';

class AppFlatButton extends StatelessWidget {
  AppFlatButton({
    Key? key,
    required this.height,
    required this.onPressed,
    required this.title,
    this.padding = 15,
  }) : super(key: key);

  final double height;
  final Function() onPressed;
  final String title;
  double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SizedBox(
        width: double.maxFinite,
        height: height * 0.06,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(title),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Pallet.mainColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  AppTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.size = 15,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  double size;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline4!.copyWith(
            color: Pallet.mainColor,
            fontSize: size,
            fontWeight: FontWeight.w400),
      ),
      onPressed: onPressed,
    );
  }
}

class EditingButton extends StatelessWidget {
  EditingButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 35,
        width: 35,
        color: Pallet.mainColor,
        child: Center(
          child: IconButton(
            color: Pallet.clearColor,
            iconSize: 35,
            icon: const Icon(
              Icons.edit,
              size: 17.5,
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
