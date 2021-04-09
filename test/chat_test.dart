// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:wellness24/components/pages/common_pages/chat/chat_bubble.dart';
// import 'package:wellness24/components/pages/common_pages/chat/chat_room.dart';
// import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
// import 'package:wellness24/models/message.dart';
// import 'package:wellness24/services/database.dart';

void main() {
  // test('Chat .uploadMessage should upload message to firestore', () async {
  //   MockFirestoreInstance instance = MockFirestoreInstance();
  //   String uid = '123';
  //   DatabaseService database = DatabaseService(uid: uid, firestore: instance);

  //   String content = 'test';
  //   String receiverUid = '456';
  //   String senderUid = uid;

  //   await database.uploadMessage(content, receiverUid, senderUid);

  //   DocumentSnapshot snapshot =
  //       await instance.collection('messages').document(uid).get();
  //   String uploadedContent = snapshot.data['content'];
  //   String uploadedReceiverUid = snapshot.data['receiverUid'];
  //   String uploadedSenderUid = snapshot.data['senderUid'];

  //   print(content);
  //   print(snapshot.data['content']);
  //   expect(uploadedContent, content);
  //   expect(uploadedReceiverUid, receiverUid);
  //   expect(uploadedSenderUid, senderUid);
  // });

//   // QuerySnapshot snapshot = await database.messages.getDocuments();
//   // List messages = snapshot.documents.toList();
//   // print(snapshot.documents.toString());
//   // messages.forEach((document) {
//   //   print(messages)s;
//   // });

//   // print(snapshot.documents);
//   // snapshot.documents.forEach((document) {

//   //   print(document.data);
//   // });

//   // String insertedSenderUid = snapshot.data['senderUid'];
//   // String insertedReceiverUid = snapshot.data['receiverUid'];
//   // String insertedContent = snapshot.data['content'];

//   // expect(insertedSenderUid, '123');
//   // expect(insertedReceiverUid, '678');
//   // expect(insertedContent, 'test');
//   //});
}

// TestWidget

/* testWidgets('chat should show message on screen when send icon is pressed',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        home: ChatRoom(),
      ));

      final textFieldFinder = find.byKey(Key('textFieldKey'));

      await tester.tap(textFieldFinder);
      await tester.pump();

      final sendBtnFinder = find.byKey(Key('SendBtn'));

      await tester.tap(sendBtnFinder);
      await tester.pump();

      // final messagesFinder = find.byKey(Key('Message'));
      // await tester.tap(messagesFinder);
      // await tester.pump();
      // expect(messagesFinder, findsOneWidget);
    });
  });
*/
