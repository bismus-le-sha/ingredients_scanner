import 'package:equatable/equatable.dart';

class FoodPreferencesEntity extends Equatable {
  final bool sugarFree;
  final bool lactoseFree;
  final bool glutenFree;
  final bool withoutNuts;
  final bool withoutPeanuts;
  final bool withoutSoybeans;
  final int version;

  const FoodPreferencesEntity(
      {required this.sugarFree,
      required this.lactoseFree,
      required this.glutenFree,
      required this.withoutNuts,
      required this.withoutPeanuts,
      required this.withoutSoybeans,
      required this.version});

  @override
  List<Object?> get props => [
        sugarFree,
        lactoseFree,
        glutenFree,
        withoutNuts,
        withoutPeanuts,
        withoutSoybeans,
        version
      ];
}
