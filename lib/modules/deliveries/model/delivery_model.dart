 
class DeliveryModel {
  String? nationalIdFront;
  String? createdBy;
  String? password;
  String? age;
  String? phoneNumber2;
  String? deliveryId;
  String? nationalIdBack;
  String? name;
  String? email;
  String? phoneNumber1;
  bool? isActive;
  String? createdAt;
  String? personalImage;

  DeliveryModel(
      {this.nationalIdFront,
      this.createdBy,
      this.password,
      this.age,
      this.phoneNumber2,
      this.deliveryId,
      this.nationalIdBack,
      this.name,
      this.createdAt,
      this.email,
      this.phoneNumber1,
      this.isActive,
      this.personalImage});

  DeliveryModel.fromJson(Map<String, dynamic> json) {
    nationalIdFront = json['national_id_front'];
    createdBy = json['created_by'];
    password = json['password'];
    age = json['age'];
    createdAt = json['created_at'];
    phoneNumber2 = json['phone_number2'];
    deliveryId = json['delivery_id'];
    nationalIdBack = json['national_id_back'];
    name = json['name'];
    email = json['email'];
    phoneNumber1 = json['phone_number1'];
    isActive = json['is_active'];
    personalImage = json['personal_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['national_id_front'] = nationalIdFront;
    data['created_by'] = createdBy;
    data['password'] = password;
    data['age'] = age;
    data['phone_number2'] = phoneNumber2;
    data['delivery_id'] = deliveryId;
    data['national_id_back'] = nationalIdBack;
    data['name'] = name;
    data['email'] = email;
    data['created_at'] = createdAt;

    data['phone_number1'] = phoneNumber1;
    data['is_active'] = isActive;
    data['personal_image'] = personalImage;
    return data;
  }
}
