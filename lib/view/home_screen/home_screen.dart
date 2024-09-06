import 'package:flutter/material.dart';
import 'package:sqflite_sample/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await HomeScreenController.getEmployee();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: designationcontroller,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    await HomeScreenController.addEmployee(
                        name: namecontroller.text,
                        designation: designationcontroller.text);
                    await HomeScreenController.getEmployee();
                    setState(() {});
                  },
                  child: Text(
                    "save",
                    style: TextStyle(fontSize: 20),
                  )),
              Expanded(
                  child: ListView.builder(
                itemCount: HomeScreenController.myDataList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(HomeScreenController.myDataList[index]["name"]),
                  subtitle: Text(
                      HomeScreenController.myDataList[index]["designation"]),
                  trailing: IconButton(
                      onPressed: () async {
                        await HomeScreenController.deleteEmployee(
                            HomeScreenController.myDataList[index]["id"]);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete)),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
