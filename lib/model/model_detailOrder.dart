class ModelOrderDetail {
  List<OrderDetail>? orderDetail;

  ModelOrderDetail({this.orderDetail});

  ModelOrderDetail.fromJson(Map<String, dynamic> json) {
    if (json['orderDetail'] != null) {
      orderDetail = <OrderDetail>[];
      json['orderDetail'].forEach((v) {
        orderDetail!.add(new OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetail != null) {
      data['orderDetail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetail {
  int? id;
  int? orderId;
  int? productId;
  String? productName;

  int? amount;
  String? price;
  String? productImg;

  String? status;
  String? createdAt;
  String? updatedAt;

  OrderDetail(
      {this.id,
        this.orderId,
        this.productId,
        this.productName,

        this.amount,
        this.price,
        this.productImg,

        this.status,
        this.createdAt,
        this.updatedAt});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];

    amount = json['amount'];
    price = json['price'];
    productImg = json['product_img'];

    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;

    data['amount'] = this.amount;
    data['price'] = this.price;
    data['product_img'] = this.productImg;

    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
