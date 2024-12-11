class Label {
  final String id;
  final String name;
  final String emoticon;
  final DateTime createdAt;
  final DateTime updatedAt;

  Label({
    required this.id,
    required this.name,
    required this.emoticon,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Label instance from JSON
  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      id: json['id'] as String,
      name: json['name'] as String,
      emoticon: json['emoticon'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Convert a Label instance into a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emoticon': emoticon,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
