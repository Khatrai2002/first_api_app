import 'dart:convert';

import 'package:first_api_app/models/student_model.dart';
import 'package:first_api_app/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key, required this.student}) : super(key: key);
  final Student student;
  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Student? student;
  bool isLoading = false;
  @override
  void initState() {
    getUserdetails();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isLoading
            ? Text("students details")
            : Text("${student?.firstname} ${student?.lastname}"),
      ),
      body:
      
       isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Center(
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                        image: DecorationImage(
                          image: NetworkImage(
                            "${student?.avatar}",
                          ),
                          fit: BoxFit.cover
                        )),
                  ),
                  Text("First name: ${student?.firstname}"),
                  Text("Last name: ${student?.lastname}"),
                  
              ],
            ),
          ),
    );
  }

  void getUserdetails() async {
    setState(() => isLoading = true);
    http.Response response = await http
        .get(Uri.parse("${AppConfig.baseUrl}/users/${widget.student.id}"));
    if (response.statusCode == 200) {
      print(response.statusCode);

      var decoded = jsonDecode(response.body);
      student = Student.fromMap(decoded);
      setState(() => isLoading = false);
    }
  }
}
