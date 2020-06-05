import 'package:chitwan_hospital/UI/pages/AppointmentPages/atoms/ListCard.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:flutter/material.dart';

class Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return ListView.builder(
          itemCount: NearYou.length,
          itemBuilder: (BuildContext context, int index) {
            return ListCard(
              name: NearYou[index]['name'],
              caption: NearYou[index]['cap'],
              image: NearYou[index]['src'],
              phone: NearYou[index]['phone'],
              status: NearYou[index]['status'],
              date: NearYou[index]['date'],
              time:NearYou[index]['time'],
            );
          },
    );
  }
}
