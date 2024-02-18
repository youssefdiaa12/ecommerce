/// status : "success"
/// message : "Product added successfully to your wishlist"
/// data : ["6428ebc6dc1175abc65ca0b9"]

class AddToCartListResponse {
  AddToCartListResponse({
      this.status, 
      this.message, 
      this.data,});

  AddToCartListResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<String>() : [];
  }
  String? status;
  String? message;
  List<String>? data;
AddToCartListResponse copyWith({  String? status,
  String? message,
  List<String>? data,
}) => AddToCartListResponse(  status: status ?? this.status,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}