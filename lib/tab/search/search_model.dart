import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_renew/domain/post.dart';

class SearchModel {
  // 파이어베이스가 만든 타입
  // 해석 : posts정보를 QuerySnapshot이라는 객체로 들고있겠다는 뜻.
  // 데이터 바뀌면 자동 갱신됨.
  final Stream<QuerySnapshot<Post>> postsStream = FirebaseFirestore.instance
      .collection('posts')
      // 이게 있으면 최종적으로는 post결과물로 얻을 수 있고, 없으면 수동으로 다 작업해줘야한다.
      .withConverter<Post>(
        fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      )
      .snapshots();
}
