import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

Future<String> addHistory(
    String merchantId, int points, String type, String userId) async {
  final docUser = FirebaseFirestore.instance
      .collection('History')
      .doc(DateTime.now().toString());

  final json = {
    'points': points,
    'type': type, // Earned/Redeemed
    'userId': userId,
    'dateTime': DateTime.now(),
    'id': docUser.id,
    'merchantId': merchantId,
    'dateFormatted': DateFormat('MMM dd, yyyy h:mm a').format(DateTime.now()),
    'year': DateTime.now().year,
    'month': DateTime.now().month,
    'day': DateTime.now().day,
  };

  await docUser.set(json);

  return docUser.id;
}
