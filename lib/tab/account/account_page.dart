import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_renew/tab/account/account_model.dart';

import '../../detail_post/detail_post_page.dart';
import '../../domain/post.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 로그아웃을 클릭하면.
    final model = AccountModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
        actions: [
          IconButton(
            onPressed: () {
              model.logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // 스택안에서 버튼 위치 조절 가능.
                    Stack(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            // 로그인한 정보 토대로 프로필 이미지 바꿈.
                            backgroundImage: NetworkImage(
                                model.getProfileImageUrl()),
                          ),
                        ),
                        // 플러팅액션버튼 옮기려고 만든거
                        Container(
                          width: 80,
                          height: 80,
                          // 컨테이너 안에 있는 얼라이먼트 속성.
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const SizedBox(
                                width: 28,
                                height: 28,
                                child: FloatingActionButton(onPressed: null,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: FloatingActionButton(onPressed: () {},
                                  child: const Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.getNickName(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // 리스트로 게시물 가져오는 작업을 하지 않았기 때문에 카운트도 스트림빌더사용.
                    StreamBuilder<QuerySnapshot<Post>>(
                        stream: model.postsStream,
                        builder: (context, snapshot) {
                          int count = 0;

                          // 데이터가 있으면 count가 계속 바뀜
                          if (snapshot.hasData) {
                            count = snapshot.data!.size;
                          }

                          return Text(
                            '$count',
                            style: const TextStyle(fontSize: 18),
                          );
                        }
                    ),
                    const Text('게시물',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text('0',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text('팔로워',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text('0',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text('팔로잉',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
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
                                        (context) =>
                                        DetailPostPage(post: post)),
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
            ),
          ],
        ),
      ),
    );
  }
}
