import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

import 'Widget/Forms.dart';
import 'core/atoms/AppBarW.dart';
import 'core/atoms/FancyText.dart';

class ResetPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _oldPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus1 = FocusNode();
  final FocusNode _newPasswordFocus2 = FocusNode();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBarW(
              title: "Reset Password",
              backButtonColor: textDark_Yellow,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: theme.primaryVariant,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: theme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: Container(
                    width: size.width,
                    color: theme.background,
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: FForms(
                            underline: false,

                            textInputAction: TextInputAction.next,
                            currentFocus: _oldPasswordFocus,
                            nextFocus: _newPasswordFocus1,
                            borderColor: blueGrey,
                            formColor: Colors.white,
                            text: "Old Password",
                            textColor: blueGrey.withOpacity(0.7),
                            width: size.width * 0.90,
                            validator: (val) =>
                                val.isEmpty ? 'Enter password' : null,
                            // onChanged: () {},
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: FForms(
                            textInputAction: TextInputAction.next,
                            currentFocus: _newPasswordFocus1,
                            nextFocus: _newPasswordFocus2,
                            borderColor: blueGrey,
                            formColor: Colors.white,
                            text: "New Password",
                            textColor: blueGrey.withOpacity(0.7),
                            width: size.width * 0.90,
                            validator: (val) =>
                                val.isEmpty ? 'Enter password' : null,
                            // onChanged: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: FForms(
                            textInputAction: TextInputAction.next,
                            currentFocus: _newPasswordFocus2,
                            borderColor: blueGrey,
                            formColor: Colors.white,
                            text: "New Password",
                            textColor: blueGrey.withOpacity(0.7),
                            width: size.width * 0.90,
                            validator: (val) =>
                                val.isEmpty ? 'Enter password' : null,
                            // onChanged: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 45.0,
                            child: RaisedButton(
                              color: theme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: FancyText(
                                text: "SUBMIT",
                                size: 16.0,
                                color: textDark_Yellow,
                                fontWeight: FontWeight.w600,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ]),
                    ),
                  )),
            )),
          )),
    );
  }
}