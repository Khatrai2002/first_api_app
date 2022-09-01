import 'package:first_api_app/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowDilogPage extends StatefulWidget {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? avatar;
  const ShowDilogPage(
      {Key? key, this.firstname, this.lastname, this.avatar, this.id})
      : super(key: key);

  @override
  State<ShowDilogPage> createState() => _ShowDilogPageState();
}

class _ShowDilogPageState extends State<ShowDilogPage> {
  String? firstname = "";
  String? lastname = "";
  String? avatar = "";
  // TextEditingController fname = TextEditingController();
  // TextEditingController lname = TextEditingController();
  // TextEditingController mnum = TextEditingController();
  // TextEditingController avatar = TextEditingController();
  bool isLoading = false;
  // String? mno='';
  // String? url='';
  final validations = GlobalKey<FormState>();

  var isAdded;
  @override
  void initState() {
    if (widget.firstname != null &&
        widget.lastname != null &&
        widget.avatar != null) {
      setState(() {
        firstname = widget.firstname;
        lastname = widget.lastname;
        avatar = widget.avatar;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Personal Information")),
      content: Form(
        key: validations,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: firstname,
              onChanged: ((f) {
                firstname = f;
              }),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter your Firstname",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "enter your firstname";
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: lastname,
              onChanged: ((l) {
                firstname = l;
              }),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter your Lastname"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "enter your lastname";
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            // TextFormField(
            //   controller: mnum,
            //   keyboardType: TextInputType.text,
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(12)),
            //       hintText: "Enter your Mono"),
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return "enter your Mono";
            //     }
            //   },
            // ),
            //  const  SizedBox(height: 10,),
            //   TextFormField(
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(12)),
            //       hintText: "Enter your MobileNo"),
            //       validator: (value){
            //         if(value!.isEmpty){
            //           return "enter your mono";
            //         }
            //       },
            //   ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: avatar,
              onChanged: ((a) {
                firstname = a;
              }),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter url"),
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return "enter url";
              //   }
              // },
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
                onPressed: () {
                  if (validations.currentState!.validate()) {
                    // fname.clear();
                    addUserApi();
                    // lname.clear();
                    // mnum.clear();
                    // mnum.clear();
                    Navigator.pop(context, true);
                  }
                  ;
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  // void addUserApi(context) async {
  //   http.Response res =
  //       await http.post(Uri.parse("${AppConfig.baseUrl}/users"), body: {
  //     "firstname": fname!.text,
  //     "lastname": lname!.text,
  //     "avatar": url!.text,
  //      "mobileNumber":mnum!.text,
  //   });

  //   if (res.statusCode == 201) {
  //     Navigator.pop(context, true);
  //   }
  // }
  // @override
  // void dispose() {
  //   fname.dispose();
  //   lname.dispose();
  //   avatar.dispose();
  //   mnum.dispose();
  //   super.dispose();

  // }

  void addUserApi() async {
    if (firstname!.isNotEmpty && lastname!.isNotEmpty && avatar!.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      http.Response res =
          await http.post(Uri.parse("${AppConfig.baseUrl}/users"), body: {
        "firstname": firstname,
        "lastname": lastname,
        "avatar": avatar,
        //  "mobileNumber":mnum.text,
      });

      if (res.statusCode == 201) {
        Navigator.pop(context, true);
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
