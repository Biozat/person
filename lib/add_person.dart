import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:person/controllers/person_controller.dart';
import 'package:person/main.dart';
import 'package:person/models/Person.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({Key? key}) : super(key: key);

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final PersonController personController = Get.put(PersonController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    personController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter Name"
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                  hintText: "Enter Age"
              ),
            ),
            SizedBox(height: 10,),

            ElevatedButton(onPressed:() {
              setState(() {
                _validateInput(personController, nameController, ageController);
                Get.to(()=>HomePage());
              });

            }

                , child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}

 _validateInput(PersonController personController, TextEditingController nameController, TextEditingController ageController) {
     if(nameController.text.isEmpty || ageController.text.isEmpty){
       Get.snackbar("Required", "All fields are required",
           snackPosition: SnackPosition.BOTTOM,
           backgroundColor: Colors.white,
           icon: Icon(Icons.warning_amber_rounded, color: Colors.red,),
           colorText: Colors.blueAccent,
       );
     }else if(nameController.text.isEmpty && ageController.text.isEmpty){
       Get.snackbar("Required", "All fields are required",
         snackPosition: SnackPosition.BOTTOM,
         backgroundColor: Colors.white,
         icon: Icon(Icons.warning_amber_rounded, color: Colors.red,),
         colorText: Colors.blueAccent,

       );
     }else{

       _addPserson(personController, nameController.text, ageController.text);
     }

}

 _addPserson(PersonController personController, String name, String age) async{
  await  personController.addPerson(
    person: Person(
      name: name,
      age: age
    )


  );
 }



