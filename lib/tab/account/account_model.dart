import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/post.dart';

class AccountModel {
  // 내 게시물만 보는 작업.
  final Stream<QuerySnapshot<Post>> postsStream = FirebaseFirestore.instance
      .collection('posts')
      // uid 동일한 사진만 얻겠다는 뜻
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .withConverter<Post>(
        fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      )
      .snapshots();

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '이름 없음';
  }

  String getProfileImageUrl() {
    return FirebaseAuth.instance.currentUser?.photoURL ??
        'https://encrypted-tbn0.gstatic.com'
            '/images?q=tbn:ANd9GcQywdIalUPi7VsG2-'
            'Ycs1hXMmDQkSYJdJ3e0A&usqp=CAUc';
  }
}
