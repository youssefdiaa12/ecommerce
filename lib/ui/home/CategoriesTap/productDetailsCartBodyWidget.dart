import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/ui/home/CategoriesTap/productImageWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/Services/disk_storage.dart';
import '../../../domain/model/Product.dart';
import '../../../viewModel/CartListViewModel/cart_list_view_model_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
class ProductDetailsCartBodyWidget extends StatefulWidget {
  final  Product product;
   bool is_read_more=false;
  var size_selectedIndex=0,color_selectedIndex=0;
  List <Color> colors=[Colors.red,Colors.green,Colors.blue,Colors.orangeAccent];
  ProductDetailsCartBodyWidget(this.product);
  @override
  State<ProductDetailsCartBodyWidget> createState() => _ProductDetailsCartBodyWidgetState();
}

class _ProductDetailsCartBodyWidgetState extends State<ProductDetailsCartBodyWidget> {

  int currentPage = 0;
  int numberOfProducts=1;
  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(children: [
        CarouselSlider.builder(
          itemCount: widget.product.images!.length,
          carouselController: buttonCarouselController,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
              ProductImageWidget(
                  widget.product.images![itemIndex],
                  itemIndex,
                  widget.product.images!.length,
                  widget.product.id ?? ""),
          options: CarouselOptions(
              autoPlay: true,
              height: 380.h,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              pageSnapping: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1.2,
              initialPage: 0,
              animateToClosest: true,
              enableInfiniteScroll: true,
              clipBehavior: Clip.hardEdge,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPage = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:   SizedBox(
                width: 150.w,
                child: Text(widget.product.title??"",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: const Color(0xff06004F))
                  ,maxLines:1,
                  overflow: TextOverflow.ellipsis,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:   Text("EGP ${widget.product.price.toString()}",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: const Color(0xff06004F)),),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Row(children: [
                  Container(
                    height: 34.h,
                    width: 102.w,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      border: Border.all(color: const Color(0xffabc0d3), width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child:Center(child: Text("${widget.product.sold.toString()} Sold",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: const Color(0xff06004F)),)),
                  ),
                  SizedBox(width: 10.w,),
                  Padding(
                    padding:  EdgeInsets.only(bottom: 1.0.h),
                    child: Row(
                      children: [
                        Icon(Icons.star,color: Colors.yellow,size: 22.sp,),
                        SizedBox(width: 3.w,),
                        Text(widget.product.ratingsAverage.toString(),style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: const Color(0xff06004F)),),
                        SizedBox(width: 3.w,),
                        Text("(${widget.product.ratingsQuantity.toString()})",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: const Color(0xff06004F)),),
                        SizedBox(width: 10.w,),
                      ],
                    ),
                  ),


                ]),
              ),
              Container(
                height:42.h,
                width: 122.w,
                decoration:
                BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xffabc0d3), width: 1),
                  color: const Color(0xff004182),
                ),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding:  EdgeInsets.only(left: 4.w),
                        child: InkWell(
                            onTap: () {
                              if (numberOfProducts == 1) {
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
                                setState(() {
                                  numberOfProducts--;
                                });
                              }

                            },
                            child: Icon(Icons.remove_circle_outline_rounded,color: Colors.white,size: 24.sp,)),
                      ),
                      Text("$numberOfProducts",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: Colors.white),),
                      Padding(
                        padding:  EdgeInsets.only(right: 4.0.w),
                        child: InkWell(
                            onTap: () {
                              if(numberOfProducts<widget.product.quantity!.toInt()) {
                                setState(() {
                                  numberOfProducts++;
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
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Description",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: const Color(0xff06004F)),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:widget.is_read_more?  ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Text("${widget.product.description}",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xff06004F)),
              ),
              SizedBox(height: 10.h),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.is_read_more = false;
                  });
                },
                child: Text("Read Less", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: const Color(0xff004182))),
              )
            ],
          ):
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Text(widget.product.description??"",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,color: const Color(0xff06004F)),
                maxLines:3,
                overflow: TextOverflow.ellipsis,),
              InkWell(
                onTap: () {
                  setState(() {
                    widget.is_read_more=true;
                  });
                },
                child: Text("Read More",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: const Color(0xff004182)),),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Text("Size",
                style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: const Color(0xff06004F)),),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          alignment: Alignment.centerLeft,
          height: 40.h,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,

              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      widget.size_selectedIndex=index;
                    });
                  },
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color:widget.size_selectedIndex==index ? const Color(0xff004182):Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text("${38+index}",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color:widget.size_selectedIndex==index?Colors.white
                          :const Color(0xff004182)),),
                    ),
                  ),
                );
              }
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0,top: 8.0),
          child: Row(
            children: [
              Text("Color",
                style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: const Color(0xff06004F)),),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8.0),
          alignment: Alignment.centerLeft,
          height: 40.h,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              shrinkWrap: true,

              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      widget.color_selectedIndex=index;
                    });
                  },
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color:widget.colors[index],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child:widget.color_selectedIndex==index?Icon(Icons.check,color: Colors.white,size: 20.sp,):null),
                  ),

                );
              }
          ),
        ),
        SizedBox(height: 10.h,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    children: [
                      Text("Total Price",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: const Color(
                          0xffb3b1c9)),),
                      SizedBox(height: 5.h,),
                      Text("${widget.product.price!*numberOfProducts} EGP",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: const Color(
                          0xff004182)),),
                    ]
                ),
                ElevatedButton(onPressed:()async{
                  var cubit = BlocProvider.of<CartListViewModelCubit>(context);
                bool isAutohrized=await cubit.checkAuthority();
                if(!isAutohrized){
                  return;
                }
                await  disk_storge().add_to_cart_quantity(widget.product.id!, numberOfProducts);
                  await cubit.invoke_addToCart(
                      widget.product.id??"",
                      AppProvider.user?.token??"",
                      numberOfProducts);
                  setState(() {
                  });

                },style: ElevatedButton.styleFrom(
                    primary: const Color(0xff004182),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                ), child:
                Row(
                  children: [
                    SizedBox(width: 10.w,),
                    Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 20.sp,),
                    SizedBox(width: 10.w,
                      height:50.h,
                    ),
                    Text("Add To Cart",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,color: Colors.white)),
                    SizedBox(width: 45.w,)
                  ],
                ))
              ]
          ),
        )

      ]),
    );
  }
}
