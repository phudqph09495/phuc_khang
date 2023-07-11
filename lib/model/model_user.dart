class ModelUser {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? type;
  String? dateOfBirth;
  Gender? gender;
  String? balance;
  String? avatar;
  String? thirdPartyId;
  String? thirdPartyType;
  String? thirdPartyToken;
  Location? location;
  Setting? setting;

  ModelUser(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.dateOfBirth,
        this.gender,
        this.balance,
        this.avatar,
        this.type,
        this.thirdPartyId,
        this.thirdPartyType,
        this.thirdPartyToken,
        this.location,
        this.setting});

  ModelUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender =
    json['gender'] != null ? new Gender.fromJson(json['gender']) : null;
    balance = json['balance'];
    avatar = json['avatar'];
    type=json['type'];
    thirdPartyId = json['third_party_id'];
    thirdPartyType = json['third_party_type'];
    thirdPartyToken = json['third_party_token'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    setting =
    json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
  }


}

class Gender {
  String? id;
  String? name;

  Gender({this.id, this.name});

  Gender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}

class Location {
  String? address;
  Gender? region;
  Gender? district;

  Location({this.address, this.region, this.district});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    region =
    json['region'] != null ? new Gender.fromJson(json['region']) : null;
    district =
    json['district'] != null ? new Gender.fromJson(json['district']) : null;
  }


}

class Setting {
  String? enableNotification;

  Setting({this.enableNotification});

  Setting.fromJson(Map<String, dynamic> json) {
    enableNotification = json['enable_notification'];
  }


}
