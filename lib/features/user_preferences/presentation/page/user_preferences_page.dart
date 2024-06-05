import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/user_preferences_bloc.dart';
import '../widgets/failure_message.dart';
import '../widgets/user_preferences_list_view.dart';
import '../../../../injection_container.dart';

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
      child: BlocConsumer<UserPreferencesBloc, UserPreferencesState>(
        listener: (context, state) {
          if (state is UserPreferencesUpdated) {
            bloc.add(const UserPreferencesLoad());
          }
        },
        builder: (context, state) {
          return BlocBuilder<UserPreferencesBloc, UserPreferencesState>(
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
          );
        },
      ),
    );
  }
}
