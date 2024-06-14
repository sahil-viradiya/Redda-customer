// To parse this JSON data, do
//
//     final getAddressModel = getAddressModelFromMap(jsonString);

import 'dart:convert';

GetAddressModel getAddressModelFromMap(String str) => GetAddressModel.fromMap(json.decode(str));

String getAddressModelToMap(GetAddressModel data) => json.encode(data.toMap());

class GetAddressModel {
  bool? status;
  String? message;
  List<Datum>? data;

  GetAddressModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetAddressModel.fromMap(Map<String, dynamic> json) => GetAddressModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  int? id;
  String? name;
  String? house;
  String? area;
  String? direction;
  int? mobileNo;
  String? addressType;

  Datum({
    this.id,
    this.name,
    this.house,
    this.area,
    this.direction,
    this.mobileNo,
    this.addressType,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    house: json["house"],
    area: json["area"],
    direction: json["direction"],
    mobileNo: json["mobile_no"],
    addressType: json["address_type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "house": house,
    "area": area,
    "direction": direction,
    "mobile_no": mobileNo,
    "address_type": addressType,
  };
}
