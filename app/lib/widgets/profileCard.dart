import 'package:app/assets/Colors.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
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
        margin: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 10.0),
        child: Card(
            color: myGrey.withOpacity(0.4),
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          FancyText(text: "First Name: ", color: myOrange),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 0),
                              child: SizedBox(
                                width: 50,
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
                              setState(() {
                                fNameTFEnabled = !fNameTFEnabled;
                              });
                            },
                            icon: fNameTFEnabled ? const Icon(Icons.check_sharp): const Icon(Icons.edit),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          FancyText(text: "Last Name: ", color: myOrange),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0),
                            child: SizedBox(
                              width: 50,
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
                              setState(() {
                                lNameTFEnabled = !lNameTFEnabled;
                              });
                            },
                            icon: lNameTFEnabled ? const Icon(Icons.check_sharp): const Icon(Icons.edit),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          FancyText(text: "Username: ", color: myOrange),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 0),
                            child: SizedBox(
                              width: 50,
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
                              setState(() {
                                userNameTFEnabled = !userNameTFEnabled;
                              });
                            },
                            icon: userNameTFEnabled ? const Icon(Icons.check_sharp): const Icon(Icons.edit),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  _initData() {
    // final UserModel user = UserModel(
    //     fName: widget.data['fName'],
    //     lName: widget.data['lName'],
    //     userName: widget.data['userName'],
    //     eMail: widget.data['eMail']);

    fNameCtrl.text = widget.data['fName'];
    lNameCtrl.text = widget.data['lName'];
    userNameCtrl.text = widget.data['userName'];
    eMailCtrl.text = widget.data['eMail'];
  }
}
