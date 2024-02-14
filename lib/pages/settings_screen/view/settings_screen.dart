import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/pages/settings_screen/bloc/settings_screen_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _settingsScreenBloc = SettingsScreenBloc();

  @override
  void initState() {
    _settingsScreenBloc.add(LoadSettingScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Settings Screen')),
        body: BlocBuilder<SettingsScreenBloc, SettingsScreenState>(
          bloc: _settingsScreenBloc,
          builder: (context, state) {
            if (state is SettingsScreenLoaded) {
              return SettingsList(sections: [
                SettingsSection(
                  tiles: [
                    SettingsTile(
                      title: const Text('Language'),
                      onPressed: (context) {},
                    ),
                    SettingsTile.switchTile(
                      title: const Text('Camera Flash'),
                      initialValue: state.userPreferences.getCameraFlash(),
                      onToggle: (value) {
                        setState(() {
                          state.userPreferences.setCameraFlash(value);
                        });
                      },
                    ),
                  ],
                ),
              ]);
            }
            if (state is SettingsScreenLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      'Please try againg later',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        _settingsScreenBloc.add(LoadSettingScreen());
                      },
                      child: const Text('Try againg'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
