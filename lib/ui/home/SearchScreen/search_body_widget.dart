import 'package:ecommerce/ui/home/SearchScreen/search_list_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../Common/requiredLoginWidget.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../../viewModel/SearchViewModel/search_view_model_cubit.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../Authentication/LoginScreen.dart';
import '../CartList/CartListWidget.dart';
import '../lovedTap/wish_list_card_widget_loading.dart';
class SearchBodyWidget extends StatefulWidget {
  const SearchBodyWidget({Key? key}) : super(key: key);

  @override
  State<SearchBodyWidget> createState() => _SearchBodyWidgetState();
}

class _SearchBodyWidgetState extends State<SearchBodyWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var cubit=BlocProvider.of<SearchViewModelCubit>(context);
    AppProvider provider1 = Provider.of<AppProvider>(context);
    String productList = provider1.products_cartList?.length.toString() ?? "0";

    if (productList.length >= 3) {
      productList = "99+";
    }
    return Scaffold(
      key: _scaffoldKey1,
      appBar:AppBar(
        leadingWidth:0,
        leading: null,
        toolbarHeight: 120.h,
        backgroundColor: Colors.white30,
        elevation: 0,
        title: SizedBox(
          width: double.infinity,
          child: Form(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/route.png", width: 44.w, height: 44.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            cubit.invoke(0, 120, provider1.searchController.text);
                          },
                          controller: provider1.searchController,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color(0xff004182),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color(0xff004182),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                color: Color(0xff004182),
                              ),
                            ),
                            hintText: "What do you search for?",
                            hintStyle: const TextStyle(color: Color(0xff004182)),
                            prefixIcon:
                            Icon(Icons.search_sharp, size: 28.sp, color: const Color(0xff004182)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen:CartListWidget(),
                            withNavBar: false,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 1.0, left: 6),
                          child: badges.Badge(
                            badgeAnimation: const badges.BadgeAnimation.rotation(
                              animationDuration: Duration(seconds: 1),
                              colorChangeAnimationDuration: Duration(seconds: 1),
                              loopAnimation: false,
                              curve: Curves.fastOutSlowIn,
                              colorChangeAnimationCurve: Curves.easeInCubic,
                            ),
                            position: badges.BadgePosition.topEnd(top: -14, end: -14),
                            badgeStyle: const badges.BadgeStyle(badgeColor: Color(0xff004182)),
                            showBadge: true,
                            badgeContent: Text(
                              (productList),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                            child: Image.asset("assets/icons/cart.png", width: 25.w, height: 25.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body:SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: BlocBuilder<SearchViewModelCubit, SearchViewModelState>(
            buildWhen:(previous, current) {
              if(current is SearchViewModelSuccess){
                return true;
              }
              if(current is SearchViewModelError){
                return true;
              }
              if(current is SearchViewModelLoading){
                return true;
              }
              if(current is SearchViewModelEmpty){
                return true;
              }
              if(current is UnAuthenticatedTapState){
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if(state is SearchViewModelSuccess){
                return state.products.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: MediaQuery.of(context).size.height*0.1,),
                      Lottie.asset(
                        "assets/animations/search1.json",
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Search not found...",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Poppins",
                          color: const Color(0xff252065),
                        ),
                      )
                    ],
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SearcListCardWidget(state.products[index]);
                  },
                  itemCount: state.products.length,
                );
              }
              if (state is UnAuthenticatedTapState) {
                return requiredLoginWidget(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LoginScreen();
                        },
                      ),
                          (_) => false,
                    );
                  },
                  text: "login",
                );
              }
              if(state is SearchViewModelLoading){
                return    ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const WishListCardWidgetLoading();
                  },
                  itemCount: 12,
                );
              }
              if(state is SearchViewModelError){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: MediaQuery.of(context).size.height*0.2,),
                      Lottie.asset(
                        "assets/animations/error.json",
                        fit: BoxFit.cover,
                        height: 180.h,
                        width: 180.w,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      const Text(
                        "Something went wrong",
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      TextButton(
                          onPressed: () {
                            var cubit = BlocProvider.of<SearchViewModelCubit>(context);
                            cubit.invoke(1, 20, provider1.searchController.text);
                          },
                          child: const Text("Try again"))
                    ],
                  ),
                );
              }
              if(state is SearchViewModelEmpty){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(height: MediaQuery.of(context).size.height*0.1,),
                      Lottie.asset(
                        "assets/animations/search.json",
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Start searching...",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: "Poppins",
                          color: const Color(0xff252065),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            }
        ),
      ),

    );
  }
  late AppProvider _appProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appProvider = Provider.of<AppProvider>(context);
  }
  @override
  void deactivate() {
    super.deactivate();
    //run inside backGround
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _appProvider.searchController.clear();
    });
  }
}
