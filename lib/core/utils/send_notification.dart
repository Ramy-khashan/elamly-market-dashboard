 import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future sendNotificaction({
  required String token,
  required String title,
  required String body,
}) async {
  const String accessToken =
      'AAAAgBV3Gjk:APA91bFgD2n0uDiONJViKYF5-2tKMZb_T9ktIfNU4p2t5lMZpKf4cuu2nbwIVlkJYn7PiOu8OPHoHvvB5yxicZDI6G_P3pjk0bXo5MzUywPmLsJS0WXeKJCMvp6lf2UsvPkCUqCQrra9';
  final data = {
    "notification": {"title": "FCM Message", "body": "This is an FCM Message"},
    "token": "bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1..."
  };
  debugPrint(
      "-------------------------------------------------------------------------");
  debugPrint(data.toString());
  // https://fcm.goo/gleapis.com/v1/projects/myproject-b5ae1/messages:send
  await Dio().post(
      "https://fcm.googleapis.com/v1/projects/notification-5759a/messages:send",
      // "https://fcm.googleapis.com/v1/projects/doctors-369e4/messages:send",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'key=$accessToken'
      }),
      data: data);
  // FirebaseMessaging.instance.sendMessage();
} 
/*
POST https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send HTTP/1.1

Content-Type: application/json
Authorization: Bearer ya29.ElqKBGN2Ri_Uz...HnS_uNreA

{
   "message":{
      "token":"bk3RNwTe3H0:CI2k_HHwgIpoDKCIZvvDMExUdFQ3P1...",
      "notification":{
        "body":"This is an FCM notification message!",
        "title":"FCM Message"
      }
   }
}


{
  "message": {
    "token": "<registration_token>", // Replace with the target device's token
    "notification": {
      "title": "My Notification Title",
      "body": "This is the notification message."
    }
  }
}

*/




