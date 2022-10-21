import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passport/model/post.dart';
import 'package:passport/pages/home_page.dart';
import 'package:passport/services/preference.dart';
import 'package:passport/services/realtime.dart';
import 'package:passport/services/storage_service.dart';

class AddPostPage extends StatefulWidget {
  static const String id = "add_post_page";

  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  bool isloading = false;
  DateTime date = DateTime.now();
  DateTime _date = DateTime.now();
  var year = DateTime.now().year;
  File? _image;
  final pickimg = ImagePicker();

  var ismController = TextEditingController();
  var familiyaController = TextEditingController();
  var otasiController = TextEditingController();
  var passserController = TextEditingController();
  var passraqController = TextEditingController();
  var berilgansanaController = TextEditingController();
  var JSHSHIRController = TextEditingController();

  Future getImage() async {
    final pickedFile = await pickimg.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  Future getImageCamera() async {
    final pickedFile = await pickimg.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  _addPost() async {
    String ism = ismController.text.toString();
    String familiya = familiyaController.text.toString();
    String otasi = otasiController.text.toString();
    String passseriya = passserController.text.toString();
    String passraqam = passraqController.text.toString();
    String berilgansana = berilgansanaController.text.toString();
    String JSHSHIR = JSHSHIRController.text.toString();
    if (ism.isNotEmpty &&
        familiya.isNotEmpty &&
        otasi.isNotEmpty &&
        passseriya.isNotEmpty &&
        passraqam.isNotEmpty &&
        berilgansana.isNotEmpty &&
        JSHSHIR.isNotEmpty) {
      uploadImage(
          ism: ism,
          familiya: familiya,
          otasi: otasi,
          passser: passseriya,
          passraq: passraqam,
          berilgan: berilgansana,
          Jshsh: JSHSHIR);
    }
  }

  void uploadImage(
      {required String ism,
      required String familiya,
      required String otasi,
      required String passser,
      required String passraq,
      required String berilgan,
      required String Jshsh}) {
    setState(() {
      isloading = true;
    });

    StoreService.uploadImage(_image!).then((imgUrl) => {
          _addDatabase(
              ism: ism,
              familiya: familiya,
              otasi: otasi,
              passser: passser,
              passraq: passraq,
              berilgan: berilgan,
              Jshsh: Jshsh,
              img_link: imgUrl!),
        });
  }

  _addDatabase(
      {required String ism,
      required String familiya,
      required String otasi,
      required String passser,
      required String passraq,
      required String berilgan,
      required String Jshsh,
      required String img_link}) async {
    String? userId = await Preference.getUserId();

    Post post1 = new Post(
        ism: ism,
        familiya: familiya,
        otasi: otasi,
        berilgansana: berilgan,
        jshsh: Jshsh,
        passraqam: passraq,
        passseriya: passser,
        userId: userId!,
        img_link: img_link);

    RTDB.addPost(post1).then((value) => {
          setState(() {
            isloading = false;
          }),
          Navigator.pushReplacementNamed(context, Home.id),
        });
  }

  selectdate() {
    showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: DateTime(year)).then((value) => {
          setState((){
            _date=value!;
            berilgansanaController.text="${_date.day}.${_date.month}.${_date.year}";

          }),
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
              GestureDetector(
                child: Container(
                  height: 80,
                  width: 80,
                  color: Colors.black26,
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                ),
                onTap: () {
                  select(context);
                },
              ),
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
                  suffixIcon: IconButton(
                    onPressed: selectdate,
                    icon: Icon(Icons.date_range),
                  ),
                  hintText: 'Berilgan sanasi',
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
              Visibility(
                  visible: isloading, child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  void select(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Choose"),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      getImage();
                      Navigator.pushReplacementNamed(context, AddPostPage.id);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 25,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Galery", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      getImageCamera();
                      Navigator.pushReplacementNamed(context, AddPostPage.id);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 25,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Camera", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
}
