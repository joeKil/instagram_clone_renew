import 'package:firebase_auth/firebase_auth.dart';

class DetailPostModel {
  String getEmail() {
    // 로그인된 유저를 알 수 있다..
    // null이 아니면 기본값으로 '' 주기
    return FirebaseAuth.instance.currentUser?.email ?? '메일 없음';
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
