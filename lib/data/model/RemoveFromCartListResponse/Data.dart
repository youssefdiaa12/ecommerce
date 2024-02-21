/// _id : "65d237563adc469d4286f77e"
/// cartOwner : "65cfe17fbfa22e65fd18d6ad"
/// products : []
/// createdAt : "2024-02-18T16:59:02.348Z"
/// updatedAt : "2024-02-20T19:24:42.423Z"
/// __v : 1
/// totalCartPrice : 0

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
        products?.add((v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }
  String? id;
  String? cartOwner;
  List<dynamic>? products;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? totalCartPrice;
Data copyWith({  String? id,
  String? cartOwner,
  List<dynamic>? products,
  String? createdAt,
  String? updatedAt,
  num? v,
  num? totalCartPrice,
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