import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget drawerMenu(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 12,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/logo.png"))),
        ),

        new ListTile(
          selected: true,
          title: new Text("BOOKING YOUR SHIPMENT"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/bookingForm");
          },
        ),
        Divider(
          height: 1.0,
        ),

        new ListTile(
          selected: true,
          title: new Text("QUOTE YOUR SHIPMENT"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/quote");
          },
        ),

        Divider(
          height: 1.0,
        ),
        new ListTile(
          selected: true,
          title: new Text("TRACK YOUR SHIPMENT"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/trackingNumber");
          },
        ),
        Divider(
          height: 1.0,
        ),
        new ListTile(
          selected: true,
          title: Text("PRICES FOR YOUR SHIPMENT"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/priceList");
          },
        ),
//        Divider(),
        Divider(color: Vx.black),
      ],
    ),
  );
}
