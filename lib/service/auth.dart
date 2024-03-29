import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';

abstract class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<FirebaseUser> get user {
    try {
      return _auth.onAuthStateChanged;
    } catch (e) {
      return null;
    }
  }

  static Future<String> getCurrentUID() async {
    try {
      final currentUser = await _auth.currentUser();
      if (currentUser != null) {
        return currentUser.uid;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }

  static Future resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  // Sign In with email and password
  static Future signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // signup with email and password
  static Future registerWithEmailAndPassword(
      String email, String password, String name, String phone) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'phone': phone,
        'role': 'user',
      };

      await DatabaseService.updateUserData(user.uid, userData);
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future updateUserName(String name, FirebaseUser currentUser) async {
    final userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  // signup with email and password
  static Future registerDoctor(
      {String email,
      String password,
      String name,
      String phone,
      String hospital}) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      await DatabaseService.updateDoctorData(user.uid, {
        'phone': phone,
        'role': 'doctor',
        'isVerified': false,
        'name': name,
        'email': email
      });
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// signup with email and password
  static Future registerHospital({
    String email,
    String password,
    String name,
    String phone,
  }) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      await DatabaseService.updateHospitalData(user.uid, {
        'phone': phone,
        'role': 'hospital',
        'name': name,
        'isVerified': false,
        'email': email
      });
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future registerPharmacy({
    String email,
    String password,
    String name,
    String phone,
  }) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      await DatabaseService.updatePharmacyData(user.uid, {
        'phone': phone,
        'role': 'pharmacy',
        'name': name,
        'isVerified': false,
        'email': email
      });
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future registerLab({
    String email,
    String password,
    String name,
    String phone,
  }) async {
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;
      await DatabaseService.updateLabData(user.uid, {
        'phone': phone,
        'role': 'lab',
        'name': name,
        'isVerified': false,
        'email': email
      });
      await updateUserName(name, user);
      return user.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  static Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
