class WalletBalanceModel {
  int? userId;
  int? customerWallet;
  int? customerHoldAmount;

  WalletBalanceModel(
      {this.userId, this.customerWallet, this.customerHoldAmount});

  WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    customerWallet = json['customer_wallet'];
    customerHoldAmount = json['customer_hold_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['customer_wallet'] = customerWallet;
    data['customer_hold_amount'] = customerHoldAmount;
    return data;
  }
}
