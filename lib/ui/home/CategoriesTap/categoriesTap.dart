import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/ui/home/CategoriesTap/CategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';
import '../../../viewModel/CategoriesTapViewModel/categories_view_model_cubit.dart';
class categoriesTap extends StatefulWidget {

  @override
  State<categoriesTap> createState() => _categoriesTapState();
}

class _categoriesTapState extends State<categoriesTap>  {
  var cubit=getIt<CategoriesViewModelCubit>();
int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    cubit.getData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesViewModelCubit, CategoriesViewModelState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is CategoriesViewModelSuccessful) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 165.w,
                  height: double.infinity,
                  child:VerticalTabs(
                    contentScrollAxis: Axis.vertical,
                    changePageCurve: Curves.easeInOut,
                    initialIndex:_selectedIndex,
                    tabBackgroundColor: Colors.grey.shade300,
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorSide:IndicatorSide.start,
                    tabsShadowColor:Colors.transparent,
                    selectedTabBackgroundColor:Colors.transparent,
                    indicatorWidth: 8,
                    tabsElevation: 0,
                    tabsWidth: 165.w,
                    onSelect: (index) {
                      if(index!=_selectedIndex){
                        setState(() {
                          _selectedIndex = index;
                          cubit.getData();
                        });
                      }
                    },
                    backgroundColor: Colors.white,
                    tabs: const <Tab>[
                      Tab(child: Text("Men's fashion")),
                      Tab(child: Text("Women's fashion")),
                      Tab(child: Text("kid's fashion")),
                      Tab(child: Text('Accessories')),
                      Tab(child: Text('Shoes')),
                      Tab(child: Text('Beauty')),
                      Tab(child: Text('Fashion')),
                    ],
                    contents: <Widget>[
                      _buildListTile("Men's fashion", 0),
                      _buildListTile("Women's fashion", 1),
                      _buildListTile("kid's fashion", 2),
                      _buildListTile("Accessories", 3),
                      _buildListTile("Shoes", 4),
                      _buildListTile("Beauty", 5),
                      _buildListTile("Fashion", 6),
                    ],

                  ),

                  // ListView(
                  //   scrollDirection: Axis.vertical,
                  //   children: [
                  //     _buildListTile("Men's fashion", 0),
                  //     _buildListTile("Women's fashion", 1),
                  //     _buildListTile("kid's fashion", 2),
                  //     _buildListTile("Accessories", 3),
                  //     _buildListTile("Shoes", 4),
                  //     _buildListTile("Beauty", 5),
                  //     _buildListTile("Fashion", 6),
                  //
                  //     // Add more ListTiles for each category
                  //   ],
                  // ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: state.categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: CategoryWidget(state.categories[index]),
                    );
                  },
                ),
              ),
            ],
          );
        }
        if (state is CategoriesViewModelError) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: SizedBox(
                  height: double.infinity,
                  width: 185.w,
                  child:VerticalTabs(
                    selectedTabBackgroundColor: Colors.white,
                    initialIndex:0,
                    tabBackgroundColor: Colors.grey.shade300,
                    tabsElevation: 0,
                    tabsWidth: 150,
                    tabs: const <Tab>[
                      Tab(child: Text("Men's fashion")),
                      Tab(child: Text("Women's fashion")),
                      Tab(child: Text("kid's fashion")),
                      Tab(child: Text('Accessories')),
                      Tab(child: Text('Shoes')),
                      Tab(child: Text('Beauty')),
                      Tab(child: Text('Fashion')),
                    ],
                    contents: <Widget>[
                      _buildListTile("Men's fashion", 0),
                      _buildListTile("Women's fashion", 1),
                      _buildListTile("kid's fashion", 2),
                      _buildListTile("Accessories", 3),
                      _buildListTile("Shoes", 4),
                      _buildListTile("Beauty", 5),
                      _buildListTile("Fashion", 6),
                    ],
                  ),

                  // ListView(
                  //   scrollDirection: Axis.vertical,
                  //   children: [
                  //     _buildListTile("Men's fashion", 0),
                  //     _buildListTile("Women's fashion", 1),
                  //     _buildListTile("kid's fashion", 2),
                  //     _buildListTile("Accessories", 3),
                  //     _buildListTile("Shoes", 4),
                  //     _buildListTile("Beauty", 5),
                  //     _buildListTile("Fashion", 6),
                  //
                  //     // Add more ListTiles for each category
                  //   ],
                  // ),
                ),
              ),
           Center(child: Text(state.error)),
            ],
          );

        }
        if(state is CategoriesViewModelLoading){
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 165.w,
                    height: double.infinity,
                    child:VerticalTabs(
                      contentScrollAxis: Axis.vertical,
                      changePageCurve: Curves.easeInOut,
                      initialIndex:_selectedIndex,
                      tabBackgroundColor: Colors.grey.shade300,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorSide:IndicatorSide.start,
                      tabsShadowColor:Colors.transparent,
                      selectedTabBackgroundColor:Colors.transparent,
                      indicatorWidth: 8,
                      tabsElevation: 0,
                      tabsWidth: 165.w,
                      onSelect: (index) {
                        if(index!=_selectedIndex){
                          setState(() {
                            _selectedIndex = index;
                            cubit.getData();
                          });
                        }
                      },
                      backgroundColor: Colors.white,
                      tabs: const <Tab>[
                        Tab(child: Text("Men's fashion")),
                        Tab(child: Text("Women's fashion")),
                        Tab(child: Text("kid's fashion")),
                        Tab(child: Text('Accessories')),
                        Tab(child: Text('Shoes')),
                        Tab(child: Text('Beauty')),
                        Tab(child: Text('Fashion')),
                      ],
                      contents: <Widget>[
                        _buildListTile("Men's fashion", 0),
                        _buildListTile("Women's fashion", 1),
                        _buildListTile("kid's fashion", 2),
                        _buildListTile("Accessories", 3),
                        _buildListTile("Shoes", 4),
                        _buildListTile("Beauty", 5),
                        _buildListTile("Fashion", 6),
                      ],

                    ),

                    // ListView(
                    //   scrollDirection: Axis.vertical,
                    //   children: [
                    //     _buildListTile("Men's fashion", 0),
                    //     _buildListTile("Women's fashion", 1),
                    //     _buildListTile("kid's fashion", 2),
                    //     _buildListTile("Accessories", 3),
                    //     _buildListTile("Shoes", 4),
                    //     _buildListTile("Beauty", 5),
                    //     _buildListTile("Fashion", 6),
                    //
                    //     // Add more ListTiles for each category
                    //   ],
                    // ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: 12,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),

                                ),

                              )
                          )
                      );
                    },
                  ),
                ),
              ],
            );

          }
        return Container();
        },
      buildWhen: (previous, current) {
        if (current is CategoriesViewModelSuccessful) {
          return true;
        }
        if (current is CategoriesViewModelError) {
          return true;
        }
        if (current is CategoriesViewModelLoading) {
          return true;
        }
        return false;
      },
    );
  }
  Widget _buildListTile(String title, int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

      )
    );
  }
}
