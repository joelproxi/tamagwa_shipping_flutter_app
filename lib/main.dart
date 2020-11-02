import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';

import 'package:tamagwa_shipping/pages/BookingForm_page.dart';
import 'package:tamagwa_shipping/pages/Quote_page.dart';
import 'package:tamagwa_shipping/pages/TrackingNumber_page.dart';
import 'package:tamagwa_shipping/pages/TimeTable.dart';
import 'package:tamagwa_shipping/pages/PriceList_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xff30A8B8),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
//      systemNavigationBarDividerColor: Colors.red,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Color(0xff30A8B8),
    ),
  );
  if (!kIsWeb) _setTargetPlatformForDesktop();
  return runApp(MyApp());
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isWindows || Platform.isLinux) {
    targetPlatform = TargetPlatform.android;
  }
  if (TargetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      color: Colors.white,
      title: "Tamagwa ",

//      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: 'OpenSans',
        iconTheme: IconThemeData(color: Color(0xff30A8B8)),
        scaffoldBackgroundColor: Vx.white,
        primaryColor: Color(0xff30A8B8),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => TimeTablePage(),
        '/bookingForm': (_) => BookingFormPage(),
        '/quote': (_) => QuotePage(),
        '/trackingNumber': (_) => TrackingNumberPage(),
        '/priceList': (_) => PriceListPage(),
      },
      // home: TimeTablePage(),
    );
  }
}
