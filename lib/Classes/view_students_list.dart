import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ViewStudents extends StatelessWidget {
  final DocumentReference classRef;

  const ViewStudents({Key? key, required this.classRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: classRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No students found'));
          }
          final classData = snapshot.data!.data() as Map<String, dynamic>;
          final students = List<Map<String, dynamic>>.from(classData['students'] ?? []);

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(student['name'] ?? 'N/A'),
                  subtitle: Text(student['regNo'] ?? 'N/A'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.edit),
        tooltip: 'Edit Students',
      ),
    );
  }
}
