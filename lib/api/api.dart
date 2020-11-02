// import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tamagwa_shipping/models/PriceList_model.dart';
import 'package:tamagwa_shipping/models/TimeTable_model.dart';
//import 'package:tamagwa_shipping/models/TimeTable_model.dart';

class Services {
  Services();
  static const String _url = 'https://tamangwashipping.com/api.php?action=';
  // static const String _url1 = 'http://10.131.61.145:8000/';
  bookingData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  static Future<List<Shipment>> getShipment() async {
    try {
      final response = await http.get(_url + 'getshipmentprojects');
      if (response.statusCode == 200) {
        var shipment = json.decode(response.body).cast<Map<String, dynamic>>();
        return shipment
            .map<Shipment>((json) => Shipment.fromJson(json))
            .toList();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<PriceList>> getItemPriceList() async {
    try {
      final response = await http.get(_url + 'getitempricelist');
      if (response.statusCode == 200) {
        var priceList = json.decode(response.body).cast<Map<String, dynamic>>();
        return priceList
            .map<PriceList>((json) => PriceList.fromJson(json))
            .toList();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  trackShipmentPost(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
      fullUrl,
      headers: _setHeaders(),
      body: data,
    );
  }

  _setHeaders() => {'Content-Type': 'application/json'};
}
