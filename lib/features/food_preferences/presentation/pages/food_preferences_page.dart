import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/food_preferences_list_view.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/food_preferences_bloc.dart';

@RoutePage()
class FoodPreferencesPage extends StatelessWidget {
  const FoodPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Food Prefrences Screen')),
        body: _buildBody());
  }

  BlocProvider<FoodPreferencesBloc> _buildBody() {
    final bloc = sl<FoodPreferencesBloc>();

    return BlocProvider(
      create: (_) {
        bloc.add(const FoodPreferencesLoad());
        return bloc;
      },
      child: BlocBuilder<FoodPreferencesBloc, FoodPreferencesState>(
        builder: (context, state) {
          if (state is FoodPreferencesLoaded) {
            return FoodPreferencesListView(
                foodPreferences: state.foodPreferences);
          }
          if (state is FoodPreferencesFailure) {}
          return const LoadingWidget();
        },
      ),
    );
  }
}
