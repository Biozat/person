import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

import '../db/db_helper.dart';
import '../models/Person.dart';

class PersonController extends GetxController{


  @override
  void onReady() {
    super.onReady();
  }

  var personList = <Person>[].obs;

  Future<int> addPerson({Person? person}) async{
    return await DBHelper.insert(person);
  }

  void getPersons() async {
    List<Map<String, dynamic>> persons = await DBHelper.query();
    personList.assignAll(persons.map((data) => new Person.fromJson(data)).toList());
  }
}