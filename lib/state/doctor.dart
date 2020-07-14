import 'package:chitwan_hospital/service/auth.dart';
import 'package:chitwan_hospital/service/database.dart';
import 'package:chitwan_hospital/state/app.dart';
import 'package:flutter/cupertino.dart';

class DoctorDataStore extends ChangeNotifier {
  handleInitialProfileLoad() {
    try {
      if (user == null) {
        final auth = AuthService();
        print('Bootstrapping data store\n');
        auth.getCurrentUID().then((value) {
          print('value $value');
          if (value != null) {
            DatabaseService.getDoctorData(value).then((userData) {
              if (userData.data != null) {
                user = userData.data;
                uid = value;
                type = userData.data['role'];
                getAppointments();
              }
            }).catchError((err) {
              print(err);
            });
          }
        });
      }
    } catch (e) {}
  }

  String _id;
  String _userType;
  Map<String, dynamic> _userData;
  List hospitals;
  List<Map> _appointments;

  get uid => _id;

  set uid(userId) {
    _id = userId;
    notifyListeners();
  }

  get type => _userType;

  set type(userType) {
    _userType = userType;
  }

  get user => _userData;

  set user(newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  List<Map> get appointments => _appointments;

  set appointments(newUserData) {
    _appointments = newUserData;
    notifyListeners();
  }

  fetchUserData() {
    if (uid != null && type != null) {
      if (type == 'user') {
        DatabaseService.getUserData(uid).then((value) {
          if (value.data != null) {
            user = value.data;
          }
        }).catchError((err) {
          print(err);
        });
      }
    }
  }

  Future<bool> update(data) async {
    try {
      await DatabaseService.updateDoctorData(uid, data);
      _userData.addAll(data);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getHospitals() {
    if (hospitals == null)
      DatabaseService.getHospitals().listen((onData) {
        List newData = onData.documents.map<Map>((e) => e.data).toList();
        hospitals = newData;
      });
  }

  getAppointments() {
    if (appointments == null) {
      DatabaseService.getDoctorAppointments(uid).listen((onData) {
        List newData = onData.documents.map<Map>((e) {
          final data = e.data;
          data['id'] = e.documentID;
          return data;
        }).toList();
        appointments = newData;
      });
    }
  }

  Future<bool> setAppointmentStatus(String uid, dynamic status) async {
    bool value = await DatabaseService.setAppointmentStatus(uid, status);
    if (value) {
      final newAppointments = _appointments.map<Map>((each) {
        if (each['id'] == uid) {
          final data = each;
          data['status'] = status;
          return data;
        }
        return each;
      }).toList();
      appointments = newAppointments;
    }
    return value;
  }

  Future<bool> setDiagnosis(String uid, List data) async {
    try {
      bool result = await DatabaseService.setDiagnosis(uid, data);
      final newAppointments = _appointments.map<Map>((e) {
        if (e['id'] == uid) {
          final newData = e;
          newData['diagnosis'] = data;
          return newData;
        }
        return e;
      }).toList();
      appointments = newAppointments;
      return result;
    } catch (e) {
      return false;
    }
  }

  clearState() {
    _id = null;
    _userData = null;
    _userType = null;
    setLocalUserData('userType', null);
    // _hospitals = null;
    notifyListeners();
  }
}
