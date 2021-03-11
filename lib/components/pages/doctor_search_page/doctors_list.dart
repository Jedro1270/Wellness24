import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wellness24/components/pages/doctor_search_page/doctor_info.dart';

class DoctorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference doctors = Firestore.instance.collection('doctors');

    return ListView(
      children: <Widget>[
        SizedBox(height: 30),
        DoctorInfo(
            firstName: 'Elimjoyce', middleInitial: 'A', lastName: 'Abagat'),
        SizedBox(height: 20),
        DoctorInfo(firstName: 'Casey', middleInitial: 'C', lastName: 'Capacio'),
        SizedBox(height: 20),
        DoctorInfo(
            firstName: 'Jedro', middleInitial: 'E', lastName: 'Pagayonan')
      ],
    );
  }
}

// return StreamBuilder<QuerySnapshot>(
//       stream: doctors.snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Loading');
//         }

//         return ListView(
//           children: snapshot.data.documents.map((DocumentSnapshot document) {
//             return DoctorInfo(
//               firstName: document.data['firstName'],
//               middleInitial: document.data['middleInitial'],
//               lastName: document.data['lastName']
//             );
//           }).toList()
//         );

//         );
//       },
//     );
