class SettingModel {
  dynamic salesMobile;
  dynamic salesEmail;
  dynamic supportMobile;
  dynamic whatsappMobile;
  dynamic supportEmail;
  dynamic supportUrl;

  SettingModel(
      {this.salesMobile,
      this.salesEmail,
      this.supportMobile,
      this.whatsappMobile,
      this.supportEmail,
      this.supportUrl});

  SettingModel.fromJson(Map<String, dynamic> json) {
    salesMobile = json['sales_mobile'];
    salesEmail = json['sales_email'];
    supportMobile = json['support_mobile'];
    whatsappMobile = json['whatsapp_mobile'];
    supportEmail = json['support_email'];
    supportUrl = json['support_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_mobile'] = this.salesMobile;
    data['sales_email'] = this.salesEmail;
    data['support_mobile'] = this.supportMobile;
    data['whatsapp_mobile'] = this.whatsappMobile;
    data['support_email'] = this.supportEmail;
    data['support_url'] = this.supportUrl;
    return data;
  }
}
