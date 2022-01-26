
import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  final CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<void> initiateUser(String userId) async
  {
    await users.doc(userId).set(
      {
        'name': null,
        'sex': null,
        'age': null,
        'length': null,
        'weight': null
      }
    );
  }
  Future<bool> doesUserExist(String userId) async {
    DocumentSnapshot ds = await users.doc(userId).get();
    return ds.exists;
  }
  Future<void> setName(String userId, String name) async{
    await users.doc(userId).update(
      {
        'name': name
      }
    );
  }
  Future<void> setSex(String userId, bool sex) async{
    // 0 if female 1 if men
    await users.doc(userId).update({
      'sex': sex
    });
  }

  Future<void> setAge(String userId, int age) async{
    await users.doc(userId).update(
        {
          'age': age
        }
    );
  }
  Future<void> setLength(String userId, double length, bool type) async{
    // 1 for ft 0 for cm
    await users.doc(userId).update(
        {
          'length': [length, type]
        }
    );
  }
  Future<void> setWeight(String userId, int weight) async{
    await users.doc(userId).update(
        {
          'weight': weight
        }
    );
  }
  Future<int> isSignupDone(String userId) async {
    var docRef = await users.doc(userId).get();
    var name=  docRef.get('name');
    if(name == null)
      {
        return 0;
      }
    var sex = docRef.get('sex');
    if(sex == null)
      {
        return 1;
      }
    var age = docRef.get('age');
    if(age == null)
      {
        return 2;
      }
    var length = docRef.get('length');
    if(length == null)
    {
      return 3;
    }
    var weight = docRef.get('weight');
    if(weight == null)
    {
      return 4;
    }
    return 5;
  }

}