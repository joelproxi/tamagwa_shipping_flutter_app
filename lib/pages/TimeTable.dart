import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:json_table/json_table.dart';
import 'package:tamagwa_shipping/api/api.dart';
import 'package:tamagwa_shipping/models/TimeTable_model.dart';
import 'package:tamagwa_shipping/pages/TrackingNumber_page.dart';
// import 'package:tamagwa_shipping/pages/TrackingNumber_page.dart';
import 'package:tamagwa_shipping/widgets/CustomNavigatin.dart';
import 'package:tamagwa_shipping/widgets/Dropdown.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import 'package:tamagwa_shipping/widgets/AppBars.dart';
import 'package:tamagwa_shipping/widgets/Banner.dart';
import 'package:tamagwa_shipping/widgets/DrawerMenu.dart';
import 'package:tamagwa_shipping/widgets/Footer.dart';

class TimeTablePage extends StatefulWidget {
  // ShipmentDataSource _shipmentDataSource = ShipmentDataSource([]);
  final bool isLoaded = false;
  var track;

  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage>
    with AutomaticKeepAliveClientMixin {
  // ShipmentDataSource _shipmentDataSource = ShipmentDataSource([]);
  bool isLoaded = false;
  double _paddingBottom = 75.0;
  String _entrieValue = '5';

  bool toggle = true;
  List<Shipment> ship = List();
  List<Shipment> shipments = List();
  List<Shipment> filterShipments = List();
  List<JsonTableColumn> columns = List();
  var _liste = ['5', '10', '20', '40', '80'];

  final _debouncer = Debouncer(miliseconds: 500);

  GestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    getShipmentData();
    _recognizer = TapGestureRecognizer()
      ..onTap = () => Navigator.popAndPushNamed(context, "/trackingNumber");
    columns = [
      // JsonTableColumn(
      //   "title",
      //   label: "Shipment\n",
      // ),
      JsonTableColumn(
        "trackingnumber",
        label: "Traking\n Number ",
        defaultValue: 'N/A',
      ),
      JsonTableColumn(
        "etd",
        label: "Shipment\n Date",
        valueBuilder: formatDate,
      ),
      JsonTableColumn(
        "eta",
        label: "ETA\n",
        valueBuilder: formatDate,
      ),

      JsonTableColumn(
        "comments",
        label: "Status\n",
      ),
    ];
  }

  getShipmentData() {
    Services.getShipment().then((value) {
      setState(() {
        shipments = value;
        // shipments = shipments.reversed;
        shipments.sort((a, b) {
          return b.eta.compareTo(a.eta);
        });
        filterShipments = shipments;
      });
      // print(shipments);
    });
  }

  void changeFunction(String newValue) {
    setState(() {
      _entrieValue = newValue;
    });
    print(' entrie value: $_entrieValue');
  }

  final String _url = 'https://tamangwashipping.com/api.php?action=';
  String _trcNber = '';
  bool _isLoading = false;
  var res;

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
  Widget build(BuildContext context) {
    // getShipmentData();
    // var json = jsonDecode(jsonSample);
    // print('json: $json');

    var ship1 =
        jsonEncode(filterShipments.isEmpty ? shipments : filterShipments);
    var ship2 = jsonDecode(ship1);
    print(ship2);
    // print('--------------------------------------------');
    // print('jsonSample: $jsonSample');
    print(ship2);
    return Scaffold(
        appBar: fullAppBar(context),
        // endDrawer: drawerMenu(context),
        body: Container(
          child: new SafeArea(
            child: ListView(
              children: [
                banners(context, "SHIPPING TIMETABLE"),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 20,
                  ),
                  child: Text(
                    "Shipment details, dates, status, tracking, and useful information.",
                    style: TextStyle(fontSize: 15.0, fontFamily: 'ProductSans'),
                  ),
                ),
                new Divider(
                  thickness: 1.0,
                ),

                SizedBox(
                  height: 13,
                ),

                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 70.0),
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Row(
                    children: [
                      Text("Show "),
                      Expanded(
                        flex: 1,
                        child: dropdownField(context, _liste, changeFunction),
                      ),
                      Text(" Entries")
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1 / 5,
                      vertical: 10
                      // horizontal: 20.0,
                      ),
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Row(
                    children: [
                      Text(
                        "Search\t",
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          onChanged: (String string) {
                            _debouncer.run(() {
                              setState(() {
                                shipments.forEach((element) {
                                  if (element.trackingnumber == null) {
                                    return element.trackingnumber = 'N/A';
                                  } else {
                                    return element.trackingnumber;
                                  }
                                });
                                filterShipments = shipments
                                    .where(
                                      (el) =>
                                          (el.title.contains(string.isNotEmpty
                                                  ? string
                                                      .trim()
                                                      .allWordsCapitilize()
                                                  : " ") ||
                                              el.comments.contains(string
                                                      .isNotEmpty
                                                  ? string.trim().toUpperCase()
                                                  : " ")) ||
                                          el.cutoff.contains(string.isNotEmpty
                                              ? string.trim()
                                              : " ") ||
                                          el.etd.contains(string.isNotEmpty
                                              ? string.trim()
                                              : " ") ||
                                          el.eta.contains(string.isNotEmpty
                                              ? string.trim()
                                              : " ") ||
                                          el.trackingnumber.contains(
                                              el.trackingnumber != null
                                                  ? (string.isNotEmpty
                                                      ? string
                                                          .trim()
                                                          .toUpperCase()
                                                      : ' ')
                                                  : "N/A"),
                                    )
                                    .toList();
                              });
                              print(string);
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: Container(
                              width: 5.0,
                              color: Vx.black,
                              child: IconButton(
                                icon: Icon(FontAwesomeIcons.search),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(1.0),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),

                Container(
                  child: shipments.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: Column(
                            children: [
                              JsonTable(
                                ship2 == null ? "" : ship2,
                                columns: columns,
                                showColumnToggle: false,
                                // allowRowHighlight: true,
                                rowHighlightColor:
                                    Color(0x30A8B8).withOpacity(0.4),
                                paginationRowCount: int.parse(_entrieValue),
                                onRowSelect: (index, map) {
                                  // print("index: $index");
                                  // print("map: $map");

                                  if (map["trackingnumber"] != null) {
                                    print("${map["trackingnumber"]}");
                                    // _trackShimpment(map["trackingnumber"]);

                                    // Navigator.popAndPushNamed(
                                    //     context, "/trackingNumber");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TrackingNumberPage(
                                          trackNumber: map["trackingnumber"],
                                          isloading: true,
                                        ),
                                      ),
                                    );
                                    // Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TrackingNumberPage(
                                          trackNumber: map["trackingnumber"],
                                          isloading: true,
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  } else {}
                                },
                                tableHeaderBuilder: (String header) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.5),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      header,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                            color: Colors.black87,
                                          ),
                                    ),
                                  );
                                },
                                tableCellBuilder: (value) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          width: 0.5,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .copyWith(
                                            fontSize: 12.0,
                                            color: value == 'DELIVERED' ||
                                                    value == 'TRANSIT' ||
                                                    value == 'SCHEDULED' ||
                                                    value ==
                                                        'CUSTOMS CLEARANCE ONGOING' ||
                                                    value ==
                                                        'COLLECTIONS ONGOING'
                                                ? Colors.white
                                                : (value == 'COMMING'
                                                    ? Colors.white
                                                    : (value
                                                            .toString()
                                                            .startsWith('TM')
                                                        ? Colors.blue[400]
                                                        : Colors.grey[700])),
                                            backgroundColor: value ==
                                                        'DELIVERED' ||
                                                    value == 'TRANSIT'
                                                ? Colors.green[500]
                                                : (value ==
                                                        'CUSTOMS CLEARANCE ONGOING'
                                                    ? Colors.blue[800]
                                                    : (value == 'SCHEDULED' ||
                                                            value ==
                                                                'COLLECTIONS ONGOING'
                                                        ? Colors.green[700]
                                                        : Colors.white)),
                                          ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                  // backgroundColor: Color(0xff30A8B8),
                                  ),
                              Text("waiting for data from the server... "),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "please check your internet connection "
                                  "and press the button at the bottom "
                                  "of the screen to refresh the page",
                                ),
                              )
                              // LinearProgressIndicator()
                            ],
                          ),
                        ),
                ),
                // Divider(thickness: 1.0),

                fullFooter(context, _paddingBottom),
                // _TTJSTState(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getShipmentData();
          },
          backgroundColor: Color(0xff30A8B8),
          child: Icon(Icons.refresh),
          tooltip: 'Refresh',
          elevation: 20,
        ),
        bottomNavigationBar: CustomNavigationBottom(
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
          },
        ));
  }

  int _selectedItem = 0;

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(
      json.decode(jsonObject),
    );
    return jsonString;
  }

  String formatDate(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("d MMM yyyy").format(dateTime);
  }

  @override
  bool get wantKeepAlive => true;
}

class Debouncer {
  final int miliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.miliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: miliseconds), action);
  }
}
