class UserModel {
  String? lanCode;
  String? name;
  String? imgUrl;
  String? phone;
  List<String>? topics;

  UserModel({this.lanCode, this.name, this.phone, this.topics});

  UserModel.fromJson(Map<String, dynamic> json) {
    lanCode = json['lanCode'];
    name = json['name'];
    imgUrl = json['imgUrl'];
    phone = json['phone'];
    topics = json['topics'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lanCode'] = this.lanCode;
    data['name'] = this.name;
    data['imgUrl'] = this.imgUrl;
    data['phone'] = this.phone;
    data['topics'] = this.topics;
    return data;
  }
}
