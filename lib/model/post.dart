class Post {
  String id;

  String content;
  String date;
  String? image;
  String? category;
  List<Comment> comment;
  Post(
      {required this.content,
      required this.date,
      required this.image,
      required this.category,
      required this.comment,
      required this.id});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        content: json['content'],
        date: json['date'],
        image: json['image'],
        category: json['category'],
        comment: json['comment']);
  }
}

class Comment {
  String content;
  String date;
  String id;

  Comment({required this.content, required this.date, required this.id});
}
