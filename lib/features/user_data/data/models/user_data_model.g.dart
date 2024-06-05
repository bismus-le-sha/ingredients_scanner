// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      userName: json['userName'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'email': instance.email,
      'avatar': instance.avatar,
    };
