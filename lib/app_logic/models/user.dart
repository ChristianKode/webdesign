import 'package:meta/meta.dart';

@immutable
class User {
  const User(
      {required this.uid,
      required this.email,
      required this.fornavn,
      required this.etternavn,
      required this.telefon});

  final String uid;
  final String email;
  final String fornavn;
  final String etternavn;
  final String telefon;
}
