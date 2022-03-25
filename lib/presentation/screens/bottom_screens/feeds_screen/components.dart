import 'package:flutter/material.dart';

class postBarItemButton extends StatelessWidget {
  postBarItemButton({
    required this.onTap,
    required this.icon,
    required this.title,
    this.main = MainAxisAlignment.start,
    Key? key,
  }) : super(key: key);
  Icon icon;
  String title;
  Function() onTap;
  MainAxisAlignment main;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: main,
        children: [
          icon,
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
