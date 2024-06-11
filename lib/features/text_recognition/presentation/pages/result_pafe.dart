import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/core/widgets/loading_widget.dart';
import 'package:ingredients_scanner/features/text_recognition/presentation/widgets/result_page_controller.dart';
import '../../../food_preferences/presentation/bloc/food_preferences_bloc.dart';
import '../../domain/entities/text_recognition_entity.dart';

@RoutePage()
class ResultPage extends StatefulWidget {
  final TextRecognitionEntity textRecognitionEntity;

  const ResultPage({super.key, required this.textRecognitionEntity});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    BlocProvider.of<FoodPreferencesBloc>(context)
        .add(const FoodPreferencesLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: BlocBuilder<FoodPreferencesBloc, FoodPreferencesState>(
            builder: (context, state) {
          if (state is FoodPreferencesLoaded) {
            return ResultPageController(
                resultText: widget.textRecognitionEntity.text,
                foodPreferences: state.foodPreferences);
          }
          if (state is FoodPreferencesFailure) {}
          return const LoadingWidget();
        }),
      );
}
