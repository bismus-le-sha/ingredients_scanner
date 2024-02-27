import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ingredients_scanner/user_auth/auth_service/firebase_auth_service.dart';
import '../../../router/router.dart';

@RoutePage()
class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _usernameController =
      TextEditingController(text: "");
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  bool _obscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                  height: size.height * .45,
                  child: Image.asset('assets/images/2.jpg')),
              SizedBox(
                height: size.height * .02,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        validator: (String? value) {
                          return value == null || value.isEmpty
                              ? 'Please enter your username'
                              : null;
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Username',
                          prefixIcon: const Icon(
                            Iconsax.user,
                            color: Colors.black,
                            size: 18,
                          ),
                          suffixIcon: IconButton(
                            onPressed: _emailController.clear,
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (String? value) {
                          return value == null || value.isEmpty
                              ? 'Please enter your email'
                              : !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)
                                  ? 'Please enter a valid email address'
                                  : null;
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Email',
                          prefixIcon: const Icon(
                            Icons.mail,
                            color: Colors.black,
                            size: 18,
                          ),
                          suffixIcon: IconButton(
                            onPressed: _emailController.clear,
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String? value) {
                          return value == null || value.isEmpty
                              ? 'Please enter your password'
                              : value.length < 8
                                  ? 'Password must be at least 8 characters'
                                  : null;
                        },
                        obscureText: _obscureText,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Iconsax.eye4 : Iconsax.eye_slash4,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          labelText: 'Password',
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Iconsax.key,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: size.height * .12,
              ),
              MaterialButton(
                onPressed: _authService.signUp(_emailController.text,
                    _passwordController.text, _scaffoldKey),
                height: size.height * .045,
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: size.height * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () =>
                        AutoRouter.of(context).push(const LoginRoute()),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Color(0xFF13B5A2),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
