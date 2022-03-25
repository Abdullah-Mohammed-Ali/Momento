import 'package:flutter/material.dart';

import '../../const/Pallet.dart';

AppBar MyAppBar({
  required String title,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    titleSpacing: 35,
    title: Text(
      title,
      style: const TextStyle(fontSize: 15, color: Pallet.regText),
    ),
    actions: actions,
    leading: leading,
  );
}

AlertDialog alertDialog = const AlertDialog(
  content: Center(
    child: CircularProgressIndicator(),
  ),
  backgroundColor: Colors.transparent,
  elevation: 0,
);

class CircleClip extends StatelessWidget {
  CircleClip({
    required this.picture,
    required this.radius,
    Key? key,
  }) : super(key: key);

  double radius;
  String picture;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        picture,
        height: radius,
        width: radius,
        fit: BoxFit.fill,
      ),
    );
  }
}
