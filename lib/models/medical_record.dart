class MedicalRecord {
  String patientUid;
  String title;
  String imageUrl;
  String notes;
  DateTime lastEdited;

  MedicalRecord(
      {this.patientUid,
      this.title,
      this.imageUrl,
      this.notes,
      this.lastEdited});
}
