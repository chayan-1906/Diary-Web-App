import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  return DateFormat.yMMMd().format(dateTime);
}

String formatDateFromTimestamp(Timestamp timestamp) {
  return DateFormat.yMMMd().add_EEEE().format(timestamp.toDate());
}

String formatDateFromTimestampHour(Timestamp timestamp) {
  return DateFormat.jm().format(timestamp.toDate());
}
