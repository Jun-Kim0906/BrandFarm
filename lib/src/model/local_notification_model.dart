import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LocalNotificationModel {
  final String title;
  final String body;
  final String notId;

  LocalNotificationModel({
    @required this.title,
    @required this.body,
    @required this.notId,
  });

  factory LocalNotificationModel.fromSnapshot(DocumentSnapshot ds) {
    return LocalNotificationModel(
      title: ds['title'],
      body: ds['body'],
      notId: ds['notId'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'title': title,
      'body': body,
      'notId': notId,
    };
  }
}