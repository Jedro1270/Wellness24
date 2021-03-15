import 'package:wellness24/services/auth_service.dart';
import 'package:wellness24/models/user.dart';

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
  String specialization;
  String licenseNo;
  String clinicLocation;
  String clinicStart;
  String clinicEnd;
  List<String> keywords;

  NewAccount(this.email, this.contactNo, this.password, this.role);

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

  Future<User> registerDoctor(
      {String licenseNo,
      String clinicLocation,
      String clinicStart,
      String clinicEnd,
      String specialization}) async {
    this.licenseNo = licenseNo;
    this.clinicLocation = clinicLocation;
    this.clinicStart = clinicStart;
    this.clinicEnd = clinicEnd;
    this.specialization = specialization;

    generateAllKeywords();

    final auth = AuthService();

    User result =
        await auth.registerWithEmailAndPassword(this.email, this.password);

    this.uid = result.uid;

    return result;
  }
}
