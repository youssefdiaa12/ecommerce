/// productId : "6428ebc6dc1175abc65ca0b9"

class ProductCountRequest {
  ProductCountRequest({
    this.count,});

  ProductCountRequest.fromJson(dynamic json) {
    count = json['count'];
  }
  String? count;
  ProductCountRequest copyWith({  String? count,
  }) => ProductCountRequest(  count: count ?? this.count,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    return map;
  }

}