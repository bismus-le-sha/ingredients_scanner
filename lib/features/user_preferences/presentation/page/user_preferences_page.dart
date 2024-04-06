import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/core/widgets/loading_widget.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/bloc/user_preferences_bloc.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/widgets/failure_message.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/widgets/user_preferences_widget.dart';
import 'package:ingredients_scanner/injection_container.dart';

@RoutePage()
class UserPreferencesPage extends StatelessWidget {
  const UserPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings Screen')),
        body: _buildBody());
  }

  BlocProvider<UserPreferencesBloc> _buildBody() {
    final bloc = sl<UserPreferencesBloc>();

    return BlocProvider(
      create: (_) {
        bloc.add(const UserPreferencesLoad());
        return bloc;
      },
      child: BlocBuilder<UserPreferencesBloc, UserPreferencesState>(
        builder: (context, state) {
          if (state is UserPreferencesLoaded) {
            return UserPreferencesListView(
                userPreferences: state.userPreferences);
          }
          if (state is UserPreferencesFailure) {
            return FailureMessage(
              message: state.message,
              onRetry: () {
                bloc.add(const UserPreferencesLoad());
              },
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
