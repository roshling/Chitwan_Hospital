import 'package:chitwan_hospital/UI/Widget/Forns.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/SignIn.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.background,
        body: Stack(
          children: <Widget>[
            Container(
                height: size.height,
                child: Image.asset(
                  "assets/images/img3.jpeg",
                  fit: BoxFit.fitHeight,
                )),
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: textDark_Yellow,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: theme.background,
                      ),
                      width: size.width * 0.90,
                      height: 165.0,
                      child: Column(children: <Widget>[
                        FForms(
                          borderColor: theme.background,
                          formColor: Colors.white,
                          text: "Email",
                          textColor: blueGrey.withOpacity(0.7),
                          height: 55.0,
                          width: size.width * 0.90,
                        ),
                        FForms(
                          borderColor: theme.background,
                          formColor: Colors.white,
                          text: "Username",
                          textColor: blueGrey.withOpacity(0.7),
                          height: 55.0,
                          width: size.width * 0.90,
                        ),
                        FForms(
                          borderColor: theme.background,
                          formColor: Colors.white,
                          text: "Password",
                          textColor: blueGrey.withOpacity(0.7),
                          height: 55.0,
                          width: size.width * 0.90,
                        ),
                      ])),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: theme.background,
                    ),
                    width: size.width * 0.90,
                    height: 155.0,
                    child: Column(
                      children: <Widget>[
                        // SizedBox(height: 10.0),
                        FForms(
                          borderColor: theme.background,
                          formColor: Colors.white,
                          text: "Full Name",
                          textColor: blueGrey.withOpacity(0.7),
                          height: 55.0,
                          width: size.width * 0.90,
                        ),
                        FForms(
                          borderColor: theme.background,
                          formColor: Colors.white,
                          text: "Phone Number",
                          textColor: blueGrey.withOpacity(0.7),
                          height: 55.0,
                          width: size.width * 0.90,
                        ),
                        SizedBox(
                          height: 45.0,
                          width: size.width * 0.90,
                          child: RaisedButton(
                            onPressed: () {},
                            color: theme.primary,
                            child: FancyText(
                              text: "SUBMIT",
                              size: 16.0,
                              color: textDark_Yellow,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FancyText(
                          text: "Already have an account? ",
                          color: textDark_Yellow,
                          fontWeight: FontWeight.w600,
                          size: 14.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: FancyText(
                            text: "Sign In",
                            color: textLight_Red2,
                            fontWeight: FontWeight.w700,
                            size: 14.0,
                          ),
                        ),
                      ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}