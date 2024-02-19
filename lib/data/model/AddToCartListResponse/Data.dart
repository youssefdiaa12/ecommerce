import 'Products.dart';

/// _id : "65d237563adc469d4286f77e"
/// cartOwner : "65cfe17fbfa22e65fd18d6ad"
/// products : [{"count":9,"_id":"65d237563adc469d4286f77f","product":"6428ebc6dc1175abc65ca0b9","price":160}]
/// createdAt : "2024-02-18T16:59:02.348Z"
/// updatedAt : "2024-02-18T17:03:51.768Z"
/// __v : 0
/// totalCartPrice : 1440

class Data {
  Data({
      this.id, 
      this.cartOwner, 
      this.products, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.totalCartPrice,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }
  String? id;
  String? cartOwner;
  List<Products>? products;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? totalCartPrice;
Data copyWith({  String? id,
  String? cartOwner,
  List<Products>? products,
  String? createdAt,
  String? updatedAt,
  int? v,
  int? totalCartPrice,
}) => Data(  id: id ?? this.id,
  cartOwner: cartOwner ?? this.cartOwner,
  products: products ?? this.products,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
  totalCartPrice: totalCartPrice ?? this.totalCartPrice,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['cartOwner'] = cartOwner;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['totalCartPrice'] = totalCartPrice;
    return map;
  }

}