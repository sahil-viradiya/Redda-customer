class TempRideMdel {
  String? rideId;
  String? totalDistance;
  String? totalTime;
  int? unitCharge;
  int? totalCharges;

  TempRideMdel(
      {this.rideId,
      this.totalDistance,
      this.totalTime,
      this.unitCharge,
      this.totalCharges});

  TempRideMdel.fromJson(Map<String, dynamic> json) {
    rideId = json['ride_id'];
    totalDistance = json['totalDistance'];
    totalTime = json['totalTime'];
    unitCharge = json['unit_charge'];
    totalCharges = json['totalCharges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ride_id'] = rideId;
    data['totalDistance'] = totalDistance;
    data['totalTime'] = totalTime;
    data['unit_charge'] = unitCharge;
    data['totalCharges'] = totalCharges;
    return data;
  }
}
