import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CredentialUser {
  final String uid;
  final String fcmToken;
  final String email;
  final String name;

  CredentialUser({
    @required this.email,
    @required this.fcmToken,
    @required this.name,
    @required this.uid,
  });

  factory CredentialUser.fromSnapshot(DocumentSnapshot ds) {
    return CredentialUser(
      email: ds['email'],
      fcmToken: ds['fcmToken'],
      name: ds['name'],
      uid: ds['uid'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'email': email,
      'fcmToken': fcmToken,
      'name': name,
      'uid': uid,
    };
  }
}
