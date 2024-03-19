import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Helper {
  String formatDate(Timestamp date) {
    return DateFormat('h:mm a / d MMM y').format(date.toDate());
  }
}
