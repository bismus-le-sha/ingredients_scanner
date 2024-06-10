import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/user_preferences_bloc.dart';
import '../widgets/failure_message.dart';
import '../widgets/user_preferences_list_view.dart';

@RoutePage()
class UserPreferencesPage extends StatefulWidget {
  const UserPreferencesPage({super.key});

  @override
  State<UserPreferencesPage> createState() => _UserPreferencesPageState();
}

class _UserPreferencesPageState extends State<UserPreferencesPage> {
  @override
  void initState() {
    BlocProvider.of<UserPreferencesBloc>(context)
        .add(const UserPreferencesLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings Screen')),
        body: BlocConsumer<UserPreferencesBloc, UserPreferencesState>(
          listener: (context, state) {
            if (state is UserPreferencesUpdated) {
              BlocProvider.of<UserPreferencesBloc>(context)
                  .add(const UserPreferencesLoad());
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
                      BlocProvider.of<UserPreferencesBloc>(context)
                          .add(const UserPreferencesLoad());
                    },
                  );
                }
                return const LoadingWidget();
              },
            );
          },
        ));
  }
}
