class ModelSearch {
  List<Null>? customer;
  List<Products>? products;

  ModelSearch({this.customer, this.products});

  ModelSearch.fromJson(Map<String, dynamic> json) {

    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? code;
  String? name;
  String? thumbnail;
  String? originPrice;

  String? vip1Price;
  String? vip2Price;

  String? originPriceV1;
  String? originPriceV2;

  int? score;
  String? hotProduct;
  int? amount;

  String? status;
  String? createdAt;
  String? updatedAt;
  CustomerPrice? customerPrice;

  Products(
      {this.id,
        this.code,
        this.name,
        this.thumbnail,
        this.originPrice,

        this.vip1Price,
        this.vip2Price,

        this.originPriceV1,
        this.originPriceV2,

        this.score,
        this.hotProduct,
        this.amount,

        this.status,
        this.createdAt,
        this.updatedAt,
        this.customerPrice});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    originPrice = json['origin_price'];

    vip1Price = json['vip1_price'];
    vip2Price = json['vip2_price'];

    originPriceV1 = json['origin_price_v1'];
    originPriceV2 = json['origin_price_v2'];

    score = json['score'];
    hotProduct = json['hot_product'];
    amount = json['amount'];

    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerPrice = json['customer_price'] != null
        ? new CustomerPrice.fromJson(json['customer_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['origin_price'] = this.originPrice;

    data['vip1_price'] = this.vip1Price;
    data['vip2_price'] = this.vip2Price;

    data['origin_price_v1'] = this.originPriceV1;
    data['origin_price_v2'] = this.originPriceV2;

    data['score'] = this.score;
    data['hot_product'] = this.hotProduct;
    data['amount'] = this.amount;

    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customerPrice != null) {
      data['customer_price'] = this.customerPrice!.toJson();
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
