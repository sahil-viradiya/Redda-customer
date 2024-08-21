import 'package:intl/intl.dart';

class OrderHistoryModel {
  int? id;
  String? orderId;
  String? pickUpLatitude;
  String? pickUpLongitude;
  String? pickupAddress;
  String? senderLandmark;
  String? senderName;
  String? senderMobileNo;
  String? dropOffLatitude;
  String? dropOffLongitude;
  String? dropAddress;
  String? receiverLandmark;
  String? receiverName;
  String? receiverMobileNo;
  String? addressType;
  String? totalDistance;
  String? totalTime;
  int? unitCharge;
  String? totalCharges;
  String? rideStatus;
  String? orderDate;

  OrderHistoryModel(
      {this.id,
      this.orderId,
      this.pickUpLatitude,
      this.pickUpLongitude,
      this.pickupAddress,
      this.senderLandmark,
      this.senderName,
      this.senderMobileNo,
      this.dropOffLatitude,
      this.dropOffLongitude,
      this.dropAddress,
      this.receiverLandmark,
      this.receiverName,
      this.receiverMobileNo,
      this.addressType,
      this.totalDistance,
      this.totalTime,
      this.unitCharge,
      this.totalCharges,
      this.rideStatus,
      this.orderDate});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    pickUpLatitude = json['pickUpLatitude'];
    pickUpLongitude = json['pickUpLongitude'];
    pickupAddress = json['pickup_address'];
    senderLandmark = json['sender_landmark'];
    senderName = json['sender_name'];
    senderMobileNo = json['sender_mobile_no'];
    dropOffLatitude = json['dropOffLatitude'];
    dropOffLongitude = json['dropOffLongitude'];
    dropAddress = json['drop_address'];
    receiverLandmark = json['receiver_landmark'];
    receiverName = json['receiver_name'];
    receiverMobileNo = json['receiver_mobile_no'];
    addressType = json['address_type'];
    totalDistance = json['totalDistance'];
    totalTime = json['totalTime'];
    unitCharge = json['unit_charge'];
    totalCharges = json['totalCharges'];
    rideStatus = json['ride_status'];
    orderDate = json['order_date'];
  }
 String getFormattedOrderDate() {
    if (orderDate == null) return '';
    DateTime parsedDate = DateTime.parse(orderDate!);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['order_id'] = orderId;
    data['pickUpLatitude'] = pickUpLatitude;
    data['pickUpLongitude'] = pickUpLongitude;
    data['pickup_address'] = pickupAddress;
    data['sender_landmark'] = senderLandmark;
    data['sender_name'] = senderName;
    data['sender_mobile_no'] = senderMobileNo;
    data['dropOffLatitude'] = dropOffLatitude;
    data['dropOffLongitude'] = dropOffLongitude;
    data['drop_address'] = dropAddress;
    data['receiver_landmark'] = receiverLandmark;
    data['receiver_name'] = receiverName;
    data['receiver_mobile_no'] = receiverMobileNo;
    data['address_type'] = addressType;
    data['totalDistance'] = totalDistance;
    data['totalTime'] = totalTime;
    data['unit_charge'] = unitCharge;
    data['totalCharges'] = totalCharges;
    data['ride_status'] = rideStatus;
    data['order_date'] = orderDate;
    return data;
  }
}
