import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/news_layout/cubit/cubit.dart';
import '../../layout/news_layout/cubit/states.dart';
import '../../shared/components/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
       var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  textInputType: TextInputType.text,
                  onChang: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  autofocus: true,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search most not be empty';
                    }
                    return null;
                  },
                  labelText: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context,condition: true)),
            ],
          ),
        );
      },
    );
  }
}
