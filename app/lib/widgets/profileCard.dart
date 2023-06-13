import 'package:app/assets/Colors.dart';
import 'package:app/firebaseHandler.dart';
import 'package:app/screens/loginScreen.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, required this.data, required this.onDataChanged}) : super(key: key);

  final Map<String, dynamic> data;

  final VoidCallback onDataChanged;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

  FirebaseHandler handler = FirebaseHandler();

  TextEditingController fNameCtrl = TextEditingController();
  bool fNameTFEnabled = false;

  TextEditingController lNameCtrl = TextEditingController();
  bool lNameTFEnabled = false;

  TextEditingController userNameCtrl = TextEditingController();
  bool userNameTFEnabled = false;

  TextEditingController eMailCtrl = TextEditingController();
  bool emailTFEnabled = false;

  @override
  Widget build(BuildContext context) {
    _initData();

    return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
        child: Card(
            color: myGrey.withOpacity(0.4),
            elevation: 20,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FancyText(text: "First Name: ", color: myOrange),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 0),
                          child: SizedBox(
                            width: 120,
                            child: TextField(
                                enabled: fNameTFEnabled,
                                style: const TextStyle(fontFamily: 'Kanit', fontSize: 18.0),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0)),
                                controller: fNameCtrl),
                          )),
                      IconButton(
                        onPressed: () {
                          if (fNameTFEnabled) {
                            handler.saveFName(fNameCtrl.text);
                            widget.onDataChanged();
                          }
                          setState(() { fNameTFEnabled = !fNameTFEnabled; });
                        },
                        icon: fNameTFEnabled ? const Icon(Icons.check_sharp): const Icon(Icons.edit),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FancyText(text: "Last Name: ", color: myOrange),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 0),
                        child: SizedBox(
                          width: 120,
                          child: TextField(
                              enabled: lNameTFEnabled,
                              style: const TextStyle(fontFamily: 'Kanit', fontSize: 18.0),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0)),
                              controller: lNameCtrl),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if(lNameTFEnabled) {
                            handler.saveLName(lNameCtrl.text);
                            widget.onDataChanged();
                          }
                          setState(() {
                            lNameTFEnabled = !lNameTFEnabled;
                          });
                        },
                        icon: lNameTFEnabled ? const Icon(Icons.check_sharp): const Icon(Icons.edit),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FancyText(text: "Username: ", color: myOrange),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 0),
                        child: SizedBox(
                          width: 120,
                          child: TextField(
                              enabled: userNameTFEnabled,
                              style: const TextStyle(fontFamily: 'Kanit', fontSize: 18.0),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0)),
                              controller: userNameCtrl),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (userNameTFEnabled) {
                            handler.saveUserName(userNameCtrl.text);
                            widget.onDataChanged();
                          }
                          setState(() {
                            userNameTFEnabled = !userNameTFEnabled;
                          });
                        },
                        icon: userNameTFEnabled ? const Icon(Icons.check_sharp): const Icon(Icons.edit),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () => _resetPassword(),
                          child: const Text("Change password")),
                      TextButton(
                          onPressed: () => _signOut(),
                          child: const Text("Log out"))
                    ],
                  )
                ],
              )),
            ));
  }

  _resetPassword() {

    final formKey = GlobalKey<FormState>();

    TextEditingController oldPass = TextEditingController();
    TextEditingController newPass = TextEditingController();
    TextEditingController newPassConfirm = TextEditingController();


    Dialog passwordReset = Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 290,
          width: 200,
          child: Center(
            child: Form(
                key: formKey,
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
                        child: TextFormField(
                          controller: oldPass,
                          obscureText: true,
                          decoration: const InputDecoration(hintText: "Current password"),
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              return "Please enter your current password";
                            }
                            return null;
                          },
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
                        child: TextFormField(
                          controller: newPass,
                          obscureText: true,
                          decoration: const InputDecoration(hintText: "Type your new password"),
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              return "Please enter your new password";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
                        child: TextFormField(
                          controller: newPassConfirm,
                          obscureText: true,
                          decoration: const InputDecoration(hintText: "Confirm new password"),
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              return "Please confirm your new password";
                            }
                            if(value != newPass.text) {
                              return "Confirmed password must match";
                            }
                            return null;
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            handler.changePassword(widget.data['eMail'], oldPass.text, newPass.text);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Reset my password"),
                      )
                    ]
                )
            ),
          ),
        ),
      )
    );



    showDialog(context: context, builder: (context) => passwordReset);


  }

  _signOut() {
    handler.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
  }

  _initData() {
    fNameCtrl.text = widget.data['fName'];
    lNameCtrl.text = widget.data['lName'];
    userNameCtrl.text = widget.data['userName'];
    eMailCtrl.text = widget.data['eMail'];
  }
}
