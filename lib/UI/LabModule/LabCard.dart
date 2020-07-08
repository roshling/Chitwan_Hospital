import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:flutter/material.dart';

class LabCard extends StatelessWidget {
  final String name, email, phone;
  const LabCard({Key key, this.name, this.email, this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
                color: Colors.white60,
                //offset: Offset(-4, -4),
                blurRadius: 3.0,
                spreadRadius: -12.0),
            BoxShadow(
                color: Colors.white60, offset: Offset(-4, -4), blurRadius: 3.0),
            BoxShadow(
                color: Colors.white60, offset: Offset(-4, -4), blurRadius: 3.0),
            BoxShadow(
              color: Color(0xffffffff),
              offset: Offset(-.9, -.9),
            ),
            BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                offset: Offset(4, 4),
                blurRadius: 3.0),
            BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                offset: Offset(.9, .9),
                blurRadius: 1.0),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.95,
        height: 160.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: CircleAvatar(
                  backgroundColor: theme.colorScheme.background,
                  backgroundImage: ExactAssetImage("assets/images/doctor.png"),
                  maxRadius: 45.0,
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FancyText(
                        text: name,
                        fontWeight: FontWeight.w700,
                        size: 15.5,
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: FancyText(
                            text: email,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              size: 16.0,
                              color: theme.colorScheme.primary,
                            ),
                            FancyText(
                              text: '  ' + phone,
                              textAlign: TextAlign.left,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        // Text(),
        );
  }
}