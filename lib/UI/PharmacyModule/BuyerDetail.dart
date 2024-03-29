import 'package:chitwan_hospital/UI/PharmacyModule/PhotoFullScreen.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/RejectRemarkform.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/models/PharmacyAppointment.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class BuyerDetail extends StatefulWidget {
  final buyerName;
  final buyerPhone;
  final status;
  final time;
  final id;
  BuyerDetail(
      {this.buyerName, this.buyerPhone, this.status, this.time, this.id});

  @override
  _BuyerDetailState createState() => _BuyerDetailState();
}

class _BuyerDetailState extends State<BuyerDetail> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final pharmacyDataStore = Provider.of<PharmacyDataStore>(context);
    final PharmacyAppointment order = pharmacyDataStore.getOneOrder(widget.id);
    final DateTime date = DateTime.parse(order.timestamp);

    List<Widget> buildMedicineList() {
      final elements = order.medicine.split(';');
      elements.removeWhere((element) => element.length == 0);
      return elements
          .map<Widget>(
            (e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: FancyText(
                text: e,
                size: 16.0,
              ),
            ),
          )
          .toList();
    }

    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            titleColor: theme.primary,
            title: "Buyer Details",
          ),
          preferredSize: Size.fromHeight(60.0)),
      backgroundColor: theme.background,
      floatingActionButton:
          order.status == "accepted" || order.status == "ready"
              ? FloatingActionButton.extended(
                  onPressed: isActive
                      ? null
                      : () {
                          if (order.status != 'ready') {
                            setState(() {
                              isActive = true;
                            });
                            pharmacyDataStore
                                .setOrderStatus(order.id, 'ready')
                                .then((value) => setState(() {
                                      isActive = false;
                                    }));
                          } else {
                            setState(() {
                              isActive = true;
                            });
                            pharmacyDataStore
                                .setOrderStatus(order.id, 'accepted')
                                .then((value) => setState(() {
                                      isActive = false;
                                    }));
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => PharmacyReady(
                          //             // appointment: newAppointment,
                          //             )));
                        },
                  icon: Icon(
                    Icons.calendar_today,
                    color: textDark_Yellow,
                  ),
                  label: FancyText(
                    text: order.status == "ready" ? 'Undo Ready' : "Mark Ready",
                    color: textDark_Yellow,
                    fontWeight: FontWeight.w600,
                  ),
                  backgroundColor: theme.primary,
                )
              : null,
      body: ListView(children: <Widget>[
        BoolIndicator(isActive),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 8.0),
          child: Center(
            child: Container(
                height: 180.0,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: gradientColor,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: theme.background,
                            backgroundImage: ExactAssetImage(
                              'assets/images/doctor.png',
                            ),
                          )),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                    FancyText(
                                      color: Colors.white,
                                      text:
                                          ' ${date.year}-${date.month}-${date.day}',
                                    ),
                                  ],
                                ),
                              ),
                              FancyText(
                                text: widget.buyerName,
                                fontWeight: FontWeight.w700,
                                size: 15.5,
                                textAlign: TextAlign.left,
                                color: textDark_Yellow,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 3.0,
                                  bottom: 3.0,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.phone,
                                        size: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    FancyText(
                                      text: widget.buyerPhone,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FancyText(
                                      text: "Current Status: ",
                                      textAlign: TextAlign.left,
                                      color: textDark_Yellow,
                                    ),
                                    order.status == null
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ActionChip(
                                                label: FancyText(
                                                  text: "Accept",
                                                  size: 14.0,
                                                ),
                                                backgroundColor:
                                                    Colors.green.shade400,
                                                onPressed: isActive
                                                    ? () {}
                                                    : () {
                                                        setState(() {
                                                          isActive = true;
                                                        });
                                                        pharmacyDataStore
                                                            .setOrderStatus(
                                                                order.id,
                                                                'accepted')
                                                            .then((value) =>
                                                                setState(() {
                                                                  isActive =
                                                                      false;
                                                                }));
                                                      },
                                              ),
                                              SizedBox(width: 10.0),
                                              ActionChip(
                                                label: FancyText(
                                                  text: "Reject ",
                                                  size: 14.0,
                                                  wordSpacing: 1.2,
                                                ),
                                                backgroundColor: theme.secondary
                                                    .withOpacity(0.6),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: FancyText(
                                                              text:
                                                                  "Are you sure?",
                                                              size: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: blueGrey),
                                                          content: FancyText(
                                                              text:
                                                                  "Are you sure you want to reject buyer request?",
                                                              size: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: blueGrey),
                                                          actions: <Widget>[
                                                            InkWell(
                                                                child: FancyText(
                                                                    text:
                                                                        "Cancel",
                                                                    color: theme
                                                                        .secondary),
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                            SizedBox(
                                                                width: 4.0),
                                                            ActionChip(
                                                                label:
                                                                    FancyText(
                                                                  text:
                                                                      "Reject",
                                                                  color:
                                                                      textDark_Yellow,
                                                                ),
                                                                backgroundColor:
                                                                    Colors.green
                                                                        .shade400,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    isActive =
                                                                        true;
                                                                  });
                                                                  pharmacyDataStore
                                                                      .setOrderStatus(
                                                                          order
                                                                              .id,
                                                                          'rejected')
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      isActive =
                                                                          false;
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                RejectRemarkForm(id: order.id),
                                                                      ),
                                                                    );
                                                                  });
                                                                }),
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                              SizedBox(width: 10.0),
                                            ],
                                          )
                                        : order.status == "rejected"
                                            ? Row(children: [
                                                FancyText(
                                                  text: "Rejected",
                                                  color: theme.secondary,
                                                  fontWeight: FontWeight.w700,
                                                  size: 15.5,
                                                ),
                                                SizedBox(width: 10.0),
                                                InkWell(
                                                  onTap: isActive
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            isActive = true;
                                                          });
                                                          pharmacyDataStore
                                                              .setOrderStatus(
                                                                  order.id,
                                                                  null)
                                                              .then((value) =>
                                                                  setState(() {
                                                                    isActive =
                                                                        false;
                                                                  }));
                                                        },
                                                  child: FancyText(
                                                    text: "undo",
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.red[200],
                                                    color: Colors.red[200],
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ])
                                            : Row(
                                                children: <Widget>[
                                                  FancyText(
                                                    text:
                                                        order.status == 'ready'
                                                            ? 'Ready'
                                                            : "Accepted",
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w700,
                                                    size: 15.5,
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  order.status == 'ready'
                                                      ? SizedBox.shrink()
                                                      : InkWell(
                                                          onTap: isActive
                                                              ? null
                                                              : () {
                                                                  setState(() {
                                                                    isActive =
                                                                        true;
                                                                  });
                                                                  pharmacyDataStore
                                                                      .setOrderStatus(
                                                                          order
                                                                              .id,
                                                                          null)
                                                                      .then((value) =>
                                                                          setState(
                                                                              () {
                                                                            isActive =
                                                                                false;
                                                                          }));
                                                                },
                                                          child: FancyText(
                                                            text: "undo",
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationColor:
                                                                Colors.red[200],
                                                            color:
                                                                Colors.red[200],
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                ],
                                              ),
                                  ],
                                ),
                              ),
                              order.status == 'rejected'
                                  ? RowInput(
                                      title: "Remark:  ",
                                      caption: order.remark ?? '',
                                      titleColor: textDark_Yellow,
                                      capColor: textDark_Yellow,
                                      defaultStyle: false,
                                    )
                                  : Text(''),
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
        ),
        order.medicine != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 18.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FancyText(
                          text: "Medicine  ",
                          fontWeight: FontWeight.bold,
                          size: 16.0),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 6.0),
                        child: Column(
                          children: buildMedicineList(),
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      )
                    ]),
              )
            : SizedBox.shrink(),
        if (order.image != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 12),
                child: FancyText(
                    text: 'Medicine Receipt',
                    fontWeight: FontWeight.bold,
                    size: 16.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 200.0,
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: PhotoView.customChild(
                    child: InkWell(
                      child: Image.network(order.image),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PhotoFullScreen(
                                  image: order.image,
                                )));
                      },
                    ),
                    backgroundDecoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
      ]),
    );
  }
}
