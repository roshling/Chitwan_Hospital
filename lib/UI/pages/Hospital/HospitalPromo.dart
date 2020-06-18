import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

class HospitalPromo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 8.0, left: 8.0, right: 8.0, bottom: 10.0),
          child: Container(
            width: size.width * 0.60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: theme.primary,
              boxShadow: [
                BoxShadow(
                    color: Colors.white60,
                    offset: Offset(-4, -4),
                    blurRadius: 3.0),
                BoxShadow(
                  color: Color(0xffffffff),
                  offset: Offset(-.9, -.9),
                ),
                BoxShadow(
                    color: theme.primary.withOpacity(0.3),
                    offset: Offset(4, 4),
                    blurRadius: 3.0),
                BoxShadow(
                    color: theme.primary.withOpacity(0.3),
                    offset: Offset(.9, .9),
                    blurRadius: 1.0),
              ],
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/img5.jpeg",
                  fit: BoxFit.fill,
                  width: size.width * 0.60,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.black26)),
                FancyText(
                  letterSpacing: 1.0,
                    text: "Promotions",
                    color: textDark_Yellow,
                    size: 17.0,
                    fontWeight: FontWeight.w600)
              ],
            ),
          ),
        );
      },
    );
  }
}