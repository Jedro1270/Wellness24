import 'package:wellness24/models/emergency_contact.dart';
import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/models/user.dart';
import 'package:wellness24/services/database.dart';

class NewAccount {
  final auth = AuthService();
  String uid,
      role,
      email,
      password,
      contactNo,
      lastName,
      firstName,
      middleInitial,
      address,
      gender,
      specialization,
      licenseNo,
      clinicLocation,
      clinicStart,
      clinicEnd,
      workingDays,
      education,
      about;
  List<String> keywords;
  List<String> medicalHistory;
  EmergencyContact emergencyContact;
  DateTime birthDate;

  NewAccount(this.role);

  List<String> createKeywords(String name) {
    List<String> output = [];
    String temporaryName = '';

    name.split('').forEach((letter) {
      temporaryName += letter.toLowerCase();
      output.add(temporaryName);
    });

    return output;
  }

  void generateAllKeywords() {
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

  void supplyCredentials({String email, String password, String contactNo}) {
    this.email = email;
    this.password = password;
    this.contactNo = contactNo;
  }

  void supplyPersonalInfo(
      {String lastName,
      String firstName,
      String middleInitial,
      String gender,
      DateTime birthDate,
      String address}) {
    this.lastName = lastName;
    this.firstName = firstName;
    this.middleInitial = middleInitial;
    this.gender = gender;
    this.birthDate = birthDate;
    this.address = address;
  }

  void addEmergencyContact(EmergencyContact emergencyContact) {
    this.emergencyContact = emergencyContact;
  }

  Future<User> registerDoctor(
      {String licenseNo,
      String clinicLocation,
      String clinicStart,
      String clinicEnd,
      String specialization,
      String workingDays,
      String education,
      String about}) async {
    this.licenseNo = licenseNo;
    this.clinicLocation = clinicLocation;
    this.clinicStart = clinicStart;
    this.clinicEnd = clinicEnd;
    this.specialization = specialization;
    this.workingDays = workingDays;
    this.education = education;
    this.about = about;

    generateAllKeywords();

    User result =
        await auth.registerWithEmailAndPassword(this.email, this.password);

    this.uid = result.uid;
    await DatabaseService(uid: this.uid).insertRole(this.role);

    if (result != null) {
      this.uid = result.uid;
    }

    return result;
  }

  Future<User> registerPatient(List<String> medicalHistory) async {
    this.medicalHistory = medicalHistory;

    generateAllKeywords();

    User result =
        await auth.registerWithEmailAndPassword(this.email, this.password);

    this.uid = result.uid;
    await DatabaseService(uid: this.uid).insertRole(this.role);

    if (result != null) {
      this.uid = result.uid;
    }

    return result;
  }
}
