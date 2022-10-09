class Post {
   var userId;
   var ism;
   var familiya;
   var otasi;
   var passraqam;
   var passseriya;
   var jshsh;
   var berilgansana;

  Post(
      {required this.ism,
      required this.familiya,
      required this.otasi,
      required this.berilgansana,
      required this.jshsh,
      required this.passraqam,
      required this.passseriya,
      required this.userId});

  Post.fromJson(Map<String, dynamic> map)
      : userId = map['userId'],
        ism = map["ism"],
        familiya = map["familiya"],
        otasi = map["otasi"],
        berilgansana = map["berilgansana"],
        jshsh = map["jshsh"],
        passraqam = map["passraqam"],
        passseriya = map["passseriya"];

  Map<String, dynamic> toJson() => {
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
