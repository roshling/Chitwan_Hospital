import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/pages/Pharmacy/PharmacyListCard.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PharmacyTab extends StatelessWidget {
  final isOrder;
  PharmacyTab({this.isOrder});

  @override
  Widget build(BuildContext context) {
    final userDataStore = Provider.of<UserDataStore>(context);
    final pharmacies = userDataStore.pharmacies;
    if (pharmacies == null || pharmacies.length == 0) {
      userDataStore.getPharmacies();
    }
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "All Pharmacies",
              titleColor: Theme.of(context).colorScheme.primary,
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView.builder(
            itemCount: pharmacies != null ? pharmacies.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return PharmacyListCard(
                pharmacyName: pharmacies[index]['name'],
                pharmacyLocation:
                    pharmacies[index]['address'] ?? 'Not available',
                // image:
                //     pharmacies[index]['imageUrl'] ?? ,
                phone: pharmacies[index]['phone'],
                openHours: pharmacies[index]['openHours'] ?? 'Not available',
                id: pharmacies[index]['id'],
                isOrder: isOrder,
              );
            }));
  }
}
