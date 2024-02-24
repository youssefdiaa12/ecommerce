class UserCartList{
String productId;
int quantity;
UserCartList(this.productId,this.quantity);


Map<String, dynamic> toFireStore() {
  return {
    'productId': productId,
    'quantity': quantity,
  };
}

UserCartList.fromFireStore(Map<String, dynamic>? mp)
    : this(mp?['productId'], mp?['quantity']);

}