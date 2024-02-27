import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/di.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../../viewModel/SearchViewModel/search_view_model_cubit.dart';
import 'search_body_widget.dart';
import 'package:provider/provider.dart';

class searchScreen extends StatefulWidget {
  static const routeName = "/searchScreen";
  const searchScreen({Key? key}) : super(key: key);

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {

  @override
  Widget build(BuildContext context) {
    AppProvider provider1 = Provider.of<AppProvider>(context);
    return  BlocProvider(
      create: (context) => getIt<SearchViewModelCubit>()..invoke(1, 20, provider1.searchController.text),
      child: SearchBodyWidget()
    );
  }
}
