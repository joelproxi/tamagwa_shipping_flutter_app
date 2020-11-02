import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationBottom extends StatefulWidget {
  CustomNavigationBottom(
      {Key key, this.defaultSelectedIndex = 0, @required this.onChange})
      : super(key: key);
  final int defaultSelectedIndex;
  final Function(int) onChange;

  @override
  _CustomNavigationBottomState createState() => _CustomNavigationBottomState();
}

class _CustomNavigationBottomState extends State<CustomNavigationBottom> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 0.3,
                ),
                left: BorderSide.none,
                right: BorderSide.none),
            boxShadow: [BoxShadow(color: Colors.black87, blurRadius: 1)],
            shape: BoxShape.rectangle),
        child: Row(children: [
          buildNavaBarItem("TIMETABLE", 0, '/', FontAwesomeIcons.calendarTimes),
          buildNavaBarItem(
              "BOOKING", 1, '/bookingForm', FontAwesomeIcons.addressBook),
          buildNavaBarItem("QUOTE", 2, '/quote', FontAwesomeIcons.calculator),
          buildNavaBarItem(
              "TRACK", 3, '/trackingNumber', FontAwesomeIcons.search),
          buildNavaBarItem(
              "PRICES", 4, '/priceList', FontAwesomeIcons.moneyCheckAlt),
        ]));
  }

  Widget buildNavaBarItem(String text, int index, String route, IconData icon) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
        print('current index $_selectedIndex');
        Navigator.popAndPushNamed(context, route);
      },
      child: Container(
        padding: EdgeInsets.only(top: 6.0, left: 1, right: 1),
        margin: EdgeInsets.all(0),
        height: 60,
        width: MediaQuery.of(context).size.width / 5,
        child: Column(
          children: [
            Icon(icon,
                color:
                    index != _selectedIndex ? Colors.grey[700] : Colors.white),
            SizedBox(
              height: 8.0,
            ),
            Text(
              text,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color:
                      index == _selectedIndex ? Colors.white : Colors.grey[600],
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
              color: index == _selectedIndex ? Color(0xFF0B4B53) : Colors.white,
              width: 5.3,
            )),
            color: index == _selectedIndex ? Color(0xff30A8B8) : Colors.white),
      ),
    );
  }
}
