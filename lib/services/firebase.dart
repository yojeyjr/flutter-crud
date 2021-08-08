import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> createStudent({name,email,password,city}) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('students');
    await users.add({
      'name': name,
      'email': email,
      'password': password,
      'city': city,
    });
    print("saved");
    return true;
  } catch (e) {
    print("not saved");
    return false;
  }
}