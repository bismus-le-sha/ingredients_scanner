import 'package:equatable/equatable.dart';
import '../../../data/models/user_data_model.dart';

class UserDataParams extends Equatable {
  final UserDataModel userData;

  const UserDataParams({required this.userData});

  @override
  List<Object?> get props => [userData];
}
