import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = "";
    var valuehandle = newValue.text.replaceAll(new RegExp(r','), '');
    if (valuehandle.length > 17) valuehandle = valuehandle.substring(0, 17);
    if (valuehandle.contains('.')) {
      var countlength = valuehandle.split('.')[1].length;
      if (countlength == 0) {
        double value = double.parse(valuehandle);
        final formatter = new NumberFormat("#,##0", "en_US");
        newText = formatter.format(value) + ".";
      } else if (countlength == 1) {
        double value = double.parse(valuehandle);
        final formatter = new NumberFormat("#,##0.0", "en_US");
        newText = formatter.format(value);
      } else {
        valuehandle = valuehandle.split('.')[0] +
            "." +
            valuehandle.split('.')[1].substring(0, 2);
        double value = double.parse(valuehandle);
        final formatter = new NumberFormat("#,##0.00", "en_US");
        newText = formatter.format(value);
      }
    } else {
      double value = double.parse(valuehandle);
      final formatter = new NumberFormat("#,##0", "en_US");
      newText = formatter.format(value);
    }

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
