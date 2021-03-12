import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/services/database.dart';

class NewAccount {
  String uid;
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
  List<String> keywords;

  NewAccount(this.uid, this.email, this.contactNo, this.password, this.role);

  List<String> createKeywords(String name) {
    List<String> output = [];
    String temporaryName = '';

    name.split('').forEach((letter) {
      temporaryName += letter.toLowerCase();
      output.add(temporaryName);
    });

    return output;
  }

  List<String> generateAllKeywords() {
    List<String> keywordNameWithoutMiddleName =
        createKeywords('$firstName $lastName');
    List<String> keywordFullName =
        createKeywords('$firstName $middleInitial. $lastName');
    List<String> keywordLastNameFirst =
        createKeywords('$lastName, $firstName $middleInitial.');

    List<String> allKeywords =
        keywordNameWithoutMiddleName + keywordFullName + keywordLastNameFirst;

    this.keywords = allKeywords;
  }

  void supplyPersonalInfo(
      {String lastName,
      String firstName,
      String middleInitial,
      String gender,
      String birthDate,
      String address}) {
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
    generateAllKeywords();

    final database = DatabaseService(uid: this.uid);
    final auth = AuthService();

    dynamic result =
        await auth.registerWithEmailAndPassword(this.email, this.password);

    return result;
  }
}
