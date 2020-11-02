import 'package:flutter/material.dart';

Widget banners(BuildContext context, String _title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height:
        MediaQuery.of(context).size.height >= MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.height * 0.13
            : MediaQuery.of(context).size.width * 0.13,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
            letterSpacing: .6,
          ),
        ),
      ],
    ),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/texture.png'),
      ),
    ),
  );
}
