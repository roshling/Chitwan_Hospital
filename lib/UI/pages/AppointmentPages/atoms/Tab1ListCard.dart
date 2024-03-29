import 'package:chitwan_hospital/UI/core/atoms/EPanel.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Tab1ListCard extends StatelessWidget {
  final name;
  final image;
  final caption;
  final Widget items;
  Tab1ListCard({this.image, this.name, this.caption, this.items});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 5.0),
      child: Container(
        //height: size.height * 0.25,
        width: size.width * 0.90,
        decoration: BoxDecoration(
            color: theme.colorScheme.onBackground,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(color: theme.colorScheme.onBackground.withOpacity(0.5), offset: Offset(2, 3)),
              BoxShadow(color: theme.colorScheme.onBackground.withOpacity(0.4), offset: Offset(-1, -1))
            ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 4.0),
                  child: Image.asset(
                    image,
                    alignment: Alignment.topLeft,
                    fit: BoxFit.cover,
                    height: size.height * 0.15,
                    width: size.width * 0.40,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16.0, left: 10.0, right: 2.0),
                  color: theme.colorScheme.onBackground,// Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FancyText(
                        defaultStyle: true,
                        text: "$name",
                        size: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          children: <Widget>[
                            FancyText(
                              defaultStyle: true,
                              text: "Open Hours:  ",
                              size: 14.0,
                              opacity: 0.4,
                              fontWeight: FontWeight.w500,
                            ),
                            FancyText(
                              defaultStyle: true,
                              text: "9 AM to 7 PM",
                              size: 15.0,
                              opacity: 0.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: FancyText(
                          defaultStyle: true,
                          text: "Key Services: ",
                          size: 14.0,
                          opacity: 0.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 2.0),
                        child: Container(
                          width: size.width * 0.55,
                          child: FancyText(
                            defaultStyle: true,
                            text: "Baking Training, Custom cakes",
                            size: 15.0,
                            textAlign: TextAlign.start,
                            opacity: 0.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            EPanel(
              [
                ListItem(
                     //title:Icon(CupertinoIcons.tags_solid, color: theme.colorScheme.secondary, size: 20,),
                    subtitle: "Available Offers",
                    bodyBuilder: (context) => Column(
                          children: items == null
                              ? <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, bottom: 20.0,),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          CupertinoIcons.circle_filled,
                                          color: theme.colorScheme.secondary,
                                          size: 15,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left:10.0),
                                          width: size.width * 0.85,
                                          child: FancyText(
                                            defaultStyle: true,
                                            textAlign: TextAlign.left,
                                            text:
                                                '5% Off when booking an appointment from Service App',
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          CupertinoIcons.circle_filled,
                                          color: theme.colorScheme.secondary,
                                          size: 15,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left:10.0),
                                          width: size.width * 0.85,
                                          child: FancyText(
                                            defaultStyle: true,
                                            textAlign: TextAlign.justify,
                                            text:
                                                '\$5 cash back once appointment is complete',
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  )
                                ]
                              : items,
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
