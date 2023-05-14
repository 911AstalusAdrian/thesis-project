import 'package:app/screens/mainNavigationScreen.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hiddenPass = true;
  bool _hiddenConfirmPass = true;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, size: 20.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: TextFormField(
                        validator: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name',
                        ),
                        controller: fNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: TextFormField(
                        validator: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Name',
                        ),
                        controller: lNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: TextFormField(
                        validator: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-mail',
                        ),
                        controller: emailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: TextFormField(
                        validator: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        controller: usernameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: TextFormField(
                        validator: (value) {
                          return null;
                        },
                        obscureText: _hiddenPass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hiddenPass = !_hiddenPass;
                                });
                              },
                              icon: Icon(_hiddenPass ? Icons.visibility : Icons.visibility_off)),
                          border: const OutlineInputBorder(),
                          labelText: 'Choose a Password',
                        ),
                        controller: passwordController,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                        child: TextFormField(
                          validator: (value) {},
                          obscureText: _hiddenConfirmPass,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _hiddenConfirmPass = !_hiddenConfirmPass;
                                  });
                                },
                                icon: Icon(_hiddenConfirmPass ? Icons.visibility : Icons.visibility_off)),
                            border: const OutlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                          controller: confirmPassController,
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainNavigationScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 30.0),
                              backgroundColor: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: const Text("Sign me in!",
                              style: TextStyle(fontSize: 22.0, color: Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
