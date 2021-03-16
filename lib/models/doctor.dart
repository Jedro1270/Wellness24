class Doctor {
  String firstName;
  String middleInitial;
  String lastName;
  String specialization;
  String about;
  String workingDays;
  String clinicStartHour;
  String clinicEndHour;

  Doctor(
      {this.firstName,
      this.middleInitial,
      this.lastName,
      this.specialization,
      this.about,
      this.workingDays,
      this.clinicStartHour,
      this.clinicEndHour});

  String get fullname {
    return '$firstName $middleInitial. $lastName';
  }
}
