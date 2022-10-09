import 'package:flutter/material.dart';
import 'package:passport/model/post.dart';
import 'package:passport/pages/home_page.dart';
import 'package:passport/services/preference.dart';
import 'package:passport/services/realtime.dart';

class AddPostPage extends StatefulWidget {
  static const String id = "add_post_page";

  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  var ismController = TextEditingController();
  var familiyaController = TextEditingController();
  var otasiController = TextEditingController();
  var passserController = TextEditingController();
  var passraqController = TextEditingController();
  var berilgansanaController = TextEditingController();
  var JSHSHIRController = TextEditingController();

  _addPost() async {
    String ism = ismController.text.toString();
    String familiya = familiyaController.text.toString();
    String otasi = otasiController.text.toString();
    String passseriya = passserController.text.toString();
    String passraqam = passraqController.text.toString();
    String berilgansana = berilgansanaController.text.toString();
    String JSHSHIR = JSHSHIRController.text.toString();

    String? userId = await Preference.getUserId();
    Post post1 = new Post(
        ism: ism,
        familiya: familiya,
        otasi: otasi,
        berilgansana: berilgansana,
        jshsh: JSHSHIR,
        passraqam: passraqam,
        passseriya: passseriya,
        userId: userId!);

    RTDB.addPost(post1).then((value) => {
          Navigator.pushReplacementNamed(context, Home.id),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text("Add post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: ismController,
                decoration: InputDecoration(
                  hintText: 'Ism',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: familiyaController,
                decoration: InputDecoration(
                  hintText: 'Familiya',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: otasiController,
                decoration: InputDecoration(
                  hintText: 'Otasining ismi',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: passserController,
                decoration: InputDecoration(
                  hintText: 'Passport seriyasi',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: passraqController,
                decoration: InputDecoration(
                  hintText: 'Passport raqami',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: JSHSHIRController,
                decoration: InputDecoration(
                  hintText: 'JSHSHIR',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: berilgansanaController,
                decoration: InputDecoration(
                  hintText: 'Berilgan sanasi     dd/mm/yyyy',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
                      _addPost();
                    },
                    child: Text(
                      "Qo'shish",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
