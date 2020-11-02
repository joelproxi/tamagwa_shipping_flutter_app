// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:json_table/json_table.dart';

// // class TTJST extends StatefulWidget {
// //   TTJST({Key key}) : super(key: key);

// //   @override
// //   _TTJSTState createState() => _TTJSTState();
// // }

// // class _TTJSTState extends State<TTJST> {
// //     final String jsonSample =
// //       '[{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc"},{"name":"Shyam","email":"shyam23@gmail.com",'
// //       '"age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India",'
// //       '"area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
// //       '{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com",'
// //       '"age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India",'
// //       '"area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
// //       '{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,'
// //       '"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc",'
// //       '"day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';
// //     bool toggle = true;
// //   @override
// //   Widget build(BuildContext context) {
// //     var json = jsonDecode(jsonSample);
// //     return SingleChildScrollView(
// //       padding: EdgeInsets.all(16.0),
// //        child: Container(
// //          child: toggle ? Column(
// //            children: [
// //              JsonTable(
// //                json,
// //                showColumnToggle: true,
// //                allowRowHighlight: true,
// //                rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
// //                paginationRowCount: 4,
// //                onRowSelect: (index, map) {
// //                  print("index: $index");
// //                  print("map: $map");
// //                },
// //              ),
// //              SizedBox(height: 40,)
// //            ],
// //          ):  Center(
// //                   child: Text(getPrettyJSONString(jsonSample)),
// //           ),
// //        )
// //     );
// //   }
// //    String getPrettyJSONString(jsonObject) {
// //     JsonEncoder encoder = new JsonEncoder.withIndent('  ');
// //     String jsonString = encoder.convert(json.decode(jsonObject));
// //     return jsonString;
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tamagwa_shipping/widgets/AppBars.dart';
// import 'package:tamagwa_shipping/widgets/Banner.dart';
// import 'package:tamagwa_shipping/widgets/Footer.dart';
// import 'package:velocity_x/velocity_x.dart';

// class QuotePage extends StatefulWidget {
//   static const String routeName = '/quote';

//   @override
//   _QuotePageState createState() => _QuotePageState();
// }

// class _QuotePageState extends State<QuotePage> {
//   double _pb = 0.0;
//   TextEditingController _length = TextEditingController();
//   TextEditingController _width = TextEditingController();
//   TextEditingController _height = TextEditingController();

//   List<Table> total_table = [];
//   var id = 1;
//   int index = 0;

//   // List<TableRow> rows = [];

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Scaffold(
//       appBar: fullAppBar(context),
//       body: Container(
//         child: SafeArea(
//           child: ListView(
//             scrollDirection: Axis.vertical,
//             children: [
//               banners(context, "QUOTE"),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
//                 child: Text("Then click on calculate costs "
//                     "to get the price of your shipment. "
//                     "Remember that personal effects must be "
//                     "palletised if dropped off at a receiving "
//                     "centre. If opting for a collection service, "
//                     "this is not required. If you want to know "
//                     "the collection fees, please provide your "
//                     "post code below."),
//               ),
//               Container(
//                 height: 20.0,
//                 color: Vx.black,
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               // Text(
//               //   "\t PostCode:",
//               //   style: TextStyle(fontWeight: FontWeight.w600),
//               // ),
//               // ClipRect(
//               //   child: Padding(
//               //     padding:
//               //         const EdgeInsets.only(left: 8.0, right: 200.0, bottom: 0.0),
//               //     child: TextField(
//               //       decoration: InputDecoration(
//               //         contentPadding: EdgeInsets.all(0.0),
//               //         hintText: "\t Post Code",
//               //         border: OutlineInputBorder(),
//               //         prefixIcon: Container(
//               //           width: 5.0,
//               //           color: Color(0xffbdb9b9),
//               //           child: Icon(
//               //             // FontAwesomeIcons.locationArrow,
//               //             Icons.home,
//               //             color: Colors.black,
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               // Divider(),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   children: [
//                     Table(
//                       border: TableBorder.all(),
//                       children: [
//                         TableRow(
//                           children: [
//                             TableCell(
//                                 child: Center(
//                                     child: Text('#',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)))),
//                             TableCell(
//                               child: Center(
//                                   child: Text(
//                                 'Length (cm)',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               )),
//                             ),
//                             TableCell(
//                                 child: Center(
//                                     child: Text('Width (cm)',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)))),
//                             TableCell(
//                                 child: Center(
//                                     child: Text('Height (cm)',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)))),
//                             TableCell(
//                                 child: Center(
//                                     child: Text('Total Cost(E)',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)))),
//                             TableCell(
//                                 child: Center(
//                                     child: Text('Action',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)))),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Table(
//                       children: [
//                         TableRow(
//                           children: [
//                             TableCell(child: Center(child: Text('1'))),
//                             TableCell(
//                               child: Center(
//                                 child: Container(
//                                   height: 30.0,
//                                   margin: EdgeInsets.all(5.0),
//                                   padding: EdgeInsets.all(0.0),
//                                   child: TextField(
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.all(0.0),
//                                       hintText: "\t Length",
//                                       hintStyle: TextStyle(fontSize: 12.0),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(0.0),
//                                         ),
//                                         borderSide: BorderSide(
//                                             color: Vx.black, width: 2.0),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             TableCell(
//                               child: Center(
//                                 child: Container(
//                                   height: 30.0,
//                                   margin: EdgeInsets.all(5.0),
//                                   padding: EdgeInsets.all(0.0),
//                                   child: TextField(
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.all(0.0),
//                                       hintText: " Width",
//                                       hintStyle: TextStyle(fontSize: 12.0),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(0.0),
//                                         ),
//                                         borderSide: BorderSide(
//                                             color: Vx.black, width: 2.0),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             TableCell(
//                               child: Center(
//                                 child: Container(
//                                   height: 30.0,
//                                   margin: EdgeInsets.all(5.0),
//                                   padding: EdgeInsets.all(0.0),
//                                   child: TextField(
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(
//                                       contentPadding: EdgeInsets.all(0.0),
//                                       hintText: " Height",
//                                       hintStyle: TextStyle(fontSize: 12.0),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(0.0)),
//                                         borderSide: BorderSide(
//                                             color: Vx.black, width: 2.0),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             TableCell(child: Center(child: Text(''))),
//                             TableCell(
//                               child: Container(
//                                 height: 30.0,
//                                 margin: EdgeInsets.all(5.0),
//                                 child: RaisedButton(
//                                   padding: EdgeInsets.all(0.0),
//                                   child: Text(
//                                     "Remove package",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       decorationColor: Colors.white,
//                                       fontSize: 10.0,
//                                       color: Vx.white,
//                                       letterSpacing: 0.1,
//                                     ),
//                                   ),
//                                   onPressed: () {},
//                                   color: Vx.red300,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               FlatButton(
//                 child: Text("data"),
//                 onPressed: () {
//                   tableAddRow();
//                 },
//               ),
//               fullFooter(context, _pb),
//             ],
//           ),
//         ),
//       ),
//       // body: QuoteScreen(quoteBloc: _quoteBloc),
//     );
//   }

//   tableAddRow() {
//     setState(
//       () {
//         total_table.add(
//           Table(
//             children: [
//               TableRow(
//                 children: [
//                   TableCell(child: Center(child: Text('1'))),
//                   TableCell(
//                     child: Center(
//                       child: Container(
//                         height: 30.0,
//                         margin: EdgeInsets.all(5.0),
//                         padding: EdgeInsets.all(0.0),
//                         child: TextField(
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.all(0.0),
//                             hintText: "\t Length",
//                             hintStyle: TextStyle(fontSize: 12.0),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(0.0),
//                               ),
//                               borderSide:
//                                   BorderSide(color: Vx.black, width: 2.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   TableCell(
//                     child: Center(
//                       child: Container(
//                         height: 30.0,
//                         margin: EdgeInsets.all(5.0),
//                         padding: EdgeInsets.all(0.0),
//                         child: TextField(
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.all(0.0),
//                             hintText: " Width",
//                             hintStyle: TextStyle(fontSize: 12.0),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(0.0),
//                               ),
//                               borderSide:
//                                   BorderSide(color: Vx.black, width: 2.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   TableCell(
//                     child: Center(
//                       child: Container(
//                         height: 30.0,
//                         margin: EdgeInsets.all(5.0),
//                         padding: EdgeInsets.all(0.0),
//                         child: TextField(
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.all(0.0),
//                             hintText: " Height",
//                             hintStyle: TextStyle(fontSize: 12.0),
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(0.0)),
//                               borderSide:
//                                   BorderSide(color: Vx.black, width: 2.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   TableCell(child: Center(child: Text(''))),
//                   TableCell(
//                     child: Container(
//                       height: 30.0,
//                       margin: EdgeInsets.all(5.0),
//                       child: RaisedButton(
//                         padding: EdgeInsets.all(0.0),
//                         child: Text(
//                           "Remove package",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             decorationColor: Colors.white,
//                             fontSize: 10.0,
//                             color: Vx.white,
//                             letterSpacing: 0.1,
//                           ),
//                         ),
//                         onPressed: () {},
//                         color: Vx.red600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// QuoteBody()
