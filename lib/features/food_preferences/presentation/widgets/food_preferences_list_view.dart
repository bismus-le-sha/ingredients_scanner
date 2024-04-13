import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/food_preferences_entity.dart';
import '../bloc/food_preferences_bloc.dart';

import '../../data/models/food_preferences_model.dart';

class FoodPreferencesListView extends StatefulWidget {
  final FoodPreferencesEntity foodPreferences;
  const FoodPreferencesListView({super.key, required this.foodPreferences});

  @override
  State<FoodPreferencesListView> createState() =>
      _FoodPreferencesListViewState();
}

class _FoodPreferencesListViewState extends State<FoodPreferencesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SwitchListTile(
            title: const Text('Sugar free'),
            value: widget.foodPreferences.sugarFree,
            onChanged: (value) {
              updateFoodPreferences(createModel().copyWith(sugarFree: value));
            }),
        SwitchListTile(
            title: const Text('Lactose free'),
            value: widget.foodPreferences.lactoseFree,
            onChanged: (value) {
              updateFoodPreferences(createModel().copyWith(lactoseFree: value));
            }),
        SwitchListTile(
            title: const Text('Gluten free'),
            value: widget.foodPreferences.glutenFree,
            onChanged: (value) {
              updateFoodPreferences(createModel().copyWith(glutenFree: value));
            }),
        SwitchListTile(
            title: const Text('Without nuts'),
            value: widget.foodPreferences.withoutNuts,
            onChanged: (value) {
              updateFoodPreferences(createModel().copyWith(withoutNuts: value));
            }),
        SwitchListTile(
            title: const Text('Without peanuts'),
            value: widget.foodPreferences.withoutPeanuts,
            onChanged: (value) {
              updateFoodPreferences(
                  createModel().copyWith(withoutPeanuts: value));
            }),
        SwitchListTile(
            title: const Text('Without soybean'),
            value: widget.foodPreferences.withoutSoybeans,
            onChanged: (value) {
              updateFoodPreferences(
                  createModel().copyWith(withoutSoybeans: value));
            }),
      ],
    ));
  }

  void updateFoodPreferences(FoodPreferencesModel foodPreferences) {
    BlocProvider.of<FoodPreferencesBloc>(context)
        .add(ChangeFoodPreferences(foodPreferences));
  }

  FoodPreferencesModel createModel() {
    return FoodPreferencesModel(
        sugarFree: widget.foodPreferences.sugarFree,
        lactoseFree: widget.foodPreferences.lactoseFree,
        glutenFree: widget.foodPreferences.glutenFree,
        withoutNuts: widget.foodPreferences.withoutNuts,
        withoutPeanuts: widget.foodPreferences.withoutPeanuts,
        withoutSoybeans: widget.foodPreferences.withoutSoybeans,
        version: widget.foodPreferences.version);
  }
}
