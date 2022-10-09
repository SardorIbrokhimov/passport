import 'package:firebase_database/firebase_database.dart';
import 'package:passport/model/post.dart';

class RTDB {
  static final _database = FirebaseDatabase.instance.reference();

  static Future addPost(Post post) async {
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Post>> getPosts(String id) async {
    List<Post> items = [];
    // Query query = FirebaseDatabase.getInstance()
    Query _query =
    _database.reference().child("posts").orderByChild("userId").equalTo(id);
    var snapshot = await _query.once();
    var result = snapshot.value.values as Iterable;

    for (var item in result) {
      items.add(Post.fromJson(Map<String, dynamic>.from(item)));
    }
    return items;
  }
}
