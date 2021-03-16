import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_screen/doctor_profession_info.dart';
import 'package:wellness24/components/pages/patient_screen/patient_emergency_contact_info.dart';
import 'package:wellness24/models/new_account.dart';

class RegisterNextStep extends StatelessWidget {
  final NewAccount account;

  RegisterNextStep(this.account);

  @override
  Widget build(BuildContext context) {
    return account.role == 'Doctor'
        ? DoctorProfessionInfo(account)
        : EmergencyContactInfo(account);
  }
}
