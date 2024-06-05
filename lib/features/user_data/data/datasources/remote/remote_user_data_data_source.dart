import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ingredients_scanner/core/constants/user_consts.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';

import '../../../../../core/constants/core_consts.dart';
import '../../models/user_data_model.dart';

abstract class RemoteUserDataDataSource {
  Future<UserDataModel> getUserData();
  Future<Unit> addUpdateUserData(UserDataModel userDataModel);
  Future<Unit> addGoogleUserData();
}

class RemoteUserDataDataSourceImpl implements RemoteUserDataDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore instance;
  late final CollectionReference<UserDataModel> _userDataRef;

  RemoteUserDataDataSourceImpl(
      {required this.instance, required this.firebaseAuth}) {
    _userDataRef = instance
        .collection(USER_DATA_DB_NAME)
        .withConverter<UserDataModel>(
            fromFirestore: (snapshots, _) =>
                UserDataModel.fromJson(snapshots.data()!),
            toFirestore: (userData, _) => userData.toJson());
  }

  @override
  Future<UserDataModel> getUserData() async {
    final doc = await _userDataRef.doc(firebaseAuth.currentUser?.uid).get();
    if (doc.exists) {
      return doc.data()!;
    } else {
      throw DataNotFoundExcaption();
    }
  }

  @override
  Future<Unit> addUpdateUserData(UserDataModel userDataModel) async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid != null) {
      await _userDataRef.doc(uid).set(userDataModel);
      return unit;
    } else {
      throw UserNotAuthenticatedException();
    }
  }

  @override
  Future<Unit> addGoogleUserData() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      final userDataModel = UserDataModel(
        userName: user.displayName ?? 'Anonymous',
        email: user.email!,
        avatar: user.photoURL ?? DEFAULT_AVATAR_URL,
      );
      await addUpdateUserData(userDataModel);
      return unit;
    } else {
      throw UserNotAuthenticatedException();
    }
  }
}
