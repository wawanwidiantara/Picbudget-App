class Transaction {
  int? id;
  int? wallet;
  String? receiptImage;
  String? amount;
  String? location;
  String? formattedDate;
  List<Items>? items;

  Transaction(
      {this.id,
      this.wallet,
      this.receiptImage,
      this.amount,
      this.location,
      this.formattedDate,
      this.items});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wallet = json['wallet'];
    receiptImage = json['receipt_image'];
    amount = json['amount'];
    location = json['location'];
    formattedDate = json['formatted_date'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['wallet'] = wallet;
    data['receipt_image'] = receiptImage;
    data['amount'] = amount;
    data['location'] = location;
    data['formatted_date'] = formattedDate;
    if (items != null) {
      data['items'] = items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? transaction;
  String? itemName;
  String? itemPrice;

  Items({this.id, this.transaction, this.itemName, this.itemPrice});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transaction = json['transaction'];
    itemName = json['item_name'];
    itemPrice = json['item_price'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['transaction'] = transaction;
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    return data;
  }
}
