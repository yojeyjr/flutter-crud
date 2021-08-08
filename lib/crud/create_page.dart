import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/crud/details_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  CollectionReference students = FirebaseFirestore.instance.collection('students');

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Employee"
        ),
      ),
      body: SingleChildScrollView(
        child: _buildCreateDetails(context),
      ),
    );
  }

  _buildCreateDetails(BuildContext context) {

    bool isAllFieldFilled = _nameController.text.isNotEmpty &&
    _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty
    && _cityController.text.isNotEmpty;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
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
                      onChanged:(_) { _updateState(); },
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'test@test.com',
                      ),
                      onChanged:(_) { _updateState(); },
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      onChanged:(_) { _updateState(); },
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                      ),
                      onChanged:(_) { _updateState(); },
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () => isAllFieldFilled ? addStudent(context) : _openErrorPopup(context),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _goToDetailsPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute( builder: (context) => DetailsPage(), ),);
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _cityController.clear();
  }

  Future<void> addStudent(BuildContext context) async {
    return students.add({
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'city': _cityController.text,
    }).then( (value) =>
      _goToDetailsPage(context)
    )
    .catchError( (error) => _openErrorPopup(context) );
  }

  void _updateState() {
    setState(() {});
  }

  _openErrorPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Create Failed"),
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
