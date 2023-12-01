// Purpose: User model [id,username,email,password]
class UserModel {
  int? id;
  String? username;
  String? email;
  String? password;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], username: json['username'], email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'email': email, 'password': password};
  }
}
