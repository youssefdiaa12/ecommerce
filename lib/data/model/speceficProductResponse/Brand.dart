/// _id : "64089d5c24b25627a253159f"
/// name : "Puma"
/// slug : "puma"
/// image : "https://ecommerce.routemisr.com/Route-Academy-brands/1678286172219.png"

class Brand {
  Brand({
      this.id, 
      this.name, 
      this.slug, 
      this.image,});

  Brand.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? slug;
  String? image;
Brand copyWith({  String? id,
  String? name,
  String? slug,
  String? image,
}) => Brand(  id: id ?? this.id,
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