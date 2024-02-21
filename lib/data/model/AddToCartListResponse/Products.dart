/// count : 9
/// _id : "65d237563adc469d4286f77f"
/// product : "6428ebc6dc1175abc65ca0b9"
/// price : 160

class Products {
  Products({
      this.count, 
      this.id, 
      this.product, 
      this.price,});

  Products.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    product = json['product'];
    price = json['price'];
  }
  int? count;
  String? id;
  String? product;
  int? price;
Products copyWith({  int? count,
  String? id,
  String? product,
  int? price,
}) => Products(  count: count ?? this.count,
  id: id ?? this.id,
  product: product ?? this.product,
  price: price ?? this.price,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['_id'] = id;
    map['product'] = product;
    map['price'] = price;
    return map;
  }

}