class FetchAddressModel {
  final int id;
  final int userId;
  final String address;
  final String landmark;
  final String senderName;
  final String senderMobile;

  FetchAddressModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.landmark,
    required this.senderName,
    required this.senderMobile,
  });

  // Factory method to create a FetchAddressModel from JSON
  factory FetchAddressModel.fromJson(Map<String, dynamic> json) {
    return FetchAddressModel(
      id: json['id'],
      userId: json['user_id'],
      address: json['address'],
      landmark: json['landmark'],
      senderName: json['sender_name'],
      senderMobile: json['sender_mobile'],
    );
  }
}
