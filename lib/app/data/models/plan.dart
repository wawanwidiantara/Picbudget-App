class Plan {
  String? id;
  String? name;
  double? amount;
  double? progress;
  bool? isOverspent;
  String? period;
  bool? notifyOverspent;
  double? remaining;
  double? dailyAverage;
  double? dailyRecommended;
  List<dynamic>? lastPeriods;
  List<dynamic>? spendingByLabels;
  List<dynamic>? labels;
  List<String>? wallets;

  Plan({
    this.id,
    this.name,
    this.amount,
    this.progress,
    this.isOverspent,
    this.period,
    this.notifyOverspent,
    this.remaining,
    this.dailyAverage,
    this.dailyRecommended,
    this.lastPeriods,
    this.spendingByLabels,
    this.labels,
    this.wallets,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      name: json['name'],
      amount: double.tryParse(json['amount'] ?? '0.0'),
      progress: json['progress'] ?? 0.0,
      isOverspent: json['is_overspent'] ?? false,
      period: json['period'],
      notifyOverspent: json['notify_overspent'] ?? false,
      remaining: json['remaining'] ?? 0.0,
      dailyAverage: json['daily_average'] ?? 0.0,
      dailyRecommended: json['daily_recommended'] ?? 0.0,
      lastPeriods: json['last_periods'] ?? [],
      spendingByLabels: json['spending_by_labels'] ?? [],
      labels: json['labels'] ?? [],
      wallets: List<String>.from(json['wallets'] ?? []),
    );
  }
}
