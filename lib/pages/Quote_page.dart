import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:tamagwa_shipping/models/QuoteBloc.dart';
import 'package:tamagwa_shipping/pages/BookingForm_page.dart';
import 'package:tamagwa_shipping/widgets/AppBars.dart';
import 'package:tamagwa_shipping/widgets/Banner.dart';
import 'package:tamagwa_shipping/widgets/CustomNavigatin.dart';
import 'package:tamagwa_shipping/widgets/Footer.dart';
import 'package:velocity_x/velocity_x.dart';

class QuotePage extends StatefulWidget {
  QuotePage({Key key}) : super(key: key);

  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  final String _title = 'QUOTE';
  String tPrice = bloc.tCost;

  totalCostValue() {
    setState(() {
      tPrice = bloc.tCost;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   bloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double pt = 8.0;
    return SafeArea(
      child: Scaffold(
          appBar: fullAppBar(context),
          body: ListView(
            children: [
              banners(context, _title),
              Container(
                margin: EdgeInsets.fromLTRB(
                  8.0,
                  15,
                  8.0,
                  5,
                ),
                child: Text("To obtain a shipping quote for "
                    "each of your packages, enter the dimensions "
                    " of each package below"),
              ),
              Container(
                color: Vx.black,
                height: 5.0,
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Vx.black,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      right: 25.0,
                      left: 10,
                    ),
                    child: Text("#"),
                  ),
                  Expanded(child: Text("Length\n (cm)")),
                  Expanded(child: Text("Width\n (cm)")),
                  Expanded(child: Text("Height \n(cm)")),
                  Expanded(child: Text("Total \nCost (£)")),
                  Text("Action"),
                ],
              ),
              QuoteBody(),
              Divider(
                color: Vx.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlineButton(
                    onPressed: () {
                      bloc.newFields();
                    },
                    child: Text('ADD PACKAGE'),
                    color: Colors.white,
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    textTheme: ButtonTextTheme.normal,
                  ),
                  RaisedButton(
                    elevation: 0.0,
                    color: Colors.green[500],
                    child: Text(
                      'CALCULATE COSTS',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        tPrice = bloc.tCost;
                      });
                      bloc.submit();
                      // _QuotePageState().tPrice;
                    },
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text.rich(
                  //   TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: 'The total cost for your shipments is ',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text:
                  //             ' £${bloc.tCost.isEmptyOrNull ? 00.00 : bloc.tCost} ',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w800,
                  //           fontSize: 15,
                  //           color: Colors.white,
                  //           fontStyle: FontStyle.italic,
                  //           backgroundColor: Color(0xff30A8B8),
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text: '. ',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Text(
                    'The total cost for your shipments is ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    ' £${bloc.tCost.isEmptyOrNull ? 00.00 : bloc.tCost} ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      backgroundColor: Color(0xff30A8B8),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "The total amount displayed does not include"
                      " collection charge. Contact Tamangwa "
                      "Shipping to enquire about collection"
                      " fees if you cannot deliver your items "
                      "to our warehouse for Shipment.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Please click ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          )),
                      GestureDetector(
                        onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingFormPage()),
                          (route) => false,
                        ),
                        child: Text(
                          ' here ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xff30A8B8),
                          ),
                        ),
                      ),
                      Text(
                        'to book a collection. ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(),
              fullFooter(context, pt)
            ],
          ),
          bottomNavigationBar: CustomNavigationBottom(
            defaultSelectedIndex: _selectedItem,
            onChange: (val) {
              setState(() {
                _selectedItem = val;
              });
            },
          )),
    );
  }

  int _selectedItem = 2;
}

class QuoteBody extends StatelessWidget {
  // const QuoteBody({Key key}) : super(key: key);

  final lengthFieldController = List<TextEditingController>();
  final widthFieldController = List<TextEditingController>();
  final heightFieldController = List<TextEditingController>();

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildField(int length) {
      lengthFieldController.clear();
      widthFieldController.clear();
      heightFieldController.clear();

      for (int i = 0; i < length; i++) {
        final length = bloc.lengthFields.value[i].value;
        final width = bloc.widthFields.value[i].value;
        final height = bloc.heightFields.value[i].value;

        lengthFieldController.add(TextEditingController(text: length));
        widthFieldController.add(TextEditingController(text: width));
        heightFieldController.add(TextEditingController(text: height));
      }

      return List<Widget>.generate(
        length,
        (i) => FieldsWidget(
          index: i,
          lengthController: lengthFieldController[i],
          widthController: widthFieldController[i],
          heightController: heightFieldController[i],
        ),
      );
    }

    return Column(
      children: [
        ValueBuilder<List<StreamedValue<String>>>(
          streamed: bloc.lengthFields,
          builder: (context, snapshot) {
            return Column(
              children: _buildField(snapshot.data.length),
            );
          },
          noDataChild: Text("No Entries"),
        ),
        // Text('t :${bloc.tCost}')
      ],
    );
  }
}

class FieldsWidget extends StatelessWidget {
  const FieldsWidget(
      {this.index,
      this.widthController,
      this.heightController,
      this.lengthController});

  final int index;
  final TextEditingController widthController;
  final TextEditingController heightController;
  final TextEditingController lengthController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.black87,
        ),
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text('${index + 1}:'),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<String>(
                        initialData: ' ',
                        stream: bloc.lengthFields.value[index].outStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 0.0,
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: lengthController,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      // labelText: 'Name:',
                                      contentPadding: EdgeInsets.fromLTRB(
                                        10.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      hintText: 'Length',
                                      errorText: snapshot.error,
                                      border: OutlineInputBorder()),
                                  onChanged:
                                      bloc.lengthFields.value[index].inStream,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Expanded(
                    child: StreamBuilder<String>(
                        initialData: ' ',
                        stream: bloc.widthFields.value[index].outStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 0.0,
                                ),
                                child: TextField(
                                  controller: widthController,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      // labelText: 'Age:',
                                      contentPadding: EdgeInsets.fromLTRB(
                                        10.0,
                                        0.0,
                                        0.0,
                                        0.0,
                                      ),
                                      hintText: 'width ',
                                      errorText: snapshot.error,
                                      border: OutlineInputBorder()),
                                  keyboardType: TextInputType.number,
                                  onChanged:
                                      bloc.widthFields.value[index].inStream,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Expanded(
                    child: StreamBuilder<String>(
                        initialData: ' ',
                        stream: bloc.heightFields.value[index].outStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 0.0,
                                ),
                                child: TextField(
                                  controller: heightController,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    // labelText: 'Age:',
                                    contentPadding: EdgeInsets.fromLTRB(
                                      10.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                    ),
                                    hintText: 'height ',
                                    errorText: snapshot.error,
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged:
                                      bloc.heightFields.value[index].inStream,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Expanded(
                    child: StreamBuilder<String>(
                        initialData: ' ',
                        stream: bloc.costFields.value[index].outStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 1,
                                ),
                                child: Text(
                                  bloc.costFields.value[index].value.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    // color: Color(0xff30A8B8),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 22.0,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red[400],
              onPressed: () => bloc.removedField(index),
            ),
          ],
        ),
      ],
    );
  }
}
