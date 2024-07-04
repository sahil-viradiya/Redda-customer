class TranscationHistoryModel {
  final int? id;
  final int? userId;
  final String? transactionId;
  final int? amount;
  final String? type;

  TranscationHistoryModel({this.id, this.userId, this.transactionId, this.amount, this.type});

  factory TranscationHistoryModel.fromJson(Map<String, dynamic> json) => TranscationHistoryModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    transactionId: json['transaction_id'] as String?,
    amount: json['amount'] as int?,
    type: json['type'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'transaction_id': transactionId,
    'amount': amount,
    'type': type,
  };
}
