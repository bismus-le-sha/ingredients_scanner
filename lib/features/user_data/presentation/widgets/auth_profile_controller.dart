import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ingredients_scanner/features/user_data/domain/entities/user_data_entity.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';

class AuthProfileController extends StatefulWidget {
  final UserDataEntity userData;
  const AuthProfileController({
    super.key,
    required this.userData,
  });

  @override
  State<AuthProfileController> createState() => _AuthProfileControllerState();
}

class _AuthProfileControllerState extends State<AuthProfileController> {
  late XFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: _list(size),
    );
  }

  Widget _logOut(size) {
    return MaterialButton(
      onPressed: () => BlocProvider.of<AuthBloc>(context).add(LogOutEvent()),
      height: size.height * .045,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Text(
        "Logout",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }

  Widget _list(Size size) {
    return ListView(
      children: [
        SizedBox(
          height: size.height * .05,
        ),
        // profil pic
        _imageProfile(),
        SizedBox(
          height: size.height * .02,
        ),
        //user name
        Text(
          widget.userData.userName,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * .02,
        ),
        //user email
        Text(
          widget.userData.email,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * .3,
        ),
        Center(child: _logOut(size))
      ],
    );
  }

  Widget _imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: widget.userData.avatar != null
              ? NetworkImage(widget.userData.avatar!)
              : const AssetImage('assets/images/Jellygummies.jpg')
                  as ImageProvider,
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
  }
}
