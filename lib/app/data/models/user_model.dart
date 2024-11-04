class User {
  int? userId;
  String? email;
  String? name;
  String? dob;
  String? gender;
  String? phoneNumber;

  User(
      {this.userId,
      this.email,
      this.name,
      this.dob,
      this.gender,
      this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['email'] = email;
    data['name'] = name;
    data['dob'] = dob;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
