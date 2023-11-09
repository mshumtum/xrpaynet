class CardListingResponse {
  String? message;
  List<CardListingItem>? result;
  String? status;

  CardListingResponse({this.message, this.result, this.status});

  CardListingResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = <CardListingItem>[];
      json['result'].forEach((v) {
        result!.add(new CardListingItem.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class CardListingItem {
  int? id;
  String? cardType;
  String? lockingAmount;
  String? hyperCardFee;
  String? issuanceFee;
  String? maintenanceFee;
  String? conversionFee;
  String? depositFee;
  String? paymentMethod;
  String? currency;
  bool? isDisabled;
  List<String>? imagePath;

  CardListingItem(
      {this.id,
      this.cardType,
      this.lockingAmount,
      this.hyperCardFee,
      this.issuanceFee,
      this.maintenanceFee,
      this.conversionFee,
      this.depositFee,
      this.paymentMethod,
      this.currency,
      this.isDisabled,
      this.imagePath});

  CardListingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardType = json['cardType'];
    lockingAmount = json['lockingAmount'];
    hyperCardFee = json['hyperCardFee'];
    issuanceFee = json['issuanceFee'];
    maintenanceFee = json['maintenanceFee'];
    conversionFee = json['conversionFee'];
    depositFee = json['depositFee'];
    paymentMethod = json['paymentMethod'];
    currency = json['currency'];
    isDisabled = json['isDisabled'];
    imagePath = json['imagePath'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cardType'] = this.cardType;
    data['lockingAmount'] = this.lockingAmount;
    data['hyperCardFee'] = this.hyperCardFee;
    data['issuanceFee'] = this.issuanceFee;
    data['maintenanceFee'] = this.maintenanceFee;
    data['conversionFee'] = this.conversionFee;
    data['depositFee'] = this.depositFee;
    data['paymentMethod'] = this.paymentMethod;
    data['currency'] = this.currency;
    data['isDisabled'] = this.isDisabled;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
