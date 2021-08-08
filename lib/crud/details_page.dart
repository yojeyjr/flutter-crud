import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/crud/update_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  String noData = "no data found";

  CollectionReference students = FirebaseFirestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Employee Details"
        ),
      ),
      body: StreamBuilder(
        stream: students.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              if (streamSnapshot.data!.docs.length == 0) {
                return Center(child: Text('Details Not found'));
              }
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                    final studentId = documentSnapshot.id;
                    return Card(
                      color: Colors.grey[100],
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(
                          Icons.verified,
                          color: Colors.green,
                        ),
                        title: Text(documentSnapshot['name']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              // Press this button to edit a single product
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.indigo,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (context) =>
                                              UpdatePage(studentId: studentId)
                                      )
                                  );
                                },
                              ),
                              // This icon button is used to delete a single product
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  deleteStudent(
                                      documentSnapshot.id,
                                      documentSnapshot['name']);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
            return SpinKitFadingCircle(
              color: Colors.indigo,
              size: 50.0,
            );
        },
      ),
    );
  }

  Future<void> deleteStudent(id, name) {
    return students
        .doc(id)
        .delete()
        .then((value) => _updateNotification(name) )
        .catchError((error) => print("Failed to delete user: $error"));
  }

  _updateNotification(name) {
    final snackBar = SnackBar(
      content: Text(
        "$name has been deleted",
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      backgroundColor: Colors.pinkAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
