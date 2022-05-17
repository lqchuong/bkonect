import 'package:intl/intl.dart';

class CurrencyFormat {
  CurrencyFormat();

  static String formatMoney(double money) {
    if (money != null) {
      var removeAfterDoc = money.toString().split('.')[0];
      String moneyFormat;
      double value = double.parse(removeAfterDoc);
      final formatter = new NumberFormat("#,##0", "en_US");
      moneyFormat = formatter.format(value);
      return moneyFormat;
    } else {
      return "";
    }
  }
}
