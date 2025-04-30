import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService
{

  //collection refrence
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');  
  
  Future updateUserData(String email, String firstname, String lastname, String phone, String password) async {
     {
    return await productCollection.add({
      'first_name': firstname,
      'last_name': lastname,
      'phone': phone,
      'password': password,
      'email': email,
    });
  }
}
}