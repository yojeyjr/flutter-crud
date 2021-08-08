import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/crud/details_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key, required this.studentId}) : super(key: key);

  final String studentId;

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  CollectionReference students = FirebaseFirestore.instance.collection('students');

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _cityController = new TextEditingController();

  String get _name => _nameController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _city => _cityController.text;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('students');
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Update Employee"
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.studentId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            _nameController.text = data["name"];
            _emailController.text = data["email"];
            _passwordController.text = data["password"];
            _cityController.text = data["city"];
            return Card(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'John cena',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'test@test.com',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () => updateStudent( context, students, widget.studentId),
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

  _goToDetailsPage(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> updateStudent(BuildContext context, students, studentId) async {
    if (_name.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty &&
        _city.isNotEmpty) {
      return students
          .doc(studentId)
          .update({
            'name': _name,
            'email': _email,
            'password': _password,
            'city': _city,
          })
          .then((value) => _goToDetailsPage(context))
          .catchError((error) => print("Failed to update user: $error")
      );
    } else {
      return _openErrorPopup(context);
    }
  }

  void _updateState() {
    setState(() {});
  }

  _openErrorPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Failed'),
          content: Text("Fill all the Fields"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
