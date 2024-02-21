/// _id : "6439d5b90049ad0b52b90048"
/// name : "Men's Fashion"
/// slug : "men's-fashion"
/// image : "https://ecommerce.routemisr.com/Route-Academy-categories/1681511865180.jpeg"

class Category {
  Category({
      this.id, 
      this.name, 
      this.slug, 
      this.image,});

  Category.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? slug;
  String? image;
Category copyWith({  String? id,
  String? name,
  String? slug,
  String? image,
}) => Category(  id: id ?? this.id,
  name: name ?? this.name,
  slug: slug ?? this.slug,
  image: image ?? this.image,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    return map;
  }

}