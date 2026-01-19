// A typed model class - parses raw JSON into a proper Dart object with
// type safety, instead of passing Map<String, dynamic> around everywhere
// (which loses autocomplete and lets typos in key names slip through silently).
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
