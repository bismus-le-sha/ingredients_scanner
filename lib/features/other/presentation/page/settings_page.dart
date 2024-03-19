import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import '../bloc/settings_page/settings_page_bloc.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _settingsScreenBloc = SettingsPageBloc();

  @override
  void initState() {
    _settingsScreenBloc.add(LoadSettingPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Settings Screen')),
        body: BlocBuilder<SettingsPageBloc, SettingsPageState>(
          bloc: _settingsScreenBloc,
          builder: (context, state) {
            if (state is SettingsPageLoaded) {
              return SettingsList(sections: [
                SettingsSection(
                  tiles: [
                    SettingsTile(
                      title: const Text('Language'),
                      onPressed: (context) {},
                    ),
                    SettingsTile.switchTile(
                      title: const Text('Camera flash'),
                      initialValue: state.userPreferences.getCameraFlash(),
                      onToggle: (value) {
                        setState(() {
                          state.userPreferences.setCameraFlash(value);
                        });
                      },
                    ),
                    SettingsTile.switchTile(
                      title: const Text('Biometric authentication'),
                      initialValue: state.userPreferences.getUseBiometrics(),
                      onToggle: (value) {
                        setState(() {
                          state.userPreferences.setUseBiometrics(value);
                        });
                      },
                    ),
                  ],
                ),
              ]);
            }
            if (state is SettingsPageLoadingFailure) {
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
                        _settingsScreenBloc.add(LoadSettingPage());
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
