import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';

Widget fullFooter(BuildContext context, double pt) {
  return Padding(
    padding: EdgeInsets.only(left: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16.0,
        ),
        Container(
          padding: EdgeInsets.only(
            bottom: 3.0,
          ),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xff999999), width: 4.0))),
          child: Text(
            "ABOUT US",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 13.0,
        ),
        Text(
          'Tamangwa Shipping provides Air and Sea freight solutions '
                  'to Cameroon and Africa at large.'
                  'Together with our partners throughout the UK ' +
              'and Africa we are committed in helping our ' +
              'clients achieve their freight forwarding objectives. ' +
              'Our services include daily airfreight ' +
              'to various destinations around the world, weekly '
                  'seafreight services to Cameroon and Equatorial Guinea.',
          style: TextStyle(fontSize: 13.0),
        ),
        Text(''),
        // Text(
        //     "Tamagwa Shipping company registration number in England and Wales: 9899608.",
        //     style: TextStyle(fontSize: 13.0)),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text:
                      'Tamangwa Shipping is a Trading name of Tamangwa Limited,'
                      ' a registered company in England and Wales with '
                      'registration number:'),
              TextSpan(
                text: " 9899608.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text(""),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 3.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xff999999), width: 4.0),
                    ),
                  ),
                  child: Text(
                    "MORE INFO",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                VxBox().height(12).make(),
                GestureDetector(
                  onTap: () {
                    _urlAboutUS();
                  },
                  child: Text(
                    "About US",
                    style: TextStyle(
                      color: Color(0xff30A8B8),
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                VxBox().height(5).make(),
                GestureDetector(
                  onTap: () {
                    _urlOurTeam();
                  },
                  child: Text(
                    "Our Team ",
                    style: TextStyle(
                      color: Color(0xff30A8B8),
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                VxBox().height(5).make(),
                GestureDetector(
                  onTap: () {
                    _urlOurPathners();
                  },
                  child: Text(
                    "Our Partners",
                    style: TextStyle(
                      color: Color(0xff30A8B8),
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                VxBox().height(5).make(),
                GestureDetector(
                  onTap: () {
                    _urlOurPromise();
                  },
                  child: Text(
                    "Our Promise",
                    style: TextStyle(
                      color: Color(0xff30A8B8),
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                VxBox().height(5).make(),
                GestureDetector(
                  onTap: () {
                    _urlTeamsCondition();
                  },
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      color: Color(0xff30A8B8),
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 3.0,
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xff999999), width: 4.0))),
                  child: Text(
                    "CONTACT",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                VxBox().height(12).make(),
                Text(
                  "Tamangwa Shipping",
                  style: TextStyle(
                    // color: Color(0xff30A8B8),
                    fontSize: 14.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Glebe Farm, Rothwell Road",
                ),
                Text(
                  "NN14 2NT, Northampton",
                ),
                Text(
                  "England, United Kingdom",
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Phone: +44 2030268890 ",
                ),
                Text(
                  "WhatsApp: +44 7825182281 ",
                ),
              ],
            )
          ],
        ),
        Text(""),

        Container(
          color: Color(0xFF38B9CF),
          // width: MediaQuery.of(context).size.width * 0.7 < 340
          //     ? 300
          //     : MediaQuery.of(context).size.width * 0.9,
          width: 240.0,
          height: 30,
          child: FlatButton(
            textColor: Colors.white,
            padding: EdgeInsets.only(left: 0.0, right: 2.0),
            onPressed: () {
              _urLauncheContact();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(""),
                Icon(
                  FontAwesomeIcons.envelope,
                  size: 20,
                ),
                Text(""),
                Text(
                  "CONTACT TAMANGWA SHIPPING",
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    letterSpacing: 0.2,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          // width: MediaQuery.of(context).size.width / 2.1 < 342
          //     ? 200
          //     : 400,
          padding: EdgeInsets.only(top: 20, bottom: pt),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Vx.white,
                    size: 20.0,
                  ),
                  onPressed: () {
                    _urLauncheFacebook();
                  },
                  padding: EdgeInsets.all(0.1),
                ),
                backgroundColor: Vx.blue700,
              ),
              CircleAvatar(
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.twitter,
                    color: Vx.white,
                    size: 25.0,
                  ),
                  onPressed: () {
                    _urLauncheTwitter();
                  },
                  color: Colors.white,
                  padding: EdgeInsets.all(.1),
                ),
                backgroundColor: Color(0xff58eaf5),
              ),
              // CircleAvatar(
              //   child: IconButton(
              //     icon: Icon(
              //       FontAwesomeIcons.googlePlusG,
              //       color: Vx.white,
              //       size: 20.0,
              //     ),
              //     onPressed: () {
              //       _urLauncheGoogle();
              //     },
              //     padding: EdgeInsets.all(.1),
              //   ),
              //   backgroundColor: Color(0xffd36161),
              // ),
              CircleAvatar(
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.linkedinIn,
                    color: Vx.white,
                  ),
                  onPressed: _urLauncheLinkedIn,
                  color: Colors.white,
                ),
                backgroundColor: Vx.blue500,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

_urLauncheFacebook() async {
  const url = 'https://facebook.com/tamagwa';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not contact ');
  }
}

_urLauncheLinkedIn() async {
  const url = "https://uk.linkedin.com/in/tamangwa-shipping";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not contact ');
  }
}

// _urLauncheGoogle() async {
//   const url = 'https://plus.google.com/103056527774079573098';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     print('Could not contact ');
//   }
// }

_urLauncheTwitter() async {
  const url = "https://twitter.com/Tamangwa2";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not contact ');
  }
}

_urLauncheContact() async {
  const url = 'https://tamangwashipping.com/contact.php';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('error');
  }
}

_urlAboutUS() async {
  const url = 'https://tamangwashipping.com/aboutus.php';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('error');
  }
}

_urlOurTeam() async {
  const url = 'https://tamangwashipping.com/team.php';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('error');
  }
}

_urlOurPathners() async {
  const url = 'https://tamangwashipping.com/partners.php';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('error');
  }
}

_urlOurPromise() async {
  const url = 'https://tamangwashipping.com/promise.php';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('error');
  }
}

_urlTeamsCondition() async {
  const url = 'https://tamangwashipping.com/tc.php';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('error');
  }
}
