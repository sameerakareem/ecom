class RegistrationModel {
  String? name;
  String? email;
  String? password;
  String? avatar;
  String? id;

  RegistrationModel({
    this.name,
    this.email,
    this.password,
    this.avatar,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
    };
  }
  Map<String, dynamic> toResponseJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'id':id
    };
  }
}
