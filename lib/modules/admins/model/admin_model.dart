class AdminModel {
  String? email;
  String? id;
  String? name;
  String? password;
  String? role;

  AdminModel({this.email, this.id, this.name, this.password, this.role});

  AdminModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['id'];
    name = json['name'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}
