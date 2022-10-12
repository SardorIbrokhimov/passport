class Post {
  var userId;
  var ism;
  var familiya;
  var otasi;
  var passraqam;
  var passseriya;
  var jshsh;
  var berilgansana;
  var img_link;

  Post(
      {required this.ism,
      required this.familiya,
      required this.otasi,
      required this.berilgansana,
      required this.jshsh,
      required this.passraqam,
      required this.passseriya,
      required this.userId,
      required this.img_link});

  Post.fromJson(Map<String, dynamic> map)
      : userId = map['userId'],
        ism = map["ism"],
        familiya = map["familiya"],
        otasi = map["otasi"],
        berilgansana = map["berilgansana"],
        jshsh = map["jshsh"],
        passraqam = map["passraqam"],
        passseriya = map["passseriya"],
        img_link = map["img_link"];

  Map<String, dynamic> toJson() => {
        "img_link": img_link,
        'userId': userId,
        'ism': ism,
        'familiya': familiya,
        'otasi': otasi,
        'berilgansana': berilgansana,
        'jshsh': jshsh,
        'passraqam': passraqam,
        'passseriya': passseriya,
      };
}
