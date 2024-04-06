import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences_entity.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/bloc/user_preferences_bloc.dart';

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
              updateCameraFlash(value);
            },
          ),
          SwitchListTile(
            title: const Text('Biometric authentication'),
            value: widget.userPreferences.useBiometrics,
            onChanged: (value) {
              updateUseBiometrics(value);
            },
          ),
        ],
      ),
    );
  }

  void updateCameraFlash(bool value) {
    BlocProvider.of<UserPreferencesBloc>(context).add(ChangeCameraFlash(value));
  }

  void updateUseBiometrics(bool value) {
    BlocProvider.of<UserPreferencesBloc>(context)
        .add(ChangeUseBiometrics(value));
  }
}
