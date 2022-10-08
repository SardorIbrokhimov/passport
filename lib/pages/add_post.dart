
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
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var dateController = TextEditingController();
  var contentController = TextEditingController();

  _addPost() async {
    String name1 = nameController.text.toString();
    String surname1 = surnameController.text.toString();
    String date1 = dateController.text.toString();
    String content1 = contentController.text.toString();

    String? userId = await Preference.getUserId();
    Post post1 = new Post(
        userId: userId!,
        name: name1,
        surname: surname1,
        content: content1,
        date: date1);

    RTDB.addPost(post1).then((value) => {
      Navigator.pushReplacementNamed(context, Home.id),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Add post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Ism',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  hintText: 'Familiya',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: lastnameController,
                decoration: InputDecoration(
                  hintText: 'Otasining ismi',
                ),
              ),
              SizedBox(
                height: 15,
              ),

              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  hintText: 'Passport seriyasi',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: 'Passport raqami',
                ),

              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: double.infinity,
                  height: 45,
                  color: Colors.orange,
                  child: TextButton(
                    onPressed: () {
                      _addPost();
                    },
                    child: Text(
                      "Add",
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
