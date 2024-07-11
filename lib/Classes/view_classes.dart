import 'package:cli/Attendance/AttendanceScreen.dart';
import 'package:cli/face_recogination/faceRecognitionScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewClasses extends StatelessWidget {
  const ViewClasses({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Classes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('classes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No classes found'));
          }
          final classDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: classDocs.length,
            itemBuilder: (context, index) {
              final classData = classDocs[index].data() as Map<String, dynamic>;
              final className = classData['className'] ?? 'N/A';
              final courseCode = classData['courseCode'] ?? 'N/A';

              return Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        className,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Course Code: $courseCode'),
                    ),
                    ButtonBar(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>FaceRecognition(type: "asw",classId:classDocs[index].id)));
                            // Add your action here
                          },
                          child: Text('Mark Attendance'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceScreen(classId: classDocs[index].id)));
                            // Add your action here
                          },
                          child: Text('View Attendance List'),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            //_addStudent
                            Navigator.push(context, MaterialPageRoute(builder: (_){
                              return FaceRecognition(type: "addNew", classId:classDocs[index].id);
                            }));
                          },
                          child: Text('Add Student'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );

        },
      ),
    );
  }
}
