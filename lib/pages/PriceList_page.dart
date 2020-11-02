import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:tamagwa_shipping/api/api.dart';
import 'package:tamagwa_shipping/models/PriceList_model.dart';
import 'package:tamagwa_shipping/widgets/AppBars.dart';
import 'package:tamagwa_shipping/widgets/Banner.dart';
import 'package:tamagwa_shipping/widgets/CustomNavigatin.dart';
import 'package:tamagwa_shipping/widgets/Dropdown.dart';
import 'package:tamagwa_shipping/widgets/Footer.dart';

class PriceListPage extends StatefulWidget {
  PriceListPage({Key key}) : super(key: key);

  @override
  _PriceListPageState createState() => _PriceListPageState();
}

class _PriceListPageState extends State<PriceListPage>
    with AutomaticKeepAliveClientMixin {
  final double _pb = 75.0;

  final String _title = "PRICE LIST";
  String _entrieValue = "5";
  var _liste = ['5', '10', '20', '40', '80'];
  List<JsonTableColumn> columns = List();
  List<PriceList> priceList = List();
  List<PriceList> filterPriceList = List();
  Debouncer _debouncer = Debouncer(500);

  void changeFunction(String newValue) {
    setState(() {
      _entrieValue = newValue;
      print(' entrie value: $_entrieValue');
    });
  }

  @override
  void initState() {
    super.initState();
    getPriceListData();
    columns = [
      JsonTableColumn(
        'description',
        label: "Description\n",
        valueBuilder: priceValueFormat,
      ),
      JsonTableColumn('seafreight_price',
          label: "Sea Freight\n Price (£)",
          valueBuilder: priceValueFormat,
          defaultValue: "N/A"),
      JsonTableColumn('airfreight_price',
          label: "Air Freight\n Price (£)",
          // defaultValue: 'N/A',
          valueBuilder: priceValueFormat,
          defaultValue: "N/A"),
      JsonTableColumn('packaging_price',
          label: "Packaging\n Price (£)",
          // defaultValue: 'N/A',
          valueBuilder: priceValueFormat,
          defaultValue: "N/A"),
    ];
  }

  getPriceListData() {
    Services.getItemPriceList().then((value) {
      setState(() {
        priceList = value;
        filterPriceList = priceList;
      });
      print(priceList);
    });
  }

  @override
  void dispose() {
    getPriceListData();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var priceList1 =
        jsonEncode(filterPriceList.isEmpty ? priceList : filterPriceList);
    var priceList2 = jsonDecode(priceList1);
    print(priceList2);
    return Scaffold(
      appBar: fullAppBar(context),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              banners(context, _title),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 20,
                ),
                child: Text(
                  "If you have any questions,"
                  "please feel free to contact us, "
                  "our customer service center is"
                  " working for you 24/7. ",
                ),
              ),
              Divider(),
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
              SizedBox(height: 12.0),
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
                              priceList.forEach((element) {
                                if (element.airfreightPrice == null) {
                                  return element.airfreightPrice == 'N/A';
                                } else {
                                  return element.airfreightPrice;
                                }
                              });
                              priceList.forEach((element) {
                                if (element.seafreightPrice == null) {
                                  return element.seafreightPrice == 'N/A';
                                } else {
                                  return element.seafreightPrice;
                                }
                              });
                              priceList.forEach((element) {
                                if (element.packagingPrice == null) {
                                  return element.packagingPrice == 'N/A';
                                } else {
                                  return element.packagingPrice;
                                }
                              });
                              filterPriceList = priceList
                                  .where(
                                    (el) => (el.description
                                        .toLowerCase()
                                        .contains(string.trim().toLowerCase())),
                                  )
                                  .toList();
                            });
                            print(string);
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Container(
                            width: 5.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 8.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              priceList.isNotEmpty
                  ? JsonTable(
                      priceList2,
                      allowRowHighlight: true,
                      rowHighlightColor: Colors.blue[200].withOpacity(0.7),
                      columns: columns,
                      // showColumnToggle: true,
                      paginationRowCount: int.parse(_entrieValue),
                      tableHeaderBuilder: (String header) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              color: Colors.white),
                          child: Text(
                            header,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.display1.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.black87,
                                    ),
                          ),
                        );
                      },
                      tableCellBuilder: (value) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(
                                    fontSize: 14.0, color: Colors.grey[900]),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                              // backgroundColor: Color(0xff30A8B8),
                              ),
                          Text("Waiting data to server..."),
                          Text("Press on button to bottom to refresh")
                          // LinearProgressIndicator()
                        ],
                      ),
                    ),
              SizedBox(
                height: 12,
              ),
              fullFooter(context, _pb),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getPriceListData();
        },
        backgroundColor: Color(0xff30A8B8),
        child: Icon(Icons.refresh),
        tooltip: 'Refresh',
        elevation: 20,
      ),
       bottomNavigationBar: CustomNavigationBottom(defaultSelectedIndex: _selectedItem,
        onChange: (val){
          setState(() {
            _selectedItem = val;
          });
        },
      )
    );
  }
  int _selectedItem = 4;
  String priceValueFormat(value) {
    if (value == 'null') {
      return "N/A";
    } else {
      return " $value ";
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Debouncer {
  final int _miliseconds;
  Timer _timer;
  Debouncer(this._miliseconds);
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: _miliseconds), action);
  }
}
