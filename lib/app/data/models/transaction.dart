import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String type;
  final String amount;
  final DateTime transactionDate;
  final String? location;
  final String receipt;
  final String method;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String wallet;
  final List<String> labels;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.transactionDate,
    this.location,
    required this.receipt,
    required this.method,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.wallet,
    required this.labels,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      type: json['type'] as String,
      amount: json['amount'] as String,
      transactionDate: DateTime.parse(json['transaction_date'] as String),
      location: json['location'] as String?,
      receipt: json['receipt'] as String,
      method: json['method'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      wallet: json['wallet'] as String,
      labels: List<String>.from(json['labels']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'transaction_date': transactionDate.toIso8601String(),
      'location': location,
      'receipt': receipt,
      'method': method,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'wallet': wallet,
      'labels': labels,
    };
  }

  String getFormattedTransactionDate() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(transactionDate.toLocal());
  }
}
