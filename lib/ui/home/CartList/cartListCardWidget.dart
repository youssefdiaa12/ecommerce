import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../data/Services/disk_storage.dart';
import '../../../domain/model/Product.dart';
import '../../../viewModel/CartListViewModel/cart_list_view_model_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../CategoriesTap/productDetailsCartWidget.dart';
import 'package:provider/provider.dart';

class cartListCardWidget extends StatefulWidget {
  Product product;
  num price;
  int   numberOfProducts;

  cartListCardWidget(this.product, this.price, this.numberOfProducts,{Key? key}) : super(key: key);


  @override
  State<cartListCardWidget> createState() => _cartListCardWidgetState();
}

class _cartListCardWidgetState extends State<cartListCardWidget> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CartListViewModelCubit>(context);
    var appProvide=Provider.of<AppProvider>(context);
    return InkWell(
      onTap: () async{
        print(widget.product.id);
        print("dada");
        widget.product.price=widget.price;
        print(widget.product.price);
        Product obj=await appProvide.getSpecificeProduct(widget.product.id??'');
        PersistentNavBarNavigator.pushNewScreen(context, screen: productDetailsCartWidget(obj),
            withNavBar:false);
        // productDetailsCartWidget
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xffb2c5d9), width: 1)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.product.imageCover ?? "",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.14,
                    width: 113.w,
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                          ),
                          borderRadius: BorderRadius.circular(25.r),
                          border:
                          Border.all(color: const Color(0xffb2c5d9), width: 1),
                        )),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h, top: 2.0.h),
                            child: SizedBox(
                              width: 150.w,
                              child: Text(
                                widget.product.title ?? "",
                                style: TextStyle(
                                  color: const Color(0xff252065),
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h),
                            child: Row(
                              children: [
                                Container(
                                  height: 15.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text("Black Color",
                                    style: TextStyle(
                                      color: const Color(0xff252065),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EGP ${widget.price}",
                                style: TextStyle(
                                  color: const Color(0xff252065),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                    child: Container(
                      height:42.h,
                      width: 112.w,
                      decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: const Color(0xffabc0d3), width: 1),
                        color: const Color(0xff004182),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Padding(
                              padding:  EdgeInsets.only(left: 4.w),
                              child: InkWell(
                                  onTap: () async{
                                    if (widget.numberOfProducts == 1) {
                                      //show toast
                                      Fluttertoast.showToast(
                                        webPosition: 'center',
                                        msg: "This is the minimum",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: const Color(0xff004182),
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    } else {
                                     await cubit.invoke_addToCart(widget.product.id!,AppProvider.user?.token??"", -1);
                                      await    disk_storge().add_to_cart_quantity(widget.product.id!, -1);
                                      setState((){
                                        double item=widget.price/widget.numberOfProducts.toDouble();
                                        widget.numberOfProducts--;
                                        widget.price-=item;
                                        widget.price=widget.price.roundToDouble();
                                        //remove the number after the dot
                                        widget.price=widget.price.toInt();
                                       cubit.invoke_getProductCartList(AppProvider.user?.token??"");
                                    //   appProvider.product_cartList_count![widget.product.id!] = widget.numberOfProducts;
                                      });
                                    }

                                  },
                                  child: Icon(Icons.remove_circle_outline_rounded,color: Colors.white,size: 24.sp,)),
                            ),
                            Text("${widget.numberOfProducts}",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: Colors.white),),
                            Padding(
                              padding:  EdgeInsets.only(right: 4.0.w),
                              child: InkWell(
                                  onTap: ()async {
                                    if(widget.numberOfProducts<widget.product.quantity!.toInt()) {
                                      await cubit.invoke_addToCart(widget.product.id!,AppProvider.user?.token??"", 1);

                                      await disk_storge().add_to_cart_quantity(widget.product.id!, 1);
                                      setState(()  {
                                        double item=widget.price/widget.numberOfProducts.toDouble();
                                       widget.numberOfProducts++;
                                       widget.price+=item;
                                        widget.price=widget.price.roundToDouble();
                                        //remove the number after the dot
                                        widget.price=widget.price.toInt();
                                       cubit.invoke_getProductCartList(AppProvider.user?.token??"");
                                      // appProvider.product_cartList_count![widget.product.id!] = widget.numberOfProducts;
                                      });
                                    }
                                    else{
                                      Fluttertoast.showToast(
                                          msg: "Out of stock",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: const Color(0xff004182),
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  },
                                  child: Icon(Icons.add_circle_outline_rounded,color: Colors.white,size: 24.sp,)),
                            ),

                          ]
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () async {
                    await cubit.invoke_removeFromCart(widget.product.id!, AppProvider.user?.token ?? "");
                    await disk_storge().clear_cart_product(widget.product.id!);
                     },
                  child: Image.asset("assets/icons/delete.png")),
            )
          ],
        ),
      ),
    );
  }
}
