import 'package:flutter/material.dart';

double getHeight(context) => MediaQuery.of(context).size.height;
double getWidth(context) => MediaQuery.of(context).size.width;

const comment = Icon(
  Icons.chat_bubble,
  color: Colors.amber,
  size: 18,
);

const like = Icon(
  Icons.favorite_outline_outlined,
  color: Colors.red,
  size: 18,
);

const String usersCollection = 'Users';
