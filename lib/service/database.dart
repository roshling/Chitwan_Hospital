import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chitwan_hospital/service/extensions.dart';

abstract class DatabaseService {
  static const StoragePath = 'gs://chitwan-hospital.appspot.com';
  static final Firestore db = Firestore.instance;
  static final StorageReference storageReference =
      FirebaseStorage().ref().child(StoragePath);
  static final CollectionReference userCollection = db.collection('users');
  static final CollectionReference doctorCollection = db.collection('doctors');
  static final CollectionReference labCollection = db.collection('labs');
  static final CollectionReference bloodCollection = db.collection('bloods');
  static final CollectionReference promoCollection = db.collection('promos');
  static final CollectionReference appointmentCollection =
      db.collection('appointments');
  static final CollectionReference hospitalCollection =
      db.collection('hospitals');
  static final CollectionReference ambulanceCollection =
      db.collection('ambulances');
  static final CollectionReference pharmacyCollection =
      db.collection('pharmacies');
  static final CollectionReference pOrderCollection = db.collection('porders');
  static final CollectionReference labOrderCollection =
      db.collection('labOrders');
  static final CollectionReference messageCollection =
      db.collection('messages');
  static final CollectionReference inquiryCollection =
      db.collection('inquiries');
  static final CollectionReference favouritesCollection =
      db.collection('favourites');
  static final CollectionReference pcrCollection = db.collection('pcr');

  static Future updateUserData(String uid, Map<String, dynamic> data) async {
    return await userCollection.document(uid).setData(data, merge: true);
  }

  static Future<DocumentSnapshot> getUserData(String uid) async {
    return await userCollection.document(uid).get();
  }

  static Stream<QuerySnapshot> getUserByName(String name) {
    return userCollection.where('name', isEqualTo: name).snapshots();
  }

  static Future<DocumentSnapshot> getDoctorData(String uid) async {
    return await doctorCollection.document(uid).get();
  }

  static Future<DocumentSnapshot> getHospitalData(String uid) async {
    return await hospitalCollection.document(uid).get();
  }

  static Future<DocumentSnapshot> getPharmacyData(String uid) async {
    return await pharmacyCollection.document(uid).get();
  }

  static Future<DocumentSnapshot> getLabData(String uid) async {
    return await labCollection.document(uid).get();
  }

  static Future updateDoctorData(String uid, data) async {
    return await doctorCollection.document(uid).setData(data, merge: true);
  }

  static Future updateHospitalData(
      String uid, Map<String, dynamic> data) async {
    return await hospitalCollection.document(uid).setData(data, merge: true);
  }

  static Future updatePharmacyData(
      String uid, Map<String, dynamic> data) async {
    return await pharmacyCollection.document(uid).setData(data, merge: true);
  }

  static Future updateLabData(String uid, Map<String, dynamic> data) async {
    return await labCollection.document(uid).setData(data, merge: true);
  }

  static Future createAppointment(Map data) async {
    try {
      return await appointmentCollection.document().setData(data);
    } catch (e) {
      return 'error';
    }
  }

  static Future createPCRAppointment(Map data) async {
    try {
      return await pcrCollection.document().setData(data);
    } catch (e) {
      return 'error';
    }
  }

  static Stream<QuerySnapshot> getAppointments(String uid) {
    final result = appointmentCollection.where('userId', isEqualTo: uid);
    return result.snapshots();
  }

  static Future<DocumentSnapshot> getOneAppointment(String uid) {
    return appointmentCollection.document(uid).get();
  }

  static Stream<QuerySnapshot> getPCRAppointments(String uid) {
    final result = pcrCollection.where('userId', isEqualTo: uid);
    return result.snapshots();
  }

  static Future<DocumentSnapshot> getOnePCRAppointment(String uid) {
    return pcrCollection.document(uid).get();
  }

  static Stream<QuerySnapshot> getDoctors() {
    return doctorCollection.snapshots();
  }

  static Stream<QuerySnapshot> getPharmacies() {
    return pharmacyCollection.snapshots();
  }

  static Stream<QuerySnapshot> getLabs() {
    return labCollection.snapshots();
  }

  static Stream<QuerySnapshot> getDoctorAppointments(String uid) {
    final result = appointmentCollection.where('doctorId', isEqualTo: uid);
    return result.snapshots();
  }

  static Stream<QuerySnapshot> getPCRHospitalAppointments() =>
      pcrCollection.snapshots();

  static getDoctorsByHospital(String hospital) {
    return doctorCollection.where('hospital', isEqualTo: hospital);
  }

  static Future<bool> markDoctorVerified(String id) async {
    try {
      await doctorCollection.document(id).updateData({'isVerified': true});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateOrderStatus(String id, String status) async {
    try {
      await pOrderCollection.document(id).updateData({'status': status});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateOrderRemark(String id, String remark) async {
    try {
      await pOrderCollection.document(id).updateData({'remark': remark});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateLabOrderStatus(String id, String status) async {
    try {
      await labOrderCollection.document(id).updateData({'status': status});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateLabOrderFile(String id, String file) async {
    try {
      await labOrderCollection.document(id).updateData({'image': file});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateLabOrderRemark(String id, String remark) async {
    try {
      await labOrderCollection.document(id).updateData({'remark': remark});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<QuerySnapshot> getHospitals() {
    return hospitalCollection.snapshots();
  }

  static Future<bool> setAppointmentStatus(String uid, dynamic status) async {
    try {
      await appointmentCollection.document(uid).updateData({'status': status});
      print('done');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setPCRAppointmentStatus(
      String uid, dynamic status) async {
    try {
      await pcrCollection.document(uid).updateData({'status': status});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setDiagnosis(String uid, List data) async {
    try {
      await appointmentCollection.document(uid).updateData({'diagnosis': data});
      return true;
    } catch (e) {
      print('Error $e');
      return false;
    }
  }

  static Future<bool> createPharmacyOrder(Map<String, String> data) async {
    try {
      await pOrderCollection.document().setData(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteDoctor(String uid) async {
    try {
      await doctorCollection.document(uid).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<QuerySnapshot> getUserPharmacyOrders(String uid) {
    return pOrderCollection.where('userId', isEqualTo: uid).snapshots();
  }

  static Future<QuerySnapshot> getPharmacyOrders(String uid) {
    return pOrderCollection.where('pharmacyId', isEqualTo: uid).getDocuments();
  }

  static Future<bool> createLabOrder(Map<String, String> data) async {
    try {
      await labOrderCollection.document().setData(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Stream<QuerySnapshot> getLabOrders(String uid) {
    return labOrderCollection.where('labId', isEqualTo: uid).snapshots();
  }

  static Stream<QuerySnapshot> getUserLabOrders(String uid) {
    return labOrderCollection.where('uid', isEqualTo: uid).snapshots();
  }

  static Stream<QuerySnapshot> getMessagesUser(String uid) {
    return messageCollection.where('uid', isEqualTo: uid).snapshots();
  }

  static Stream<QuerySnapshot> getMessagesDoctor(String uid) {
    return messageCollection.where('docId', isEqualTo: uid).snapshots();
  }

  static Stream<DocumentSnapshot> getMessages(String documentId) {
    return messageCollection.document(documentId).snapshots();
  }

  static Future<QuerySnapshot> createMessageDocument(
      String userId, String docId, String userName, String docName) async {
    await messageCollection.document().setData({
      'uid': userId,
      'docId': docId,
      'user': userName,
      'doctor': docName,
      'conversations': []
    });
    return messageCollection
        .where('docId', isEqualTo: docId)
        .where('uid', isEqualTo: userId)
        .getDocuments();
  }

  static Future<void> updateMessages(String uid, Map data) {
    return messageCollection.document(uid).updateData({
      'conversations': FieldValue.arrayUnion([data])
    });
  }

  static StorageUploadTask uploadFile(File file, String uid) {
    final fileRef = storageReference.child(uid).child(file.basename);
    final StorageUploadTask uploadTask = fileRef.putFile(file);
    return uploadTask;
  }

  static Future<void> createPromotion(Map<String, dynamic> data) {
    return promoCollection.document().setData(data);
  }

  static Future<void> archivePromotion(String documentId) {
    return promoCollection.document(documentId).updateData({
      'isArchived': true,
    });
  }

  static Stream<QuerySnapshot> getPromotions(String hospitalId) {
    return promoCollection
        .where('hospitalId', isEqualTo: hospitalId)
        .snapshots();
  }

  static Stream<QuerySnapshot> getPromotionsForUser() {
    return promoCollection.where('isArchived', isEqualTo: false).snapshots();
  }

  static Future<void> createInquiry(Map<String, String> data) {
    return inquiryCollection.document().setData(data);
  }

  static Future<void> updateInquiryAnswer(String documentId, String answer) {
    return inquiryCollection
        .document(documentId)
        .updateData({'answer': answer});
  }

  static Stream<QuerySnapshot> getInquiries(String userId) {
    return inquiryCollection.where('userId', isEqualTo: userId).snapshots();
  }

  static Stream<QuerySnapshot> getInquiriesForHospital(String hospitalId) {
    return inquiryCollection
        .where('hospitalId', isEqualTo: hospitalId)
        .snapshots();
  }

  static Future<void> createFavourite(Map<String, String> data) {
    return favouritesCollection.document().setData(data);
  }

  static Stream<QuerySnapshot> getFavourites(String userId) {
    return favouritesCollection.where('userId', isEqualTo: userId).snapshots();
  }

  static Future<void> deleteFavourite(String documentId) {
    return favouritesCollection.document(documentId).delete();
  }
}
