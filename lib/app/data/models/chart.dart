class PicPlanChart {
  List<List<dynamic>>? beforeLimit;
  List<List<dynamic>>? afterLimit;

  PicPlanChart({this.beforeLimit, this.afterLimit});

  factory PicPlanChart.fromJson(Map<String, dynamic> json) {
    return PicPlanChart(
      beforeLimit: (json['before_limit'] as List<dynamic>?)
          ?.map((e) => List<dynamic>.from(e))
          .toList(),
      afterLimit: (json['after_limit'] as List<dynamic>?)
          ?.map((e) => List<dynamic>.from(e))
          .toList(),
    );
  }
}