import 'dart:io';
import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/Widget/InputForm.dart';
import 'package:chitwan_hospital/UI/core/atoms/FForms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/SnackBar.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/resetPassword.dart';
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
    if (pickedFile?.path != null)
      setState(() {
        _profileImg = File(pickedFile.path);
      });
  }

  Map<String, String> updateData = {};
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    final hospitalDataStore = Provider.of<HospitalDataStore>(context);
    final hospital = hospitalDataStore.user;

    List<Widget> buildDepartmentChips(String departments) {
      if (departments == null || departments.length == 0) return [];
      final newDepartments = departments.split(';');
      newDepartments.removeWhere((element) => element.length == 0);
      return newDepartments.map<Widget>((e) {
        return Chip(
          backgroundColor: blueGrey,
          label: FancyText(
            text: e,
            color: textDark_Yellow,
          ),
          // deleteIcon: Icon(Icons.delete),
          deleteIconColor: textDark_Yellow,
          onDeleted: () {
            if (updateData['departments'] == null) {
              final newData = hospital.departments.split(';');
              newData.removeWhere(
                  (element) => element.length == 0 || element == e);
              final String deps = newData.length > 0 ? newData.join(';') : '';
              setState(() {
                updateData['departments'] = deps;
              });
            } else {
              final newData = updateData['departments'].split(';');
              newData.removeWhere(
                  (element) => element.length == 0 || element == e);
              final String deps = newData.length > 0 ? newData.join(';') : null;
              setState(() {
                updateData['departments'] = deps;
              });
            }
          },
        );
      }).toList();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(
            elevation: 0.0,
            backgroundColor: theme.colorScheme.primary,
            color: Colors.white,
            bottom: PreferredSize(
              child: BoolIndicator(isActive),
              preferredSize: Size.fromHeight(1),
            ),
          )),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            BoolIndicator(isActive),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
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
                                  hospital != null
                                      ? hospital.name.split(' ').reduce((a, b) {
                                          return '${a[0]} ${b[0]}';
                                        })
                                      : '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          color: theme.colorScheme.primary,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w700),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                FRaisedButton(
                  needIcon: true,
                  image: "assets/images/camera.png",
                  imgcolor: textDark_Yellow,
                  text: "Change Photo",
                  color: textDark_Yellow,
                  borderColor: Colors.transparent,
                  bg: theme.colorScheme.primary,
                  elevation: 0.0,
                  width: MediaQuery.of(context).size.width * 0.50,
                  onPressed: getProfileImage,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              //Name
              padding: const EdgeInsets.all(10.0),
              child: InputField(
                title: 'Name',
                value: hospital != null ? hospital.name : '',
                onChanged: (value) {
                  setState(() {
                    updateData = {...updateData, 'name': value};
                  });
                },
              ),
            ),
            Padding(
              //Email
              padding: const EdgeInsets.all(10.0),
              child: InputField(
                  title: 'Email',
                  value: hospital != null ? hospital.email : '',
                  onChanged: (value) {
                    setState(() {
                      updateData = {...updateData, 'email': value};
                    });
                  }),
            ),
            Container(
              //Contact
              padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: InputField(
                  title: 'Contact',
                  value: hospital != null ? hospital.phone : '',
                  onChanged: (value) {
                    setState(() {
                      updateData = {...updateData, 'phone': value};
                    });
                  }),
            ),
            Container(
              //Current Address
              padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: InputField(
                  title: 'Current Address',
                  value: hospital != null ? hospital.address ?? "" : '',
                  onChanged: (value) {
                    setState(() {
                      updateData = {...updateData, 'address': value};
                    });
                  }),
            ),
            Container(
              //Current Address
              padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: InputField(
                  maxLines: 10,
                  title: 'About',
                  value: hospital != null ? hospital.about ?? "" : '',
                  onChanged: (value) {
                    setState(() {
                      updateData = {...updateData, 'about': value};
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 22.0, right: 20.0),
              child: Column(
                //Current Address
                // padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Departments',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String localData;
                                return SimpleDialog(
                                  children: <Widget>[
                                    SimpleDialogOption(
                                      child: FForms(
                                        underline: false,
                                        borderColor: theme.colorScheme.primary,
                                        text: "Department",
                                        onChanged: (value) {
                                          setState(() {
                                            localData = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SimpleDialogOption(
                                        child: Container(
                                            child: FRaisedButton(
                                      text: 'Add',
                                      onPressed: () {
                                        setState(() {
                                          if (localData != null &&
                                              localData.length >
                                                  2) if (updateData[
                                                      'departments'] !=
                                                  null &&
                                              updateData['departments'].length >
                                                  0) {
                                            updateData = {
                                              ...updateData,
                                              'departments':
                                                  updateData['departments'] +
                                                      ';' +
                                                      localData
                                            };
                                          } else {
                                            updateData = {
                                              ...updateData,
                                              'departments':
                                                  hospital.departments != null
                                                      ? hospital.departments +
                                                          ';' +
                                                          localData
                                                      : localData
                                            };
                                          }
                                        });
                                        Navigator.pop(context);
                                      },
                                      bg: theme.colorScheme.primary,
                                      color: textDark_Yellow,
                                    )))
                                  ],
                                );
                              });
                        },
                        child: Row(
                          children: <Widget>[
                            FancyText(text: 'Add '),
                            Icon(
                              Icons.add,
                              color: blueGrey,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: buildDepartmentChips(
                        updateData['departments'] ?? hospital.departments),
                  )
                ],
              ),
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
                  onPressed: () async {
                    if (updateData.length > 0) {
                      setState(() {
                        isActive = true;
                      });
                      final result = await hospitalDataStore.update(updateData);
                      setState(() {
                        isActive = false;
                        updateData = {};
                      });

                      if (result) {
                        buildAndShowFlushBar(
                          context: context,
                          icon: Icons.check,
                          text: 'Profile has been updated!',
                        );
                      }
                    }
                  },
                )),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(height: 20.0),
            FRaisedButton(
              text: 'Reset Password',
              color: theme.colorScheme.onPrimary,
              bg: theme.colorScheme.background,
              borderColor: theme.colorScheme.background,
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              height: 45.0,
              elevation: 0.0,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPassword(
                              email: hospital != null ? hospital.email : null,
                              signout: hospitalDataStore.clearState,
                            )));
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
      ),
    );
  }
}
