import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomeModel {
  final _picker = ImagePicker();

  Future<void> updateProfileImage() async {
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      // 이미지 업로드
      final storageRef = FirebaseStorage.instance.ref();
      // 보안상 민감해서 이렇게 업로드
      final imageRef = storageRef.child('user/${FirebaseAuth.instance.currentUser?.uid}/${DateTime.now().millisecondsSinceEpoch}.png');

      // 이미지 url 을 얻고
      await imageRef.putFile(File(xFile.path));
      // 다운로드 url을 얻음
      final downloadUrl = await imageRef.getDownloadURL();

      // 업데이트 포토
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
    }
  }

  String getEmail() {
    // 로그인된 유저를 알 수 있다..
    // null이 아니면 기본값으로 '' 주기
    return FirebaseAuth.instance.currentUser?.email ?? '메일 없음';
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '이름 없음';
  }

  String getProfileImageUrl() {
    return FirebaseAuth.instance.currentUser?.photoURL ?? 'https://encrypted-tbn0.gstatic.com'
        '/images?q=tbn:ANd9GcQywdIalUPi7VsG2-'
        'Ycs1hXMmDQkSYJdJ3e0A&usqp=CAUc';
  }
}
