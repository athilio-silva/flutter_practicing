import 'package:intl/intl.dart';

class Formatting {
  static String formatDate(String date) {
    DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(date);
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}
