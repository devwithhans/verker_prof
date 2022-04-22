import 'package:intl/intl.dart';

var kFormatQuantity = NumberFormat("###.##", "de_DK");
var kFormatCurrency = NumberFormat.currency(
    locale: "de_DK", symbol: "kr.", customPattern: '###,###.00 kr');
