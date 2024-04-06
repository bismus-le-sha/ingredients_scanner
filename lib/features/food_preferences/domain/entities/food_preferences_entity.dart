import 'package:equatable/equatable.dart';

class FoodPreferencesEntity extends Equatable {
  final bool shugarFree;
  final bool lactoseFree;
  final bool glutenFree;
  final bool withoutNuts;
  final bool withoutPeanuts;
  final bool withoutSoybeans;
  final int version;

  const FoodPreferencesEntity(
      {required this.shugarFree,
      required this.lactoseFree,
      required this.glutenFree,
      required this.withoutNuts,
      required this.withoutPeanuts,
      required this.withoutSoybeans,
      required this.version});

  @override
  List<Object?> get props => [
        shugarFree,
        lactoseFree,
        glutenFree,
        withoutNuts,
        withoutPeanuts,
        withoutSoybeans,
        version
      ];
}
