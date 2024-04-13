import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_preferences_model.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../bloc/user_preferences_bloc.dart';

class UserPreferencesListView extends StatefulWidget {
  final UserPreferencesEntity userPreferences;
  const UserPreferencesListView({super.key, required this.userPreferences});

  @override
  State<UserPreferencesListView> createState() =>
      _UserPreferencesListViewState();
}

class _UserPreferencesListViewState extends State<UserPreferencesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Camera flash'),
            value: widget.userPreferences.cameraFlash,
            onChanged: (value) {
              updateUserPreferences(model().copyWith(cameraFlash: value));
            },
          ),
          SwitchListTile(
            title: const Text('Biometric authentication'),
            value: widget.userPreferences.useBiometrics,
            onChanged: (value) {
              updateUserPreferences(model().copyWith(useBiometrics: value));
            },
          ),
        ],
      ),
    );
  }

  void updateUserPreferences(UserPreferencesModel value) {
    BlocProvider.of<UserPreferencesBloc>(context)
        .add(ChangeUserPreferences(value));
  }

  UserPreferencesModel model() {
    return UserPreferencesModel(
        cameraFlash: widget.userPreferences.cameraFlash,
        useBiometrics: widget.userPreferences.useBiometrics);
  }
}
