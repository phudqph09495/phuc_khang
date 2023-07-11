class ModelInfoPro {
  Customer? customer;
  Product? product;

  ModelInfoPro({this.customer, this.product});

  ModelInfoPro.fromJson(Map<String, dynamic> json) {

    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Customer {
  String? name;
  String? type;

  Customer({this.name, this.type});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class Product {
  int? id;
  String? code;
  String? name;
  String? thumbnail;
  String? originPrice;
  Null? price;
  String? vip1Price;
  String? vip2Price;
  Null? fsPrice;
  String? originPriceV1;
  String? originPriceV2;
  Null? sold;
  int? score;
  String? hotProduct;
  int? amount;
  String? descript;
  String? status;
  String? createdAt;
  String? updatedAt;
  CustomerPrice? customerPrice;

  List<ImagesShow>? imagesShow;

  Product(
      {this.id,
        this.code,
        this.name,
        this.thumbnail,
        this.originPrice,
        this.price,
        this.vip1Price,
        this.vip2Price,
        this.fsPrice,
        this.originPriceV1,
        this.originPriceV2,
        this.sold,
        this.score,
        this.hotProduct,
        this.amount,
        this.descript,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.customerPrice,

        this.imagesShow});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    originPrice = json['origin_price'];
    price = json['price'];
    vip1Price = json['vip1_price'];
    vip2Price = json['vip2_price'];
    fsPrice = json['fs_price'];
    originPriceV1 = json['origin_price_v1'];
    originPriceV2 = json['origin_price_v2'];
    sold = json['sold'];
    score = json['score'];
    hotProduct = json['hot_product'];
    amount = json['amount'];
    descript = json['descript'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerPrice = json['customer_price'] != null
        ? new CustomerPrice.fromJson(json['customer_price'])
        : null;

    if (json['images_show'] != null) {
      imagesShow = <ImagesShow>[];
      json['images_show'].forEach((v) {
        imagesShow!.add(new ImagesShow.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['origin_price'] = this.originPrice;
    data['price'] = this.price;
    data['vip1_price'] = this.vip1Price;
    data['vip2_price'] = this.vip2Price;
    data['fs_price'] = this.fsPrice;
    data['origin_price_v1'] = this.originPriceV1;
    data['origin_price_v2'] = this.originPriceV2;
    data['sold'] = this.sold;
    data['score'] = this.score;
    data['hot_product'] = this.hotProduct;
    data['amount'] = this.amount;
    data['descript'] = this.descript;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customerPrice != null) {
      data['customer_price'] = this.customerPrice!.toJson();
    }

    if (this.imagesShow != null) {
      data['images_show'] = this.imagesShow!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerPrice {
  String? originPrice;
  String? price;

  CustomerPrice({this.originPrice, this.price});

  CustomerPrice.fromJson(Map<String, dynamic> json) {
    originPrice = json['origin-price'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin-price'] = this.originPrice;
    data['price'] = this.price;
    return data;
  }
}

class ImagesShow {
  int? id;
  int? productId;
  String? url;
  String? status;
  String? createdAt;
  String? updatedAt;

  ImagesShow(
      {this.id,
        this.productId,
        this.url,
        this.status,
        this.createdAt,
        this.updatedAt});

  ImagesShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['url'] = this.url;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
