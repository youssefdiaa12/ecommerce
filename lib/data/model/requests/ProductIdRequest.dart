/// productId : "6428ebc6dc1175abc65ca0b9"

class ProductIdRequest {
  ProductIdRequest({
      this.productId,});

  ProductIdRequest.fromJson(dynamic json) {
    productId = json['productId'];
  }
  String? productId;
ProductIdRequest copyWith({  String? productId,
}) => ProductIdRequest(  productId: productId ?? this.productId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    return map;
  }

}