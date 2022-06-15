class JournalEntryModel {
  String? emailid;
  DateTime? day;
  String? entry;

  JournalEntryModel(String e, DateTime now, String entry) {
    this.emailid = e;
    this.day = now;
    this.entry = entry;
  }
}
