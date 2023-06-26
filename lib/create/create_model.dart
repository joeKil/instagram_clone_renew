// 비즈니스 모델은 이 화면에서 쓸 로직이라 보면된다.
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_renew/domain/post.dart';

class CreateModel {
  final _picker = ImagePicker();

  Future<File?> getImage() async {
    // x파일은 이미지피커쪽에서 만든거임.
    // 갤러리에서 가져옴
    // 이미지피커에만 있는걸로 쓰긴 좀 그래서 File로 변환을 한번 거침.
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    // 조건 통과하면 path 리턴
    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  Future<void> uploadPost(String title, File imageFile) async {
    // 이걸로 데이터베이스 접근 컬렉션은 안에 테이블같은거임?

    // 이미지 업로드
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('postImages/${DateTime.now().millisecondsSinceEpoch}.png');

    // 이미지 url 을 얻고
    await imageRef.putFile(imageFile);
    // 다운로드 url을 얻음
    final downloadUrl = await imageRef.getDownloadURL();

    // 게시물 업로드
    final postsRef = FirebaseFirestore.instance
        .collection('posts')
        // data가 null이 아니면 json으로 본다.
        .withConverter<Post>(
          fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
          toFirestore: (post, _) => post.toJson(),
        );

    // 생성하지 않은 상태에서 새로운 문서의 주소 만들어줌.
    final newPostRef = postsRef.doc();

    // await postsRef.add(Post(
    //   userId: FirebaseAuth.instance.currentUser?.uid ?? '',
    //   title: title,
    //   imageUrl: 'https://encrypted-tbn0.gstatic.com'
    //       '/images?q=tbn:ANd9GcQywdIalUPi7VsG2-'
    //       'Ycs1hXMmDQkSYJdJ3e0A&usqp=CAUc',
    // ));

    newPostRef.set(Post(
      id: newPostRef.id,
      userId: FirebaseAuth.instance.currentUser?.uid ?? '',
      title: title,
      imageUrl: downloadUrl,
    ));
  }
}
