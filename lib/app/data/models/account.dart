class Account {
  final String id;
  final String email;
  final String? fullName;
  final String gender;
  final int? age;
  final String? phoneNumber;
  final String? photoUrl;

  Account({
    required this.id,
    required this.email,
    this.fullName,
    required this.gender,
    this.age,
    this.phoneNumber,
    this.photoUrl,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      gender: json['gender'] as String,
      age: json['age'] as int?,
      phoneNumber: json['phone_number'] as String?,
      photoUrl: json['photo_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'gender': gender,
      'age': age,
      'phone_number': phoneNumber,
      'photo_url': photoUrl,
    };
  }
}
