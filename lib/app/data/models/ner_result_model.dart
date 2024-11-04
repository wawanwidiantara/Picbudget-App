class NerResult {
  int? total;
  String? date;
  String? address;
  List<Items>? items;
  String? receiptImageUrl;

  NerResult(
      {this.total, this.date, this.address, this.items, this.receiptImageUrl});

  NerResult.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    date = json['date'];
    address = json['address'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    receiptImageUrl = json['receipt_image_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total'] = total;
    data['date'] = date;
    data['address'] = address;
    if (items != null) {
      data['items'] = items?.map((v) => v.toJson()).toList();
    }
    data['receipt_image_url'] = receiptImageUrl;
    return data;
  }
}

class Items {
  String? item;
  int? price;

  Items({this.item, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item'] = item;
    data['price'] = price;
    return data;
  }
}
