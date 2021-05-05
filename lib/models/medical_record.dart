class MedicalRecord {
  String id;
  String patientUid;
  String title;
  String imageUrl;
  String notes;
  DateTime lastEdited;

  MedicalRecord(
      {this.patientUid,
      this.id,
      this.title,
      this.imageUrl,
      this.notes,
      this.lastEdited});
}
