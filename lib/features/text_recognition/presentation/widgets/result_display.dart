import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/diet_controller/diet_dictionary.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../food_preferences/presentation/bloc/food_preferences_bloc.dart';
import '../../../../injection_container.dart';

class ResultDisplay extends StatelessWidget {
  final String resultText;

  const ResultDisplay({
    super.key,
    required this.resultText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(30.0), child: _buildBody());
  }

  BlocProvider<FoodPreferencesBloc> _buildBody() {
    final bloc = sl<FoodPreferencesBloc>();

    return BlocProvider(
      create: (_) {
        bloc.add(const FoodPreferencesLoad());
        return bloc;
      },
      child: BlocBuilder<FoodPreferencesBloc, FoodPreferencesState>(
        builder: (context, state) {
          List<String> resulTextWords =
              resultText.toLowerCase().split(RegExp(r'[^a-zA-Zа-яА-Я\-]+'));
          if (state is FoodPreferencesLoaded) {
            return _findMatch(
                _matchSet(
                    resulTextWords,
                    DietDictionary()
                        .fromFoodModelToDiets(state.foodPreferences)),
                resulTextWords);
          }
          if (state is FoodPreferencesFailure) {}
          return const LoadingWidget();
        },
      ),
    );
  }

  Set<String> _matchSet(List<String> words, List<Diets> dietsList) {
    Set<String> toSetList = words.toSet();
    return toSetList
        .intersection(DietDictionary().getDietDictionary(dietsList));
  }

  Text _findMatch(Set<String> matchSet, List<String> result) {
    List<TextSpan> text = [];
    for (String word in result) {
      matchSet.contains(word)
          ? text.add(TextSpan(
              text: '$word ', style: const TextStyle(color: Colors.red)))
          : text.add(TextSpan(
              text: '$word ', style: const TextStyle(color: Colors.black)));
    }
    return Text.rich(TextSpan(children: text));
  }
}
