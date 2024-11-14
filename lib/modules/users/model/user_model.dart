class UsersModel {
  String? userID;
  String? fullname;
  String? registerTime;
  String? authId;
  String? token;
  String? image;
  String? verificactionCode;
  bool? isVerified;
  String? phone;
  String? email;
  bool? isActive;

  UsersModel(
      {this.fullname,
      this.registerTime,
      this.userID,
      this.authId,
      this.token,
      this.image,
      this.verificactionCode,
      this.isVerified,
      this.phone,
      this.email,
      this.isActive});

  UsersModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    registerTime = json['registerTime'];
    authId = json['authId'];
    token = json['token'];
    image = json['image'];
    verificactionCode = json['verificactionCode'].toString();
    isVerified = json['isVerified'];
    phone = json['phone'];
    email = json['email'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullname'] = fullname;
    data['registerTime'] = registerTime;
    data['authId'] = authId;
    data['token'] = token;
    data['image'] = image;
    data['verificactionCode'] = verificactionCode;
    data['isVerified'] = isVerified;
    data['phone'] = phone;
    data['email'] = email;
    data['isActive'] = isActive;
    return data;
  }
}
