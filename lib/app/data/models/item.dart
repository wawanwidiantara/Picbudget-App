class Item {
  final String id;
  String itemName;
  double itemPrice; // Corrected to use Dart's `double` type
  final DateTime createdAt;
  final DateTime updatedAt;
  final String transaction;

  Item({
    required this.id,
    required this.itemName,
    required this.itemPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.transaction,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      itemName: json['item_name'] as String,
      itemPrice:
          double.parse(json['item_price'].toString()), // Safely parse to double
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      transaction: json['transaction'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_name': itemName,
      'item_price': itemPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'transaction': transaction,
    };
  }
}
