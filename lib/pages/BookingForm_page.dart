import 'dart:convert';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:tamagwa_shipping/api/api.dart';
import 'package:tamagwa_shipping/pages/TimeTable.dart';
import 'package:tamagwa_shipping/widgets/CustomNavigatin.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tamagwa_shipping/widgets/AppBars.dart';
import 'package:tamagwa_shipping/widgets/Banner.dart';
import 'package:tamagwa_shipping/widgets/Footer.dart';

class BookingFormPage extends StatefulWidget {
  static const String routeName = '/bookingForm';

  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  // final _bookingFormBloc = BookingFormBloc();
  final emailValidator = MultiValidator([
    EmailValidator(errorText: "Enter the valid E-mail"),
    RequiredValidator(errorText: "nRequiredull")
  ]);
  double _pb = 10.0;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController receiverFullNameController = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();
  TextEditingController destinationCityController = TextEditingController();
  TextEditingController destinationCountyController = TextEditingController();
  TextEditingController weigthController = TextEditingController();
  TextEditingController collectionDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String _shippingMethodForm = 'Sea';
  String _numOfPackages = '1';

  bool _valide = false;

  GestureRecognizer _sailingDate, _contactUS, _termContion;

  _urlTeamsCondition() async {
    const url = 'https://tamangwashipping.com/tc.php';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('error');
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

  @override
  void initState() {
    super.initState();
    _sailingDate = TapGestureRecognizer()
      ..onTap = () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TimeTablePage()),
          (route) => false);
    _contactUS = TapGestureRecognizer()..onTap = () => _urLauncheContact();
    _termContion = TapGestureRecognizer()..onTap = () => _urlTeamsCondition();
  }

  @override
  void dispose() {
    _sailingDate.dispose();
    _contactUS.dispose();
    _termContion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fullAppBar(context),
        body: SafeArea(
          child: ListView(
            children: [
              banners(context, "BOOKING FORM"),
              SizedBox(
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Form(
                  key: formKey,
                  // autovalidate: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: "You’re a few clicks " +
                                    "away from placing your order. " +
                                    "To do so, just tell us more about yourself," +
                                    " the receiver of your package, and a brief "
                                        "description of your shipment.You will need "
                                        "to provide the receiver's contact details so "
                                        "that we can ring him or her for collection. "
                                        "Remember that Sea freight is cheaper than "
                                        "Air freight but takes longer to arrive its "
                                        "final destination."),
//                            TextSpan(
//                              text: " sailing date.",
//                              style: TextStyle(color: Vx.blue600),
//                              recognizer: _sailingDate,
//                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "If you have any questions, please feel free to contact us,"
                        "our customer service center is working for you 24/7.",
                      ),
                      Divider(
                        height: 30.0,
                        color: Vx.black,
                      ),
                      Text(
                        "  About You",
                        style: TextStyle(
                          color: Vx.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ClipRRect(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                          // decoration: DecoratedBox(decoration: null),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Vx.black,
                              style: BorderStyle.solid,
                              width: 0.8,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                validator:
                                    RequiredValidator(errorText: "Required *"),
                                controller: fullNameController,
                                decoration: InputDecoration(
                                  hintText: "\tFull Name (required)",
                                  labelText: 'Full Name ',
                                  hintStyle:
                                      TextStyle(fontStyle: FontStyle.italic),
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0,
                                    horizontal: 10.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("Collection Address"),
                              TextFormField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  hintText: " Address",
                                  labelText: ' Address',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      // FontAwesomeIcons.locationArrow,
                                      Icons.location_on,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("City"),
                              TextFormField(
                                controller: cityController,
                                decoration: InputDecoration(
                                  hintText: "City",
                                  labelText: 'City',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      Icons.home,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("PostCode"),
                              TextFormField(
                                controller: postCodeController,
                                decoration: InputDecoration(
                                  hintText: "Post Code",
                                  labelText: 'Post Code',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      FontAwesomeIcons.box,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("Phone"),
                              TextFormField(
                                validator: RequiredValidator(
                                  errorText: "Required *",
                                ),
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: "+44 (required)",
                                  labelText: 'Phone',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      // Icons.phone,
                                      FontAwesomeIcons.phoneAlt,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("E-Mail"),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: emailValidator,
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "\tE-Mail Address(required)",
                                  labelText: 'E-Mail',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      Icons.mail,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        " About the Receiver",
                        style: TextStyle(
                          color: Vx.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          // height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            bottom: 5.0,
                            top: 10.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Vx.black,
                                style: BorderStyle.solid,
                                width: 0.8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),

                          child: Column(
                            children: [
                              TextFormField(
                                // autovalidate: true,
                                validator: RequiredValidator(
                                  errorText: "Required *",
                                ),
                                controller: receiverFullNameController,
                                decoration: InputDecoration(
                                  hintText: "  Full Name (required)",
                                  labelText: "  Receiver's Full Name ",
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("Collection Address"),
                              TextFormField(
                                validator:
                                    RequiredValidator(errorText: "Required *"),
                                controller: receiverPhoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: " Phone Number (required)",
                                  labelText: '  Phone #',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      // FontAwesomeIcons.locationArrow,
                                      Icons.phone,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("City"),

                              DropdownButtonFormField(
                                items: <String>['Sea', 'Air']
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    _shippingMethodForm = newValue;
                                  });
                                  // String _numOfPackages = '1';
                                },
                                decoration: InputDecoration(
                                    labelText: '  Shipping Method ',
                                    hintText: "  Select Shipping Method",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(0.0),
                                    prefixIcon: Container(
                                      width: 5.0,
                                      color: Color(0xffbdb9b9),
                                      child: Icon(
                                        FontAwesomeIcons.shippingFast,
                                        // Icons.airline,
                                        color: Colors.black,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("PostCode"),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        " Your Shipment & Confirmation",
                        style: TextStyle(
                          color: Vx.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          // height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            bottom: 5.0,
                            top: 10.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Vx.black,
                                style: BorderStyle.solid,
                                width: 0.8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                validator:
                                    RequiredValidator(errorText: "Required *"),
                                controller: destinationCityController,
                                decoration: InputDecoration(
                                  hintText: " Destination City ",
                                  labelText: '  Destination City (required)',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      // Icons.location_city,
                                      FontAwesomeIcons.city,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("Collection Address"),
                              TextFormField(
                                validator:
                                    RequiredValidator(errorText: "Required *"),
                                controller: destinationCountyController,
                                decoration: InputDecoration(
                                  hintText: " Destination Country ",
                                  labelText: ' Destination Country (required)',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      FontAwesomeIcons.globeAfrica,
                                      // Icons.location_on,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("City"),
                              DropdownButtonFormField(
                                items: <String>[
                                  '1',
                                  '2',
                                  '3',
                                  '4',
                                  '5',
                                  '6',
                                  '7',
                                  '8',
                                  '+9'
                                ]
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    _numOfPackages = newValue;
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: '  Number of packages',
                                    hintText: "  ",
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(0.0),
                                    prefixIcon: Container(
                                      width: 5.0,
                                      color: Color(0xffbdb9b9),
                                      child: Icon(
                                        FontAwesomeIcons.shippingFast,
                                        // Icons.airline,
                                        color: Colors.black,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text("PostCode"),
                              TextFormField(
                                controller: weigthController,
                                decoration: InputDecoration(
                                  hintText: "  Weight",
                                  labelText: '  Weight (Kgs) Approx',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      FontAwesomeIcons.weight,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),

                              TextFormField(
                                validator: DateValidator("dd-mm-yyyy",
                                    errorText: "Format date isn't correct"),
                                controller: collectionDateController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  hintText: " yyyy-dd-mm (eg: 2020-01-01)",
                                  labelText: '  Collection Date',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      FontAwesomeIcons.calendarAlt,
                                      color: Colors.black,
                                    ),
                                  ),
                                  suffixIcon: Container(
                                    width: 5.0,
                                    child: IconButton(
                                      // FontAwesomeIcons.calendarAlt,
                                      color: Color(0xff30A8B8),
                                      // DatePicker.showDatePicker(
                                      //   context,
                                      //   showTitleActions: true,
                                      //   minTime: DateTime.utc(2020).toLocal(),
                                      //   maxTime: DateTime.utc(2099),
                                      //   onChanged: (date) {
                                      //     setState(() {
                                      //       collectionDateController.text =
                                      //           DateFormat("dd-MM-yyyy")
                                      //               .format(date);
                                      //       // .parse(date.toString())
                                      //       // .toString()
                                      //       // .substring(0, 10);
                                      //     });
                                      //     print('change $date');
                                      //     print(
                                      //         'change ${collectionDateController.text}');
                                      //   },
                                      //   onConfirm: (date) {
                                      //     setState(() {
                                      //       collectionDateController.text =
                                      //           DateFormat("dd-MM-yyyy")
                                      //               .format(date);
                                      //       // .parse(date.toString())
                                      //       // .toString()
                                      //       // .substring(0, 10);
                                      //     });
                                      //     print(
                                      //         'confirm ${collectionDateController.text} ');
                                      //   },
                                      //   currentTime: DateTime.now(),
                                      //   locale: LocaleType.en,
                                      //   theme: DatePickerTheme(
                                      //     backgroundColor: Colors.white,
                                      //     doneStyle: TextStyle(
                                      //       color: Color(0xff30A8B8),
                                      //     ),
                                      //     itemStyle: TextStyle(
                                      //       fontFamily: 'ProductSans',
                                      //       // color: Color(0xff30A8B8),
                                      //     ),
                                      //   ),
                                      // );

                                      onPressed: () async {
                                        final pick = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime(2099));
                                        setState(() {
                                          collectionDateController.text =
                                              DateFormat("dd-MM-yyyy")
                                                  .format(pick);
                                        });
                                        print(DateFormat("dd-MM-yyyy")
                                            .format(pick));
                                      },
                                      icon: Icon(FontAwesomeIcons.calendar),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 12.0,
                                    bottom: 0.0,
                                    top: 0.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: descriptionController,
                                textAlign: TextAlign.start,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      decorationStyle:
                                          TextDecorationStyle.solid),
                                  hintText:
                                      "Please provide a full description of "
                                      "  your goods",
                                  // labelText: '  Package Details ',
                                  prefixIcon: Container(
                                    width: 5.0,
                                    height: 120.0,
                                    color: Color(0xffbdb9b9),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    left: 10.0,
                                    bottom: 0.0,
                                    top: 5.0,
                                  ),
                                  enabled: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // CheckboxListTile(
                      //    S value: _valide == false, onChanged: (bool _valide) {}),
                      SizedBox(
                        height: 20.0,
                      ),
                      ClipRect(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: _valide != false ? true : false,
                                    onChanged: (bool valid) {
                                      setState(() {
                                        _valide = valid;
                                      });
                                    }),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  // height: 0.0,
                                  child: SelectableText.rich(
                                    TextSpan(
                                      text:
                                          'By completing the above form, you confirm that you accept our', // default text style
                                      children: <TextSpan>[
                                        TextSpan(
                                          recognizer: _termContion,
                                          text: ' terms and conditions',
                                          style: TextStyle(color: Vx.blue400),
                                        ),
                                        TextSpan(
                                          text:
                                              ' and that all goods are packed by you and there are no dangerous or valuable goods in your shipment.',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("If you need to rearrange or cancel a"
                                " collection, you must do so at least 24"
                                " hours before your collection date to "
                                "avoid a cancellation charge."),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text.rich(
                              TextSpan(
                                text: "After you have clicked on \"submit\" "
                                    "below, we will reply by email to confirm your"
                                    " collection time and date. Whilst we will try"
                                    " to arrange your collection on the date "
                                    "requested, this is not always possible. ",
                                children: [
                                  TextSpan(
                                    text: "You should note that your collection"
                                        " time and date is only booked once we have "
                                        "confirmed this with you by phone or email.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text.rich(
                              TextSpan(
                                text:
                                    "If you do not receive a confirmation call or "
                                    "email within 48 hours, please",
                                children: [
                                  TextSpan(
                                    recognizer: _contactUS,
                                    text: " contact us ",
                                    style: TextStyle(
                                      color: Vx.blue500,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "to ensure your booking has been received. ",
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              // margin: EdgeInsets.only(right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _valide == true
                                      ? OutlineButton.icon(
                                          highlightedBorderColor: Vx.blue500,
                                          borderSide: BorderSide(
                                            width: 3.0,
                                            color: Vx.blue500,
                                          ),
                                          color: Vx.blue500,
                                          onPressed: _handlerSubmit,
                                          icon: Icon(
                                            Icons.send,
                                            color: Vx.blue400,
                                          ),
                                          label: Text(
                                            _isLoading
                                                ? "SUBMIT ORDER...."
                                                : "SUBMIT ORDER",
                                            style: TextStyle(
                                              color: Vx.blue500,
                                            ),
                                          ),
                                        )
                                      : OutlineButton.icon(
                                          highlightedBorderColor: Vx.gray100,
                                          borderSide: BorderSide(
                                            width: 3.0,
                                            color: Color(0xff999999),
                                          ),
                                          color: Color(0xff999999),
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.send,
                                            color: Color(0xff999999),
                                          ),
                                          label: Text(
                                            "SUBMIT ORDER",
                                            style: TextStyle(
                                              color: Color(0xff999999),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      Divider(
                        color: Vx.black,
                      ),
                      _isLoading ? LinearProgressIndicator() : Text("")
                    ],
                  ),
                ),
              ),
              fullFooter(context, _pb),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavigationBottom(
          defaultSelectedIndex: _selectedItem,
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
          },
        ));
  }

  int _selectedItem = 1;

  void _handlerSubmit() async {
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      var data = {
        'fullName': fullNameController.text,
        'address': addressController.text,
        'city': cityController.text,
        'postCode': postCodeController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'receiverFullName': receiverFullNameController.text,
        'receiverPhone': receiverPhoneController.text,
        'shippingMethodForm': _shippingMethodForm,
        'destinationCity': destinationCityController.text,
        'destinationCounty': destinationCountyController.text,
        'numOfPackges': _numOfPackages,
        'weigth': weigthController.text,
        'collectionDate': collectionDateController.text,
        'description': descriptionController.text,
      };
      // var res = await Services().bookingData(data, 'booking/');
      // var body = json.decode(res.body);
      // print(body);
      var response = await Services().bookingData(data, 'submitorder');
      var body = json.decode(response.body);

      if (body['message'] == 'record successfully inserted') {
        SweetAlert.show(
          context,
          title: "Booking ",
          subtitle: "completed",
          style: SweetAlertStyle.success,
        );
        setState(
          () {
            _isLoading = false;
          },
        );
      }

      if (body['message'] == 'error during the insertion of the record') {
        SweetAlert.show(
          context,
          title: "Booking Failed",
          subtitle: "Can't connect to server ",
          style: SweetAlertStyle.error,
        );
        setState(
          () {
            _isLoading = false;
          },
        );
      }

      print(body['message']);
      print(
          "------------------------------------------------------------------------------");
      print(data);

      setState(() {
        _valide = false;
      });
      fullNameController.text = '';
      addressController.text = '';
      cityController.text = '';
      postCodeController.text = '';
      phoneController.text = '';
      emailController.text = '';
      receiverFullNameController.text = '';
      receiverPhoneController.text = '';

      destinationCityController.text = '';
      destinationCountyController.text = '';

      weigthController.text = '';
      collectionDateController.text = '';
      descriptionController.text = '';
    } else {
      SweetAlert.show(context,
          title: "Booking Failed",
          subtitle: "Check all require's field",
          style: SweetAlertStyle.error);
      setState(
        () {
          _isLoading = false;
        },
      );
    }
    setState(
      () {
        _isLoading = false;
      },
    );
  }
}
