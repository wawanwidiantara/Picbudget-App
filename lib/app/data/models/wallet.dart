class Wallet {
  final String id;
  final String name;
  final String type;
  final String balance;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String user;

  Wallet({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      balance: json['balance'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      user: json['user'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'balance': balance,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user,
    };
  }
}
