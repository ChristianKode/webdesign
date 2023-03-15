import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseServices {
  final  _realtimeDb = FirebaseDatabase.instance.ref();

  Future<void> uploadJob(
      String aid,
      String title,
      String descprition,
      String address,
      String zipcode,
      String price,
      String uid,
      String imageUrl) async {
    await _realtimeDb.child(aid).set({
      "title": title,
      "descprition": descprition,
      "address": address,
      "zipcode": zipcode,
      "price": price,
      "uid": uid,
      "aid": aid,
      "img1": imageUrl,
    });
  }
}
