import 'package:json_annotation/json_annotation.dart';
import 'package:ingredients_scanner/features/user_data/domain/entities/user_data_entity.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel extends UserDataEntity {
  const UserDataModel({
    required super.userName,
    required super.email,
    required super.avatar,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}
