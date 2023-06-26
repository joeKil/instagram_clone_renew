import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_renew/create/create_page.dart';
import 'package:instagram_clone_renew/detail_post/detail_post_page.dart';
import 'package:instagram_clone_renew/tab/search/search_model.dart';

import '../../domain/post.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  // const 안붙이면 에러남
  final List<String> _urls = const [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSSxh9MGdNO0zqleXOplBczVUrX9npQGOYMQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSSxh9MGdNO0zqleXOplBczVUrX9npQGOYMQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSSxh9MGdNO0zqleXOplBczVUrX9npQGOYMQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSSxh9MGdNO0zqleXOplBczVUrX9npQGOYMQ&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    final model = SearchModel();

    return Scaffold(
      // 아이콘 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePage()),
          );
        },
        child: const Icon(Icons.create),
      ),
      appBar: AppBar(
        title: const Text('Instagram clone'),
      ),
      // 빌더는 성능을 좀 더 좋게하면서 동적으로 화면을 만들어줌
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: StreamBuilder<QuerySnapshot<Post>>(
            stream: model.postsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('알 수 없는 에러');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              // 내부타입을 포스트로 바꿔서 사용.
              // 데이터 뽑아서 줌.
              List<Post> posts =
                  snapshot.data!.docs.map((post) => post.data()).toList();

              return GridView.builder(
                // 갯수까지 알려줘야 에러없이 사진이 나옴
                itemCount: posts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2.0,
                  // 이렇게하면 틈새 생김
                  crossAxisSpacing: 2.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // 이렇게 가져와서 사용함.
                  final post = posts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder:
                                // 위에 만들어 놓은 post가 들어감.
                                (context) => DetailPostPage(post: post)),
                      );
                    },
                    child: Hero(
                      // 이미지가 유니크해야함. 같은 이미지 쓰면안됨.
                      // 근데 이미 유니크하게 작업해놓음.
                      // 클릭하는 이미지도 클릭의 대상이 되는 이미지도 같은 hero작업을 해줘야함.
                      tag: post.id,
                      child: Image.network(
                        post.imageUrl,
                        // 국룰
                        // 별다른 사이즈 설정할 필요 없음.
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
