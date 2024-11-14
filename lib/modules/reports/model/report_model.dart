class ReportsModel {
  String? id;
  String? reportName;
  String? report;
  String? reportPhone;
  String? email;
  String? fullName;
  String? phone;
  String? userId;
  String? notificationToken;

  ReportsModel(
      {this.reportName,
      this.report,
      this.id,
      this.reportPhone,
      this.email,
      this.fullName,
      this.phone,
      this.userId,
      this.notificationToken});

  ReportsModel.fromJson(Map<String, dynamic> json) {
    reportName = json['report_name'];
    report = json['report'];
    reportPhone = json['report_phone'];
    email = json['email'];
    fullName = json['full_name'];
    phone = json['phone'];
    userId = json['user_id'];
    notificationToken = json['notification_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_name'] = reportName;
    data['report'] = report;
    data['report_phone'] = reportPhone;
    data['email'] = email;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['user_id'] = userId;
    data['notification_token'] = notificationToken;
    return data;
  }
}
