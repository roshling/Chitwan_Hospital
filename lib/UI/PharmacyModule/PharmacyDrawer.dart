import 'package:chitwan_hospital/UI/PharmacyModule/AppointmentTabs/OrderList.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyModule.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyProfile.dart';
import 'package:chitwan_hospital/UI/Widget/FRaisedButton.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/Home/DrawerElements.dart';
import 'package:chitwan_hospital/UI/pages/SignIn/SignIn.dart';
import 'package:chitwan_hospital/service/auth.dart';
import 'package:flutter/material.dart';

class PharmacyDrawerApp extends StatefulWidget {
  @override
  _PharmacyDrawerAppState createState() => _PharmacyDrawerAppState();
}

class _PharmacyDrawerAppState extends State<PharmacyDrawerApp> {
  final user = AuthService.user;

  @override
  Widget build(BuildContext context) {
    //final name = Firestore.instance.collection("users").document(uid).snapshots().toString();
    //final uid = Provider.of<AuthService>(context).getCurrentUid;
    final theme = Theme.of(context);
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            user != null
                ? FutureBuilder(
                    future: AuthService.getCurrentUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return UserAccountsDrawerHeader(
                          accountName: FancyText(
                            text: "${snapshot.data.displayName}",
                            size: 16.0,
                            fontWeight: FontWeight.w600,
                            color: textDark_Yellow,
                          ),
                          accountEmail: FancyText(
                            text: snapshot.data.email,
                            size: 13.0,
                            fontWeight: FontWeight.w500,
                            color: textDark_Yellow,
                          ),
                          currentAccountPicture: GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Colors.white54,
                              child: Icon(Icons.person, color: Colors.black45),
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: gradientColor,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    })
                : DrawerHeader(
                    decoration: BoxDecoration(
                      //color: primary,
                      gradient: gradientColor,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40.0,
                            child: Image.asset(
                              'assets/images/doctor.png',
                            ),
                          ),
                          Container(
                            //login/signup
                            color: Colors.transparent,
                            alignment: Alignment.bottomLeft,
                            child: ListTile(
                              title: Text('Log in   .   Sign up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: textDark_Yellow)),
                              contentPadding: EdgeInsets.only(left: 5.0),
                              trailing: Icon(
                                Icons.arrow_right,
                                color: theme.iconTheme.color,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              },
                              // onTap: () {
                              //   setState(() {
                              //     loggedIn = true;
                              //   });
                              // },
                            ),
                          )
                        ])),
            Padding(
              padding: EdgeInsets.all(3.0),
            ),
            DrawerElements(
              //Home
              title: 'Home',
              icon: 'assets/images/drawerIcon/home.png',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PharmacyModule()));
              },
            ),
            user != null
                ? DrawerElements(
                    //Settings
                    title: 'Profile',
                    icon: 'assets/images/drawerIcon/profile.png',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PharmacyProfile()));
                    },
                  )
                : SizedBox.shrink(),
            user != null
                ? DrawerElements(
                    //Home
                    title: 'Order List',
                    icon: 'assets/images/drawerIcon/calendar.png',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OrderList()));
                    },
                  )
                : SizedBox.shrink(),
            Divider(
              color: Colors.grey[500],
              height: 5.0,
            ),
            DrawerElements(
              // About Us
              title: 'About Us',
              icon: 'assets/images/drawerIcon/about.png',
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            DrawerElements(
              // Terms & Conditions
              title: 'Terms & Conditions',
              icon: 'assets/images/drawerIcon/terms.png',
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            user != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 18.0, right: 18.0),
                    child: FRaisedButton(
                        elevation: 0.0,
                        height: 40.0,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        borderColor: theme.colorScheme.secondary,
                        text: "Sign Out",
                        onPressed: () async {
                          AuthService.signOut();
                          setState(() {
                            loggedIn = false;
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (Route<dynamic> route) => false);
                        },
                        color: textDark_Yellow,
                        bg: theme.colorScheme.secondary,
                        shape: false),
                  )
                : SizedBox(height: 0.0),
            SizedBox(height: 15.0)
          ],
        ),
      ),
    );
  }
}
