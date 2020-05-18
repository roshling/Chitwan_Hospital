import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/SubsPage/Subscription/AppointmentDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeListCard extends StatefulWidget {
  final name;
  final image;
  final caption;
  final phone;
  final status;
  final date;
  final time;
  final take;
  final data;
  HomeListCard(
      {this.image,
      this.name,
      this.caption,
      this.phone,
      this.date,
      this.status,
      this.time,
      this.take,
      this.data = false});

  @override
  _HomeListCardState createState() => _HomeListCardState();
}

class _HomeListCardState extends State<HomeListCard>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inHours % 60).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
  }

  timer(controller) {
    // if(controller.value == 0.0){
    //   controller.stop();
    // }
    // else{
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppointmentDetail(
                    name: widget.name,
                    caption: widget.caption,
                    image: widget.image,
                    phone: widget.phone,
                    status: widget.status,
                    date: widget.date,
                    time: widget.time,
                  )));
        },
        child: Container(
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
                    color: Colors.white60,
                    offset: Offset(-4, -4),
                    blurRadius: 3.0),
                BoxShadow(
                    color: Colors.white60,
                    offset: Offset(-4, -4),
                    blurRadius: 3.0),
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
            width: size.width * 0.90,
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
                      backgroundImage:
                          ExactAssetImage("assets/images/doctor.png"),
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
                            text: widget.name,
                            fontWeight: FontWeight.w700,
                            size: 15.5,
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                  text: "Department: ",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                    text: widget.caption,
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: FancyText(
                                  text: "Hospital: ",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: FancyText(
                                    text: "CMC Hospital",
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
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
                                  text: "  ${widget.phone}",
                                  textAlign: TextAlign.left,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                            child: RaisedButton(
                              onPressed: () {},
                              color: theme.colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: FancyText(
                                text: "Book Appointment",
                                size: 15.0,
                                color: textDark_Yellow,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
            // Text(),
            ),
      ),
    );
  }
}