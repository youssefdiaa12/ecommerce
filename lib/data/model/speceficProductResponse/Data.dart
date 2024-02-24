import 'package:ecommerce/data/model/brandResponse/brandDto.dart';
import 'package:ecommerce/data/model/categoriesResponse/categoryDto.dart';

import '../../../domain/model/Category.dart';
import '../../../domain/model/Product.dart';
import 'Subcategory.dart';


/// sold : 755
/// images : ["https://ecommerce.routemisr.com/Route-Academy-products/1680399913850-1.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1680399913851-4.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1680399913850-2.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1680399913851-3.jpeg","https://ecommerce.routemisr.com/Route-Academy-products/1680399913851-5.jpeg"]
/// subcategory : [{"_id":"6407f243b575d3b90bf957ac","name":"Men's Clothing","slug":"men's-clothing","category":"6439d5b90049ad0b52b90048"}]
/// ratingsQuantity : 20
/// _id : "6428de2adc1175abc65ca05b"
/// title : "Softride Enzo NXT CASTLEROCK-High Risk R"
/// slug : "softride-enzo-nxt-castlerock-high-risk-r"
/// description : "Sole Material\tRubber\nColour Name\tRED\nDepartment\tMen"
/// quantity : 173
/// price : 2999
/// imageCover : "https://ecommerce.routemisr.com/Route-Academy-products/1680399913757-cover.jpeg"
/// category : {"_id":"6439d5b90049ad0b52b90048","name":"Men's Fashion","slug":"men's-fashion","image":"https://ecommerce.routemisr.com/Route-Academy-categories/1681511865180.jpeg"}
/// brand : {"_id":"64089d5c24b25627a253159f","name":"Puma","slug":"puma","image":"https://ecommerce.routemisr.com/Route-Academy-brands/1678286172219.png"}
/// ratingsAverage : 2.8
/// createdAt : "2023-04-02T01:45:14.676Z"
/// updatedAt : "2024-02-20T09:58:08.618Z"
/// __v : 0
/// reviews : []
/// id : "6428de2adc1175abc65ca05b"

class Data {
  Data({
      this.sold, 
      this.images, 
      this.subcategory, 
      this.ratingsQuantity, 
      this.id, 
      this.title, 
      this.slug, 
      this.description, 
      this.quantity, 
      this.price, 
      this.imageCover, 
      this.category, 
      this.brand, 
      this.ratingsAverage, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.reviews,});

  Data.fromJson(dynamic json) {
    sold = json['sold'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['subcategory'] != null) {
      subcategory = [];
      json['subcategory'].forEach((v) {
        subcategory?.add(Subcategory.fromJson(v));
      });
    }
    ratingsQuantity = json['ratingsQuantity'];
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    imageCover = json['imageCover'];
    category = json['category'] != null ? CategoryDto.fromJson(json['category']) : null;
    brand = json['brand'] != null ? BrandDto.fromJson(json['brand']) : null;
    ratingsAverage = json['ratingsAverage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(v);
      });
    }
    id = json['id'];
  }
  num? sold;
  List<String>? images;
  List<Subcategory>? subcategory;
  num? ratingsQuantity;
  String? id;
  String? title;
  String? slug;
  String? description;
  num? quantity;
  num? price;
  String? imageCover;
  CategoryDto? category;
  BrandDto? brand;
  num? ratingsAverage;
  String? createdAt;
  String? updatedAt;
  num? v;
  List<dynamic>? reviews;
Data copyWith({  num? sold,
  List<String>? images,
  List<Subcategory>? subcategory,
  num? ratingsQuantity,
  String? id,
  String? title,
  String? slug,
  String? description,
  num? quantity,
  num? price,
  String? imageCover,
  CategoryDto? category,
  BrandDto? brand,
  num? ratingsAverage,
  String? createdAt,
  String? updatedAt,
  num? v,
  List<dynamic>? reviews,
}) => Data(  sold: sold ?? this.sold,
  images: images ?? this.images,
  subcategory: subcategory ?? this.subcategory,
  ratingsQuantity: ratingsQuantity ?? this.ratingsQuantity,
  id: id ?? this.id,
  title: title ?? this.title,
  slug: slug ?? this.slug,
  description: description ?? this.description,
  quantity: quantity ?? this.quantity,
  price: price ?? this.price,
  imageCover: imageCover ?? this.imageCover,
  category: category ?? this.category,
  brand: brand ?? this.brand,
  ratingsAverage: ratingsAverage ?? this.ratingsAverage,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
  reviews: reviews ?? this.reviews,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sold'] = sold;
    map['images'] = images;
    if (subcategory != null) {
      map['subcategory'] = subcategory?.map((v) => v.toJson()).toList();
    }
    map['ratingsQuantity'] = ratingsQuantity;
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['quantity'] = quantity;
    map['price'] = price;
    map['imageCover'] = imageCover;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    map['ratingsAverage'] = ratingsAverage;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    map['id'] = id;
    return map;
  }
  Product toProduct(){
    return Product(
      sold: sold?.toInt()??0,
      images: images,
      subcategory: null,
      ratingsQuantity: ratingsQuantity?.toInt()??0,
      id: id,
      title: title,
      slug: slug,
      description: description,
      quantity: quantity?.toInt()??0,
      price: price,
      imageCover: imageCover,
      category: category?.toCategory(),
      brand: brand?.toBrand(),
      ratingsAverage: ratingsAverage,
    );
  }


}