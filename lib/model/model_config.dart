class ModelConfig {
  String? version;
  FlashSale? flashSale;
  List<ImageHomeUrls>? imageHomeUrls;
  String? imageLogoUrl;
  String? shopInfo;
  List<RecievedBankAccounts>? recievedBankAccounts;
  String? linkAboutUs;
  String? fbMessengerUrl;

  ModelConfig(
      {this.version,
        this.flashSale,
        this.imageHomeUrls,
        this.imageLogoUrl,
        this.shopInfo,
        this.recievedBankAccounts,
        this.linkAboutUs,
        this.fbMessengerUrl});

  ModelConfig.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    flashSale = json['flash_sale'] != null
        ? new FlashSale.fromJson(json['flash_sale'])
        : null;
    if (json['image_home_urls'] != null) {
      imageHomeUrls = <ImageHomeUrls>[];
      json['image_home_urls'].forEach((v) {
        imageHomeUrls!.add(new ImageHomeUrls.fromJson(v));
      });
    }
    imageLogoUrl = json['image_logo_url'];
    shopInfo = json['shop_info'];
    if (json['recieved_bank_accounts'] != null) {
      recievedBankAccounts = <RecievedBankAccounts>[];
      json['recieved_bank_accounts'].forEach((v) {
        recievedBankAccounts!.add(new RecievedBankAccounts.fromJson(v));
      });
    }
    linkAboutUs = json['link_about_us'];
    fbMessengerUrl = json['fb_messenger_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    if (this.flashSale != null) {
      data['flash_sale'] = this.flashSale!.toJson();
    }
    if (this.imageHomeUrls != null) {
      data['image_home_urls'] =
          this.imageHomeUrls!.map((v) => v.toJson()).toList();
    }
    data['image_logo_url'] = this.imageLogoUrl;
    data['shop_info'] = this.shopInfo;
    if (this.recievedBankAccounts != null) {
      data['recieved_bank_accounts'] =
          this.recievedBankAccounts!.map((v) => v.toJson()).toList();
    }
    data['link_about_us'] = this.linkAboutUs;
    data['fb_messenger_url'] = this.fbMessengerUrl;
    return data;
  }
}

class FlashSale {
  String? id;
  String? name;
  String? dateFrom;
  String? dateTo;
  Null? discount;
  Null? unit;
  String? createdAt;

  FlashSale(
      {this.id,
        this.name,
        this.dateFrom,
        this.dateTo,
        this.discount,
        this.unit,
        this.createdAt});

  FlashSale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    discount = json['discount'];
    unit = json['unit'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    data['discount'] = this.discount;
    data['unit'] = this.unit;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ImageHomeUrls {
  String? categoryId;
  String? imageUrl;

  ImageHomeUrls({this.categoryId, this.imageUrl});

  ImageHomeUrls.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class RecievedBankAccounts {
  String? bankName;
  String? bankBranch;
  String? holder;
  String? accountNumber;

  RecievedBankAccounts(
      {this.bankName, this.bankBranch, this.holder, this.accountNumber});

  RecievedBankAccounts.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
    holder = json['holder'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['bank_branch'] = this.bankBranch;
    data['holder'] = this.holder;
    data['account_number'] = this.accountNumber;
    return data;
  }
}
