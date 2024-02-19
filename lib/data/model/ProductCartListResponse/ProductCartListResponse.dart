import 'cartListResponseDetails.dart';

/// status : "success"
/// numOfCartItems : 1
/// data : {"_id":"65d237563adc469d4286f77e","cartOwner":"65cfe17fbfa22e65fd18d6ad","products":[{"count":3,"_id":"65d237563adc469d4286f77f","product":{"subcategory":[{"_id":"6407f1bcb575d3b90bf95797","name":"Women's Clothing","slug":"women's-clothing","category":"6439d58a0049ad0b52b9003f"}],"_id":"6428ebc6dc1175abc65ca0b9","title":"Woman Shawl","quantity":225,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680403397402-cover.jpeg","category":{"_id":"6439d58a0049ad0b52b9003f","name":"Women's Fashion","slug":"women's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511818071.jpeg"},"brand":{"_id":"64089bbe24b25627a253158b","name":"DeFacto","slug":"defacto","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678285758109.png"},"ratingsAverage":4.8,"id":"6428ebc6dc1175abc65ca0b9"},"price":160}],"createdAt":"2024-02-18T16:59:02.348Z","updatedAt":"2024-02-18T17:06:06.263Z","__v":0,"totalCartPrice":480}

class ProductCartListResponse {
  ProductCartListResponse({
      this.status, 
      this.numOfCartItems, 
      this.data,});

  ProductCartListResponse.fromJson(dynamic json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    data = json['data'] != null ? cartListResponseDetails.fromJson(json['data']) : null;
  }
  String? status;
  int? numOfCartItems;
  cartListResponseDetails? data;
ProductCartListResponse copyWith({  String? status,
  int? numOfCartItems,
  cartListResponseDetails? data,
}) => ProductCartListResponse(  status: status ?? this.status,
  numOfCartItems: numOfCartItems ?? this.numOfCartItems,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['numOfCartItems'] = numOfCartItems;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}