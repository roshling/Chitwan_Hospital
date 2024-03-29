import 'package:chitwan_hospital/UI/LabModule/LabCard.dart';
import 'package:chitwan_hospital/UI/LabModule/LabModule.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/models/LabAppointment.dart';
import 'package:chitwan_hospital/state/lab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabOrder extends StatefulWidget {
  LabOrder({Key key}) : super(key: key);

  @override
  _LabOrderState createState() => _LabOrderState();
}

class _LabOrderState extends State<LabOrder> {
  String name, title;
  List search;
  LabAppointment orderData = LabAppointment();
  bool isActive = false;
  final FocusNode _patientNameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labDataStore = Provider.of<LabDataStore>(context);
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: 'Create Order',
              titleColor: textDark,
            ),
            preferredSize: Size.fromHeight(40.0)),
        backgroundColor: theme.colorScheme.background,
        persistentFooterButtons: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: RaisedButton(
                color: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: FancyText(
                  text: "SUBMIT",
                  size: 16.0,
                  color: textDark_Yellow,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: orderData != null && !isActive
                    ? () {
                        setState(() {
                          isActive = true;
                        });
                        labDataStore
                            .createOrder(orderData.toJson())
                            .then((value) {
                          setState(() {
                            isActive = false;
                          });
                          if (value) {
                            // labDataStore.addOrder(orderData);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LabModule()),
                                (Route<dynamic> route) => false);
                          }
                        });
                      }
                    : null,
              ),
            ),
          ),
        ],
        body: ListView(
          children: <Widget>[
            BoolIndicator(isActive),
            Padding(padding: EdgeInsets.all(10)),
            Padding(
              //phone number
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                icon: Icon(
                  Icons.title,
                  color: theme.iconTheme.color,
                ),
                text: "Title",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) =>
                    val.isEmpty || val.length < 8 ? 'Title is required' : null,
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
            ),
            Padding(
              //phone number

              padding: const EdgeInsets.all(10.0),
              child: FForms(
                textInputAction: TextInputAction.done,
                currentFocus: _patientNameFocus,
                icon: Icon(
                  Icons.people,
                  color: theme.iconTheme.color,
                ),
                text: "Patient Name",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) =>
                    val.isEmpty || val.length < 8 ? 'Name is required' : null,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
            FlatButton(
              // color: theme.primaryColor,
              onPressed: name != null &&
                      title != null &&
                      name.length > 8 &&
                      title.length > 8
                  ? () {
                      setState(() {
                        orderData = null;
                      });
                      if (name.length > 8)
                        labDataStore.getUserInfo(name).listen((event) {
                          final data = event.documents.map((e) {
                            final ret = e.data;
                            ret['id'] = e.documentID;
                            return ret;
                          }).toList();
                          if (data != null && data.length > 0) {
                            setState(() {
                              search = data;
                            });
                          }
                        });
                    }
                  : null,
              child: Row(
                children: <Widget>[
                  Text(
                    'Find User ',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: name != null &&
                                name.length > 8 &&
                                title != null &&
                                title.length > 8
                            ? theme.primaryColor
                            : theme.disabledColor),
                  ),
                  Icon(
                    Icons.search,
                    color: name != null && name.length > 8
                        ? theme.primaryColor
                        : theme.disabledColor,
                  )
                ],
              ),
            ),
            orderData == null && search != null && search.length > 0
                ? Column(
                    children: search
                        .map<Widget>(
                          (e) => InkWell(
                              onTap: () {
                                setState(() {
                                  orderData = LabAppointment.fromJson({
                                    'name': e['name'],
                                    'email': e['email'],
                                    'phone': e['phone'],
                                    'uid': e['id'],
                                    'title': title,
                                    'labId': labDataStore.user.uid,
                                    'timestamp':
                                        DateTime.now().toIso8601String(),
                                    if (labDataStore.user.address != null)
                                      'address': labDataStore.user.address
                                  });
                                });
                              },
                              // canRequestFocus: true,

                              child: LabCard(
                                name: e['name'],
                                email: e['email'],
                                phone: e['phone'],
                              )),
                        )
                        .toList(),
                  )
                : orderData != null
                    ? LabCard(
                        name: orderData.name,
                        email: orderData.email,
                        phone: orderData.phone,
                      )
                    : SizedBox.shrink()
          ],
        ));
  }
}
