import 'package:chitwan_hospital/UI/Widget/Forns.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }
enum AppointmentT { opd, online }

class AppointmentForm extends StatefulWidget {
  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  Gender _gender = Gender.male;
  AppointmentT _appointment = AppointmentT.opd;
  List name = [];
  DateTime selectedDate = DateTime.now();
  String _valHospital;
  List _myHospital = [
    "Chitwan Hospital",
    "Chitwan Hospital",
    "Chitwan Hospital",
  ];
  String _valDepartment;
  List _myDepartment = [
    "Operation Theater",
    "ENT",
    "Dermatology",
  ];
  String _valDoctor;
  List _myDoctor = [
    "Dr. Bharati Devi Sharma",
    "Dr. Amit Jha",
    "Dr. Sangeeta Paudel",
  ];
  String _valTime;
  List _myTime = [
    "12:00 PM",
    "5:00 PM",
    "7:00 PM",
  ];

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2020, 9),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var style = TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: blueGrey.withOpacity(0.9));

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: WhiteAppBar(title: "Appointment Form")),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            // first and last name
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                FForms(
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  text: "First Name",
                  textColor: blueGrey.withOpacity(0.7),
                  height: 45.0,
                  width: width * 0.40,
                ),
                SizedBox(width: 10.0),
                FForms(
                  borderColor: theme.colorScheme.primary,
                  formColor: Colors.white,
                  text: "Last Name",
                  type: TextInputType.text,
                  textColor: blueGrey.withOpacity(0.7),
                  height: 45.0,
                  width: width * 0.515,
                )
              ],
            ),
          ),
          Padding(
            //phone number
            padding: const EdgeInsets.all(10.0),
            child: FForms(
              icon: Icon(
                Icons.phone,
                color: theme.iconTheme.color,
              ),
              text: "Phone Number",
              type: TextInputType.phone,
              height: 45.0,
              //width: width * 0.80,
              borderColor: theme.colorScheme.primary,
              formColor: Colors.white,
              textColor: blueGrey.withOpacity(0.7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FancyText(
                    text: "Select Hospital: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: 40.0,
                    // width: width * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: theme.colorScheme.primary,
                        )),
                    child: DropdownButton(
                      underline: SizedBox(),
                      hint: Container(
                          height: 45.0,
                          width: width * 0.50,
                          alignment: Alignment.center,
                          child: FancyText(
                            text: "Select Hospital",
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          )),
                      value: _valHospital,
                      items: _myHospital.map((value) {
                        return DropdownMenuItem(
                          child: FancyText(
                            text: value,
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valHospital = value;
                        });
                      },
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FancyText(
                    text: "Select Department: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: 40.0,
                    // width: width * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: theme.colorScheme.primary,
                        )),
                    child: DropdownButton(
                      underline: SizedBox(),
                      hint: Container(
                          height: 45.0,
                          width: width * 0.40,
                          alignment: Alignment.center,
                          child: FancyText(
                            text: "Select Department",
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          )),
                      value: _valDepartment,
                      items: _myDepartment.map((value) {
                        return DropdownMenuItem(
                          child: FancyText(
                            text: value,
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valDepartment = value;
                        });
                      },
                    ),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FancyText(
                    text: "Select Doctor: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: 40.0,
                    // width: width * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: theme.colorScheme.primary,
                        )),
                    child: DropdownButton(
                      underline: SizedBox(),
                      hint: Container(
                          height: 45.0,
                          width: width * 0.50,
                          alignment: Alignment.center,
                          child: FancyText(
                            text: "Select Doctor",
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          )),
                      value: _valDoctor,
                      items: _myDoctor.map((value) {
                        return DropdownMenuItem(
                          child: FancyText(
                            text: value,
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valDoctor = value;
                        });
                      },
                    ),
                  ),
                ]),
          ),
          Padding(
            //date
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FancyText(
                  text: "Pick a date: ",
                  size: 16.0,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 40.0,
                  width: width * 0.50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: theme.colorScheme.primary,
                      )),
                  child: Center(
                    child: Text(
                      "${selectedDate.day.toString()}-${selectedDate.month.toString()}-${selectedDate.year.toString()}",
                      style: style,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FancyText(
                    text: "Pick Time: ",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: 40.0,
                    // width: width * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: theme.colorScheme.primary,
                        )),
                    child: DropdownButton(
                      underline: SizedBox(),
                      hint: Container(
                          height: 45.0,
                          width: width * 0.45,
                          alignment: Alignment.center,
                          child: FancyText(
                            text: "Pick a time",
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          )),
                      value: _valTime,
                      items: _myTime.map((value) {
                        return DropdownMenuItem(
                          child: FancyText(
                            text: value,
                            color: blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _valTime = value;
                        });
                      },
                    ),
                  ),
                  Icon(Icons.timer)
                ]),
          ),
          Padding(
            //gender
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                FancyText(
                  text: "Consultation Type: ",
                  size: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 10.0),
                Radio(
                  value: AppointmentT.opd,
                  activeColor: theme.iconTheme.color,
                  groupValue: _appointment,
                  onChanged: (AppointmentT value) {
                    setState(() {
                      _appointment = value;
                    });
                  },
                ),
                FancyText(
                  text: "OPD",
                  size: 15.0,
                  color: blueGrey.withOpacity(0.9),
                ),
                Radio(
                  value: AppointmentT.online,
                  activeColor: theme.iconTheme.color,
                  groupValue: _appointment,
                  onChanged: (AppointmentT value) {
                    setState(() {
                      _appointment = value;
                    });
                  },
                ),
                FancyText(
                  text: "Online",
                  size: 15.0,
                  color: blueGrey.withOpacity(0.9),
                ),
              ],
            ),
          ),
          Padding(
            //gender
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                FancyText(
                  text: "Gender: ",
                  size: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 10.0),
                Radio(
                  value: Gender.male,
                  activeColor: theme.iconTheme.color,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                FancyText(
                  text: "Male",
                  size: 15.0,
                  color: blueGrey.withOpacity(0.9),
                ),
                Radio(
                  value: Gender.female,
                  activeColor: theme.iconTheme.color,
                  groupValue: _gender,
                  onChanged: (Gender value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                FancyText(
                  text: "Female",
                  size: 15.0,
                  color: blueGrey.withOpacity(0.9),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 45.0,
              child: RaisedButton(
                onPressed: () {},
                color: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: FancyText(
                  text: "SUBMIT",
                  size: 16.0,
                  color: textDark_Yellow,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}