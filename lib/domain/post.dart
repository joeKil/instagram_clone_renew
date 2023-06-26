class Post {
  // 문서 아이디
  String id;
  String title;
  String imageUrl;
  String userId;

  // 플러터가 선호하는 형태
  Post({required this.id, required this.title, required this.imageUrl, required this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
        userId: json['userId'] as String,
        title: json['title'] as String,
        imageUrl: json['imageUrl'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
    };
  }
}
