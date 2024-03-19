import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import '../bloc/food_preferences/food_preference_page_bloc.dart';

@RoutePage()
class FoodPreferencePage extends StatefulWidget {
  const FoodPreferencePage({super.key});

  @override
  State<FoodPreferencePage> createState() => _FoodPreferencePageState();
}

class _FoodPreferencePageState extends State<FoodPreferencePage> {
  final _foodPreferenceScreenBloc = FoodPreferencePageBloc();

  @override
  void initState() {
    _foodPreferenceScreenBloc.add(LoadFoodPreferencePage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Food Preference Screen'),
        ),
        body: BlocBuilder<FoodPreferencePageBloc, FoodPreferencePageState>(
          bloc: _foodPreferenceScreenBloc,
          builder: (context, state) {
            if (state is FoodPreferencePageLoaded) {
              return SettingsList(sections: [
                SettingsSection(tiles: [
                  SettingsTile.switchTile(
                    title: const Text('Shugar free'),
                    initialValue: state.productPreferences.getShugarFree(),
                    onToggle: (value) {
                      setState(() {
                        state.productPreferences.setShugarFree(value);
                      });
                    },
                  ),
                  SettingsTile.switchTile(
                    title: const Text('Lactose free'),
                    initialValue: state.productPreferences.getLactoseFree(),
                    onToggle: (value) {
                      setState(() {
                        state.productPreferences.setLactoseFree(value);
                      });
                    },
                  ),
                  SettingsTile.switchTile(
                    title: const Text('Gluten free'),
                    initialValue: state.productPreferences.getGlutenFree(),
                    onToggle: (value) {
                      setState(() {
                        state.productPreferences.setGlutenFree(value);
                      });
                    },
                  ),
                  SettingsTile.switchTile(
                    title: const Text('Without nuts'),
                    initialValue: state.productPreferences.getWithoutNutsh(),
                    onToggle: (value) {
                      setState(() {
                        state.productPreferences.setWithoutNuts(value);
                      });
                    },
                  ),
                  SettingsTile.switchTile(
                    title: const Text('Without peanuts'),
                    initialValue: state.productPreferences.getWithoutPeauts(),
                    onToggle: (value) {
                      setState(() {
                        state.productPreferences.setWithoutPeauts(value);
                      });
                    },
                  ),
                  SettingsTile.switchTile(
                    title: const Text('Without soybeans'),
                    initialValue: state.productPreferences.getWithoutSoybeans(),
                    onToggle: (value) {
                      setState(() {
                        state.productPreferences.setWithoutSoybeans(value);
                      });
                    },
                  )
                ])
              ]);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
