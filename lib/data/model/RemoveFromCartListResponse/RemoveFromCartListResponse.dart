import 'Data.dart';

/// status : "success"
/// numOfCartItems : 0
/// data : {"_id":"65d237563adc469d4286f77e","cartOwner":"65cfe17fbfa22e65fd18d6ad","products":[],"createdAt":"2024-02-18T16:59:02.348Z","updatedAt":"2024-02-20T19:24:42.423Z","__v":1,"totalCartPrice":0}

class RemoveFromCartListResponse {
  RemoveFromCartListResponse({
      this.status, 
      this.numOfCartItems, 
      this.data,});

  RemoveFromCartListResponse.fromJson(dynamic json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  num? numOfCartItems;
  Data? data;
RemoveFromCartListResponse copyWith({  String? status,
  num? numOfCartItems,
  Data? data,
}) => RemoveFromCartListResponse(  status: status ?? this.status,
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