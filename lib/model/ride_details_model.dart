class RideDetailsModel {
  final double? pickLat;
  final double? pickLng;
  final String? pickUpAddress;
  final String? senderLandMark;
  final String? senderName;
  final String? senderMobileNo;
  final double? dropLat;
  final double? dropLng;
  final String? reciverAddress;
  final String? reciverLandmark;
  final String? reciverName;
  final String? reciverMobileNo;
  final String? addressType;

  RideDetailsModel({
    this.pickLat,
    this.pickLng,
    this.pickUpAddress,
    this.senderLandMark,
    this.senderName,
    this.senderMobileNo,
    this.dropLat,
    this.dropLng,
    this.reciverAddress,
    this.reciverLandmark,
    this.reciverName,
    this.reciverMobileNo,
    this.addressType,
  });

  factory RideDetailsModel.fromJson(Map<String, dynamic> json) {
    return RideDetailsModel(
      pickLat: json['pickLat'] as double?,
      pickLng: json['pickLng'] as double?,
      pickUpAddress: json['pickUpAddress'] as String?,
      senderLandMark: json['senderLandMark'] as String?,
      senderName: json['senderName'] as String?,
      senderMobileNo: json['senderMobileNo'] as String?,
      dropLat: json['dropLat'] as double?,
      dropLng: json['dropLng'] as double?,
      reciverAddress: json['reciverAddress'] as String?,
      reciverLandmark: json['reciverLandmark'] as String?,
      reciverName: json['reciverName'] as String?,
      reciverMobileNo: json['reciverMobileNo'] as String?,
      addressType: json['addressType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pickLat': pickLat,
      'pickLng': pickLng,
      'pickUpAddress': pickUpAddress,
      'senderLandMark': senderLandMark,
      'senderName': senderName,
      'senderMobileNo': senderMobileNo,
      'dropLat': dropLat,
      'dropLng': dropLng,
      'reciverAddress': reciverAddress,
      'reciverLandmark': reciverLandmark,
      'reciverName': reciverName,
      'reciverMobileNo': reciverMobileNo,
      'addressType': addressType,
    };
  }
}
