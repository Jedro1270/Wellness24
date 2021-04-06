class Message {
  String content;
  DateTime dateCreated;

  String receiverUid;
  String senderUid;

  Message({this.content, this.dateCreated, this.receiverUid, this.senderUid});
}
