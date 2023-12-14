import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_scanner/pages/food_preference_screen/bloc/food_preference_screen_bloc.dart';

@RoutePage()
class FoodPreferenceScreen extends StatefulWidget {
  const FoodPreferenceScreen({super.key});

  @override
  State<FoodPreferenceScreen> createState() => _FoodPreferenceScreenState();
}

class _FoodPreferenceScreenState extends State<FoodPreferenceScreen> {
  final _foodPreferenceScreenBloc = FoodPreferenceScreenBloc();
  // @override
  // void initState() {
  //   _foodPreferenceScreenBloc.add(event);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Preference Screen'),
      ),
    );
  }
}
