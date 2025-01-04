import 'package:picbudget_app/app/data/models/chart.dart';

class Plan {
  String? id;
  String? name;
  double? amount;
  double? remaining;
  double? progress;
  bool? isOverspent;
  String? period;
  bool? notifyOverspent;
  double? dailyAverage;
  double? dailyRecommended;
  double? spent;
  List<dynamic>? lastPeriods;
  List<dynamic>? spendingByLabels;
  List<String>? labels;
  List<String>? wallets;
  PicPlanChart? picPlanChart;

  Plan({
    this.id,
    this.name,
    this.amount,
    this.remaining,
    this.progress,
    this.isOverspent,
    this.period,
    this.notifyOverspent,
    this.dailyAverage,
    this.dailyRecommended,
    this.spent,
    this.lastPeriods,
    this.spendingByLabels,
    this.labels,
    this.wallets,
    this.picPlanChart,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      name: json['name'],
      amount: _toDouble(json['amount']),
      remaining: _toDouble(json['remaining']),
      progress: _toDouble(json['progress']),
      isOverspent: json['is_overspent'] ?? false,
      period: json['period'],
      notifyOverspent: json['notify_overspent'] ?? false,
      dailyAverage: _toDouble(json['daily_average']),
      dailyRecommended: _toDouble(json['daily_recommended']),
      spent: _toDouble(json['spent']),
      lastPeriods: json['last_periods'] ?? [],
      spendingByLabels: json['spending_by_labels'] ?? [],
      labels: List<String>.from(json['labels'] ?? []),
      wallets: List<String>.from(json['wallets'] ?? []),
      picPlanChart: json['picplan_chart'] != null
          ? PicPlanChart.fromJson(json['picplan_chart'])
          : null,
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }
    if (value is int) {
      return value.toDouble();
    }
    if (value is double) {
      return value;
    }
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
