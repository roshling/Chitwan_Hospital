import 'package:chitwan_hospital/UI/DoctorsModule/PatientListCard.dart';
import 'package:chitwan_hospital/state/doctor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DRejected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<DoctorDataStore>(context)
        .appointments
        .where((element) => element['status'] == 'rejected')
        .toList();
    return ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (BuildContext context, int index) {
          return PatientListCard(id: appointments[index]['id']);
        });
  }
}
