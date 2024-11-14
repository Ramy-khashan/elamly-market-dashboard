class OrdersModel {
  String? deliveryAddressId;
  String? orderId;
  List<Products>? products;
  String? deliveryFees;
  bool? isCancelled;
  String? createdAt;
  bool? isPaid;
  String? notificationToken;
  String? totalPrice;
  String? deliveryId;
  String? userId;
  String? code;

  OrdersModel(
      {this.deliveryAddressId,
      this.orderId,
      this.products,
      this.code,
      this.deliveryFees,
      this.isCancelled,
      this.createdAt,
      this.isPaid,
      this.deliveryId,
      this.notificationToken,
      this.totalPrice,
      this.userId});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    deliveryAddressId = json['delivery_address_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    deliveryFees = json['delivery_fees'];
    isCancelled = json['is_cancelled'];
    deliveryId = json['delivery_id'];
    createdAt = json['created_at'];
    isPaid = json['is_paid'];
    code = json['code'];
    notificationToken = json['notification_token'];
    totalPrice = json['total_price'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delivery_address_id'] = deliveryAddressId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['delivery_fees'] = deliveryFees;
    data['is_cancelled'] = isCancelled;
    data['created_at'] = createdAt;
    data['is_paid'] = isPaid;
    data['notification_token'] = notificationToken;
    data['total_price'] = totalPrice;
    data['user_id'] = userId;
     data['delivery_id']=deliveryId;

    return data;
  }
}

class Products {
  String? quantity;
  String? productId;
  String? productTitle;
  String? price;
  String? priceBefore;
  bool? isOnSale;

  Products(
      {this.quantity,
      this.productId,
      this.productTitle,
      this.price,
      this.priceBefore,
      this.isOnSale});

  Products.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    price = json['price'];
    priceBefore = json['price_before'];
    isOnSale = json['is_on_sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['price'] = price;
    data['price_before'] = priceBefore;
    data['is_on_sale'] = isOnSale;
    return data;
  }
}
