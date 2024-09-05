// To parse this JSON data, do
//
//     final bookingList = bookingListFromJson(jsonString);

import 'dart:convert';

BookingList bookingListFromJson(String str) => BookingList.fromJson(json.decode(str));

String bookingListToJson(BookingList data) => json.encode(data.toJson());

class BookingList {
  String code;
  String status;
  String message;
  List<Booking> response;

  BookingList({
    required this.code,
    required this.status,
    required this.message,
    required this.response,
  });

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    response: List<Booking>.from(json["response"].map((x) => Booking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class Booking {
  String title;
  String fromDate;
  String fromTime;
  String toDate;
  String toTime;

  Booking({
    required this.title,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    title: json["title"],
    fromDate: json["from_date"],
    fromTime: json["from_time"],
    toDate: json["to_date"],
    toTime: json["to_time"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "from_date": fromDate,
    "from_time": fromTime,
    "to_date": toDate,
    "to_time": toTime,
  };
}
