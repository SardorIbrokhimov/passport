import 'package:flutter/material.dart';
import 'package:passport/model/post.dart';
import 'package:passport/pages/add_post.dart';
import 'package:passport/services/Auth_service.dart';
import 'package:passport/services/preference.dart';
import 'package:passport/services/realtime.dart';

class Home extends StatefulWidget {
  static const String id = "";

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> item = [];

  @override
  void initState() {
    super.initState();

    _apiGetPosts();
  }

  _apiGetPosts() async {
    String? userId = await Preference.getUserId();
    RTDB.getPosts(userId!).then((posts) => {
      setState(() {
        item.addAll(posts);
      }),
      print("Posts:${item.length}"),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text("All Posts"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AuthService.signout(context);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: item.length,
            itemBuilder: (ctx, i) {
              return itemOfList(item[i]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPostPage()),
          );
        },
      ),
    );
  }

  Widget itemOfList(Post post) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple,width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(left: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [

              Text(
                post.familiya,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                post.ism,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                post.otasi,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(
            height: 5,
          ),
          Text(
          "Passport seriyasi : ${post.passseriya+post.passraqam}",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "JSHSHIR : ${post.jshsh}",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Passport berilgan sana : ${post.berilgansana}",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
