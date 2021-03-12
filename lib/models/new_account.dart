import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellness24/services/auth_service.dart';

class NewAccount {
  String role;
  String email;
  String password;
  String contactNo;
  String lastName;
  String firstName;
  String middleInitial;
  String birthDate;
  String address;
  String gender;

  NewAccount(this.email, this.contactNo, this.password, this.role);

  void supplyPersonalInfo(
      {lastName, firstName, middleInitial, gender, birthDate, address}) {
    this.lastName = lastName;
    this.firstName = firstName;
    this.middleInitial = middleInitial;
    this.gender = gender;
    this.birthDate = birthDate;
    this.address = address;
  }

  dynamic registerDoctor(
      {licenseNo,
      clinicLocation,
      clinicStart,
      clinicEnd,
      specialization}) async {
    final auth = AuthService();
    dynamic result =
        await auth.registerWithEmailAndPassword(this.email, this.password);
    return result;
  }
}
