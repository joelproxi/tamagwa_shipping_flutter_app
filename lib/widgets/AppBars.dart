import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget fullAppBar(BuildContext context) {
  return AppBar(
    // centerTitle: true,
    iconTheme: IconThemeData(color: Vx.black),
    elevation: 2.0,
    backgroundColor: Vx.white,
    title: new Container(
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width / 2.8 <= 250
          ? MediaQuery.of(context).size.width / 3
          : 170,
//      width: 200.0,
      height: 30.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        border: Border.all(color: Colors.black),
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    ),
  );
}
