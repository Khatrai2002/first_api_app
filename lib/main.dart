import 'package:first_api_app/view/student_list.dart';
import 'package:first_api_app/view/student_listcopy.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
               primarySwatch: Colors.blue,
      ),
       home: const Studentlist(),
      // home:const StudentListClass(),
    );
  }
}

