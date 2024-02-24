import 'Data.dart';

/// data : {"sold":755,"images":["https://ecommerce.routemisr.com/Route-Academy-products/1680399913850-1.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1680399913851-4.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1680399913850-2.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1680399913851-3.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1680399913851-5.jpeg"],"subcategory":[{"_id":"6407f243b575d3b90bf957ac","name":"Men's Clothing","slug":"men's-clothing","category":"6439d5b90049ad0b52b90048"}],"ratingsQuantity":20,"_id":"6428de2adc1175abc65ca05b","title":"Softride Enzo NXT CASTLEROCK-High Risk R","slug":"softride-enzo-nxt-castlerock-high-risk-r","description":"Sole Material\tRubber\nColour Name\tRED\nDepartment\tMen","quantity":173,"price":2999,"imageCover":"https://ecommerce.routemisr.com/Route-Academy-products/1680399913757-cover.jpeg","category":{"_id":"6439d5b90049ad0b52b90048","name":"Men's Fashion","slug":"men's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511865180.jpeg"},"brand":{"_id":"64089d5c24b25627a253159f","name":"Puma","slug":"puma","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678286172219.png"},"ratingsAverage":2.8,"createdAt":"2023-04-02T01:45:14.676Z","updatedAt":"2024-02-20T09:58:08.618Z","__v":0,"reviews":[],"id":"6428de2adc1175abc65ca05b"}

class SpeceficProductResponse {
  SpeceficProductResponse({
      this.data,});

  SpeceficProductResponse.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? data;
SpeceficProductResponse copyWith({  Data? data,
}) => SpeceficProductResponse(  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }


}