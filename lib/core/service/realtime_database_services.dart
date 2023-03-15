import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseServices {
  final DatabaseReference _realtimeDb = FirebaseDatabase.instance.ref();
}
