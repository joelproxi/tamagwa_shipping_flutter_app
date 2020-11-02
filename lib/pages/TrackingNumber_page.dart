// import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tamagwa_shipping/widgets/AppBars.dart';
import 'package:tamagwa_shipping/widgets/Banner.dart';
import 'package:tamagwa_shipping/widgets/CustomNavigatin.dart';
import 'package:tamagwa_shipping/widgets/Footer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TrackingNumberPage extends StatefulWidget {
  static const String routeName = '/trackingNumber';
  TrackingNumberPage({this.trackNumber, this.isloading});

  final String trackNumber;
  final bool isloading;
  @override
  _TrackingNumberPageState createState() => _TrackingNumberPageState();
}

class _TrackingNumberPageState extends State<TrackingNumberPage>
    with AutomaticKeepAliveClientMixin {
  var res;
  double _pb = 10.0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final _trackingNumberBloc = TrackingNumberBloc();
  TextEditingController _inputController = TextEditingController();

  bool _isLoading = false;
  // Timer _timer;
  final String _url = 'https://tamangwashipping.com/api.php?action=';
  // String selectedUrl;
  String _trcNber;

  bool _validateField = true;

  _handleSubmit() {
    if (_formKey.currentState.validate()) {
      _trcNber = _inputController.text.toUpperCase();
      setState(() {
        _isLoading = true;
      });
      _trackShimpment(_trcNber);
      print(_inputController.text);
      print(_trcNber);
      _inputController.text = '';
      setState(() {
        _validateField = false;
      });
    }
    // _timer = Timer(Duration(seconds: 30), () {
    //   return Container(
    //     child: Column(
    //       children: [
    //         Text(" The proccess take and unexpeted time"),
    //         Text(" Please enter the Tracking Number, and try again."),
    //       ],
    //     ),
    //   );
    // });
  }

  _trackShimpment(_trcNber) async {
    try {
      final response =
          await http.get(_url + 'getshipmentstatus&trackingnumber=$_trcNber');
      if (response.statusCode == 200) {
        var resJson = json.decode(response.body);
        setState(() {
          res = resJson;
          if (res != null) {
            _isLoading = false;
          }
          if (res == 'null') {
            _isLoading = false;
          }
        });
        print(resJson);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    print("tracki page: ${widget.trackNumber}");
    if (!widget.trackNumber.isEmptyOrNull) {
      setState(() {
        _trcNber = widget.trackNumber;
        _isLoading = widget.isloading;
      });
      print("numero a: $_trcNber");
      _trackShimpment(_trcNber);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: fullAppBar(context),
        body: Container(
          child: SafeArea(
            child: ListView(
              children: [
                banners(context, "TRACK SHIPMENTS"),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15),
                  child: ClipRect(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Track Your Shipments.',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Here is the fastest way to ' +
                              'check the status of your Sea Shipment to Cameroon ONLY.' +
                              'Contact Customer Service for status updates to other destinations.' +
//                              'our online results give you real-time,' +
//                              ' progress as your shipment ' +
//                              'speeds to Cameroon.'
                                  '',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  //  padding: EdgeInsets.symmetric(vertical: 30.0),
                  height: 15,
                  color: Vx.black,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Your Shipment Number',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Form(
                        // autovalidate: _validateField ?? false,
                        key: _formKey,
                        child: TextFormField(
                          controller: _inputController,
                          validator: RequiredValidator(
                              errorText: "Please Enter Your Shipment Number  "),
                          decoration: InputDecoration(
                              hintText: 'Enter Your Shipment Number',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Vx.black)),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 0.0,
                              ),
                              helperText:
                                  "Use the shipment number or the container number"),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0.0),
                              ),
                            ),
                            onPressed: () {
                              _handleSubmit();
                            },
                            textColor: Colors.white,
                            color: Vx.red600,
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                width: 90,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      // width: 60,
                                      color: Vx.red600,
                                      padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                                      child: Text(
                                        'TRACK',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Icon(
                                        Icons.arrow_right,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _isLoading ? LinearProgressIndicator() : Text(''),
                      Divider(),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                res == null
                    ? Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' \tShipment Arriving Soon',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 8.0,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 15.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Vx.black,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "List Group item heading",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text("..."),
                                        Divider(
                                          height: 15.0,
                                        ),
                                        Text(
                                          "List Group item heading",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text("..."),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ' Shipment Departing Soon',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ClipRRect(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 0.0,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 15.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Vx.black,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "List Group item heading",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text("..."),
                                    Divider(
                                      height: 15.0,
                                    ),
                                    Text(
                                      "List Group item heading",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text("..."),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Flex(
                                // mainAxisSize: MainAxisSize.max,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // textDirection: TextDirection.ltr,
                                direction: Axis.vertical,
                                // verticalDirection: VerticalDirection.down,
                                children: [
                                  Text(
                                    'If you need futher informatiom'
                                    ', please feel free to ',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      "contact us",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff30A8B8),
                                      ),
                                    ),
                                    onTap: () async {
                                      const url =
                                          'https://tamangwashipping.com/contact.php';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        print('error');
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : (res['error'] == 'No shipment found!'
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'No Shipment Found',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Please check if the tracking "
                                  "number $_trcNber is correct",
                                )
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Shipment '${res['trackingnumber']}' Information",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // Card(
                                //   elevation: 2.0,
                                //   child: Container(
                                //     width: MediaQuery.of(context).size.width,
                                //     padding: EdgeInsets.all(15.0),
                                //     child: Column(
                                //       // crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Text('Shipment'),
                                //         Text(''),
                                //         Text(
                                //           '${res['title']}',
                                //           style: TextStyle(fontSize: 16),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Text(''),
                                Card(
                                  elevation: 5.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Text('Shipment Number'),
                                        Text(''),
                                        Text(
                                          '${res['trackingnumber']}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  elevation: 5.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Text('Shipment Date'),
                                        Text(''),
                                        Text(
                                          formatDate(res['cutoff']),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                // Card(
                                //   // elevation: 10,
                                //   child: Container(
                                //     width: MediaQuery.of(context).size.width,
                                //     padding: EdgeInsets.all(8.0),
                                //     child: Column(
                                //       children: [
                                //         // Text('To'),
                                //         // Text(''),
                                //         // Text(
                                //         //   'Port of Douala',
                                //         //   style: TextStyle(fontSize: 16),
                                //         // ),
                                //         // Text(
                                //         //   'Douala, Cameroon',
                                //         //   style: TextStyle(fontSize: 14),
                                //         // ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  elevation: 5.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Text('Estimated arrival date(ETA)'),
                                        Text(''),
                                        Text(
                                          formatDate(res['eta']),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'Extra Time For Customs Clearance',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  elevation: 5,
                                  color: Color(0xff30A8B8),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Status ',
                                          style: TextStyle(color: Vx.white),
                                        ),
                                        Text(
                                          '${res['comments']} ',
                                          style: TextStyle(
                                              fontSize: 16, color: Vx.white),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Container Number ',
                                          style: TextStyle(color: Vx.white),
                                        ),
                                        Text(
                                          '${res['container_number']}',
                                          style: TextStyle(
                                              fontSize: 16, color: Vx.white),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                SizedBox(
                  height: 14.0,
                ),
                // Container(
                //   height: 300,
                //   child: trackingResul(context),
                // ),
                fullFooter(context, _pb),
              ],
            ),
          ),
        ),
        // body: TrackingNumberScreen(trackingNumberBloc: _trackingNumberBloc),
        bottomNavigationBar: CustomNavigationBottom(
          defaultSelectedIndex: _selectedItem,
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
          },
        ));
  }

  int _selectedItem = 3;
  String formatDate(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("d MMM yyyy").format(dateTime);
  }

  @override
  bool get wantKeepAlive => true;
}
