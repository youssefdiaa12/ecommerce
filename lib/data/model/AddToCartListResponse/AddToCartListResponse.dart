import 'Data.dart';

/// status : "success"
/// message : "Product added successfully to your cart"
/// numOfCartItems : 1
/// data : {"_id":"65d237563adc469d4286f77e","cartOwner":"65cfe17fbfa22e65fd18d6ad","products":[{"count":9,"_id":"65d237563adc469d4286f77f","product":"6428ebc6dc1175abc65ca0b9","price":160}],"createdAt":"2024-02-18T16:59:02.348Z","updatedAt":"2024-02-18T17:03:51.768Z","__v":0,"totalCartPrice":1440}

class AddToCartListResponse {
  AddToCartListResponse({
      this.status, 
      this.message, 
      this.numOfCartItems, 
      this.data,});

  AddToCartListResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    numOfCartItems = json['numOfCartItems'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  int? numOfCartItems;
  Data? data;
AddToCartListResponse copyWith({  String? status,
  String? message,
  int? numOfCartItems,
  Data? data,
}) => AddToCartListResponse(  status: status ?? this.status,
  message: message ?? this.message,
  numOfCartItems: numOfCartItems ?? this.numOfCartItems,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['numOfCartItems'] = numOfCartItems;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}