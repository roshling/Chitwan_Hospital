import 'dart:io';
import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/Widget/InputForm.dart';
import 'package:chitwan_hospital/UI/core/atoms/FForms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum AppointmentT { opd, online, both }

class HospitalProfileSettings extends StatefulWidget {
  @override
  _HospitalProfileSettingsState createState() =>
      _HospitalProfileSettingsState();
}

class _HospitalProfileSettingsState extends State<HospitalProfileSettings> {
  File _profileImg;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _profileImg = File(pickedFile.path);
    });
  }

  Map<String, String> updateData = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    final hospitalDataStore = Provider.of<HospitalDataStore>(context);
    final hospital = hospitalDataStore.user;
    // final departments =  hospitalDataStore.departments;
    final dialog = SimpleDialog(
      children: <Widget>[
        SimpleDialogOption(
          child: Container(child: FForms()),
        ),
        SimpleDialogOption(child: Container(child: FRaisedButton(text: 'Done')))
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
            elevation: 0.0,
            backgroundColor: theme.colorScheme.primary,
            color: Colors.white,
            // onPressed: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => HomePageApp()));
            // },
          )),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            alignment: Alignment.topCenter,
            height: 200.0,
            width: size.width,
            color: theme.colorScheme.primary,
            child: CircleAvatar(
              radius: 55.0,
              backgroundColor: theme.colorScheme.primary,
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    //backgroundImage: FileImage(_profileImg),//Image.file(_profileImg),
                    backgroundColor: theme.colorScheme.background,
                    foregroundColor: Colors.white,
                    radius: 54.0,
                    child: _profileImg != null
                        ? Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(_profileImg),
                                    fit: BoxFit.cover)),
                            //child: Image.file(_profileImg)
                          )
                        : Text(
                            hospital['name'].split(' ').reduce((a, b) {
                              return '${a[0]} ${b[0]}';
                            }),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: theme.colorScheme.primary,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700),
                          ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          icon: Icon(Icons.photo_camera, color: blueGrey),
                          onPressed: getProfileImage))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Container(
            //Name
            padding: const EdgeInsets.all(10.0),
            child: InputField(
              title: 'Name',
              value: hospital["name"] ?? '',
              onChanged: (value) {
                setState(() {
                  updateData['name'] = value;
                });
              },
            ),
          ),
          Padding(
            //Email
            padding: const EdgeInsets.all(10.0),
            child: InputField(
                title: 'Email',
                value: hospital["email"] ?? '',
                onChanged: (value) {
                  setState(() {
                    updateData['email'] = value;
                  });
                }),
          ),
          Container(
            //Contact
            padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            child: InputField(
                title: 'Contact',
                value: hospital['phone'] ?? '',
                onChanged: (value) {
                  setState(() {
                    updateData['phone'] = value;
                  });
                }),
          ),
          Container(
            //Current Address
            padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            child: InputField(
                title: 'Current Address',
                value: hospital['address'] ?? "",
                onChanged: (value) {
                  setState(() {
                    updateData['address'] = value;
                  });
                }),
          ),
          Column(
            //Current Address
            // padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
            children: [
              Column(
                children: <Widget>[
                  FancyText(text: 'Departments'),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        FancyText(text: 'Add Departments'),
                        Icon(
                          Icons.add,
                          color: theme.primaryColor.withOpacity(0.8),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(children: [
                Chip(
                  label: FancyText(text: 'Surgery'),
                )
              ])
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
              alignment: Alignment.center,
              child: FRaisedButton(
                width: size.width * 0.50,
                elevation: 0.0,
                text: "Save Changes",
                bg: theme.colorScheme.primary,
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.w600,
                borderColor: theme.colorScheme.background,
                onPressed: () {
                  print(updateData);
                  // if (updateData.length > 0)
                  // doctorDataStore
                  // .update(updateData)
                  // .then((value) => print(value));
                },
              )),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(height: 20.0),
          FRaisedButton(
            text: 'Change Password',
            color: theme.colorScheme.onPrimary,
            bg: theme.colorScheme.background,
            borderColor: theme.colorScheme.background,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            height: 45.0,
            elevation: 0.0,
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ResetPage()));
            },
          ),
          FRaisedButton(
            text: 'Delete Account',
            color: theme.colorScheme.secondary,
            bg: theme.colorScheme.background,
            borderColor: theme.colorScheme.background,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            height: 45.0,
            elevation: 0.0,
            onPressed: () {
              // Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }
}
