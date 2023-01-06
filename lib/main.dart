import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:person/add_person.dart';
import 'package:person/controllers/person_controller.dart';
import 'package:person/db/db_helper.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),

    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersonController personController = Get.put(PersonController());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    personController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    personController.getPersons();
    print(personController.personList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Person App")
      ),
      body: Column(
        children: [
          Container(
            child: GestureDetector (
                onTap: () async {

                  Get.to(()=>AddPerson());

                },
                child: Icon(Icons.add, color: Colors.black, )
            ),
          ),
          Expanded(
            child: Obx((){
                return ListView.builder(
                    itemCount: personController.personList.length,
                    itemBuilder: (_, index){
                      return Container(
                        child: Column(
                          children: [
                            Text(personController.personList[index].name!),
                            SizedBox(height: 10,),
                            Text(personController.personList[index].age!)
                          ],
                        ),
                      );
                    });
            })),

        ],
      ),
    );
  }
}


/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed ,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
