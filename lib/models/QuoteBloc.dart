import 'dart:math';

import 'package:frideos/frideos.dart';

class DynamicQuote {
  // var lengthFields;

  DynamicQuote() {
    lengthFields.addAll([StreamedValue<String>(initialData: '')]);
    widthFields.addAll([StreamedValue<String>(initialData: '')]);
    heightFields.addAll([StreamedValue<String>(initialData: '')]);
    costFields.addAll([StreamedValue<String>(initialData: '')]);
    tCost;
    for (var item in lengthFields.value) {
      item.onChange(checkForm);
    }
    for (var item in widthFields.value) {
      item.onChange(checkForm);
    }
    for (var item in heightFields.value) {
      item.onChange(checkForm);
    }
  }
  // double totalPrice;
  final lengthFields = StreamedList<StreamedValue<String>>(initialData: []);
  final widthFields = StreamedList<StreamedValue<String>>(initialData: []);
  final heightFields = StreamedList<StreamedValue<String>>(initialData: []);
  final costFields = StreamedList<StreamedValue<String>>(initialData: []);
  final isFormValid = StreamedList<bool>();
  var tCost = '';

  void newFields() {
    lengthFields.addElement(StreamedValue<String>());
    widthFields.addElement(StreamedValue<String>());
    heightFields.addElement(StreamedValue<String>());
    costFields.addElement(StreamedValue<String>());

    lengthFields.value.last.onChange(checkForm);
    widthFields.value.last.onChange(checkForm);
    heightFields.value.last.onChange(checkForm);

    checkForm(null);
  }

  void checkForm(String _) {
    bool isValidFieldTypelengthFields = true;
    bool isValidFieldTypeWidth = true;
    bool isValidFieldTypeWeigth = true;
  }

  void removedField(int index) {
    lengthFields.removeAt(index);
    widthFields.removeAt(index);
    heightFields.removeAt(index);
    costFields.removeAt(index);
  }

  void dispose() {
    for (var item in lengthFields.value) {
      item.dispose();
    }
    lengthFields.dispose();

    for (var item in heightFields.value) {
      item.dispose();
    }
    heightFields.dispose();

    for (var item in widthFields.value) {
      item.dispose();
    }
    widthFields.dispose();

    for (var item in costFields.value) {
      item.dispose();
    }
    costFields.dispose();

    isFormValid.dispose();
  }

  void submit() {
    print("Action");
    // for (var item in lengthFields.value) {
    //   print(' lenght ${item.value}');
    // }
    double totalPrice = 0;
    double fCurrentValue = 1;
    double rowPrice = 0;

    for (var i = 0; i < lengthFields.length; i++) {
      rowPrice = max(
              1.0,
              ((double.parse(lengthFields.value[i].value)) *
                  (double.parse(widthFields.value[i].value)) *
                  (double.parse(heightFields.value[i].value)) /
                  5000)) *
          3;
      costFields.value[i].value = rowPrice.toStringAsFixed(2).toString();
      print(costFields.value[i].value);
      totalPrice += rowPrice;
    }
    tCost = totalPrice.toStringAsFixed(2);
    print(totalPrice);
  }
}

final bloc = DynamicQuote();
