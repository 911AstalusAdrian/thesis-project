import 'package:app/screens/mainNavigationScreen.dart';
import 'package:app/screens/signInScreen.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _secureStorage = const FlutterSecureStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 55.0),
                  child: Icon(
                    Icons.airplane_ticket_outlined,
                    size: 150.0,
                    color: Colors.orange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an e-mail!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                      hintText: 'john@gmail.com',
                    ),
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password!';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    controller: passwordController,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      _forgotPasswordDialog();
                    },
                    child: const Text('Forgot my password')),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text('Log In',
                      style: TextStyle(fontSize: 22.0, color: Colors.white)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        },
                        child: const Text('Sign In'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _secureStorage.write(key: "uid", value: credential.user!.uid);
      if (!mounted) return;
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainNavigationScreen(index: 0)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("user-not-found error");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("User not found!"),
                content: const Text("Please try again"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"))
                ],
              );
            });
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Invalid password!"),
                content: const Text("Please try again"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"))
                ],
              );
            });
      } else {
        print(e.code);
      }
    }
  }

  _resetPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try{
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("PASSWORD RESET ERROR");
    }
  }

  _forgotPasswordDialog() async {
    TextEditingController email = TextEditingController();

    Dialog passwordReset = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: 175,
          child: Column(
            children: [
              FancyText(text: "Forgot my password"),
              SizedBox(
                  width: 200,
                  child: TextField(
                      controller: email,
                    decoration: const InputDecoration(hintText: "Enter your e-mail"),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    _resetPassword(email.text);
                    Navigator.of(context).pop();},
                    child: const Text("Send e-mail")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"))
            ],
          ),
        ));

    showDialog(context: context, builder: (BuildContext ctx) => passwordReset);
  }
}
