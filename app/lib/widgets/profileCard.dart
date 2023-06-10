import 'package:app/assets/Colors.dart';
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
  bool fNameTextFieldEnabled = false;

  @override
  Widget build(BuildContext context) {
    final UserModel user = UserModel(
        fName: widget.data['fName'],
        lName: widget.data['lName'],
        userName: widget.data['userName'],
        eMail: widget.data['eMail']);

    fNameCtrl.text = user.fName;


    return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 10.0),
        child: Card(
            color: myGrey.withOpacity(0.5),
            elevation: 20,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.person_outline, size: 50.0, color: myOrange),
                  ),
                  Row(
                    children: [
                      const Text("First Name:"),
                      Row(children: [
                        Container(
                          width: 50,
                          child: TextField(
                              enabled: fNameTextFieldEnabled,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0)),
                              controller: fNameCtrl
                          ),
                        ),
                        IconButton(

                          onPressed: () {
                            setState(() {
                              fNameTextFieldEnabled = !fNameTextFieldEnabled;
                            });
                          },
                          icon: Icon(Icons.edit),
                        )
                      ],),
                      const SizedBox(width: 30.0),
                      const Text("Last Name:"),
                      Text(user.lName),
                    ],
                  ),

                ],
              ),
            )
        )
    );
  }
}