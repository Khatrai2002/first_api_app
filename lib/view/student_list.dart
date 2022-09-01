import 'dart:convert';

import 'package:first_api_app/seperate%20class/showdilog.dart';
import 'package:first_api_app/utils/app_config.dart';
import 'package:first_api_app/view/student_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/student_model.dart';

class Studentlist extends StatefulWidget {
  const Studentlist({Key? key}) : super(key: key);

  @override
  State<Studentlist> createState() => _StudentlistState();
}

class _StudentlistState extends State<Studentlist> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController mnum = TextEditingController();
  TextEditingController avatar = TextEditingController();
  List<Student> studends = [];
  bool isLoading = false;
 final validations=GlobalKey<FormState>();

  @override
  void initState() {
    getstudents();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _boxalert();
          },
          child: Icon(Icons.add)
          //  IconButton(
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         barrierDismissible: false,
          //         builder: (context) => AlertDialog());
          //   },
          //   icon: Icon(Icons.add),

          // ),

          ),
      appBar: AppBar(
        title: Center(child: const Text("Students")),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: (() {
                  getstudents();
                }),
                child: Icon(Icons.rotate_left)),
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator.adaptive())
          : studends.isEmpty
              ? const Center(child: Text("No students"))
              : ListView.builder(
                  itemCount: studends.length,
                  itemBuilder: (context, index) => ListTile(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentDetails(
                                        student: studends[index],
                                      )));
                        }),
                        title: Text(
                            "${studends[index].firstname} ${studends[index].lastname}"),
                      )),
    );
  }

  void getstudents() async {
    setState(() => isLoading = true);
    http.Response response =
        await http.get(Uri.parse("${AppConfig.baseUrl}/users"));

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
studends=[];

      if (decoded is List) {
        for (var stud in decoded) {
          studends.add(Student.fromMap(stud as Map<String, dynamic>));
        }
      }
      setState(() => isLoading = false);
    }
     print(studends);
  }

  _boxalert()async {
  var isAdded=await   showDialog(
        context: context,
        builder: (context) {
          return  ShowDilogPage();

          
          
         
        });
        if(isAdded!=null &&isAdded==true){
          getstudents();
        }
  }
  
  @override
  void dispose() {
    fname.dispose();
    lname.dispose();
    avatar.dispose();
    mnum.dispose();
    super.dispose();
    
  }
   addUserApi(BuildContext context)async{
    http.Response res =
        await http.post(Uri.parse("${AppConfig.baseUrl}/users"), body: {
      "firstname": fname.text,
      "lastname": lname.text,
      "avatar": avatar.text,
       "mobileNumber":mnum.text,
    });

    if (res.statusCode == 201) {
      Navigator.pop(context, true);
    }
  }
   }

 


