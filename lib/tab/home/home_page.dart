import 'package:flutter/material.dart';
import 'package:instagram_clone_renew/tab/home/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final model = HomeModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      // 컬럼 특 : 아래로 배치
      // 강제로 가로 사이즈를 늘리는건 x
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 위에 너무 딱 붙어있으니 20만큼 공간주기.
            const SizedBox(height: 20),
            const Text(
              'Instagram에 오신 것을 환영합니다',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text('사진과 동영상을 보려면 팔로우하세요'),
            const SizedBox(height: 20),
            // 카드는 알아서 크기가 맞춰짐.
            Card(
              // 그림자
              elevation: 4.0,
              // 안쪽에 패딩 채워주기
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                     SizedBox(
                      width: 100,
                      height: 100,
                      child: GestureDetector(
                        onTap: () async {
                          // 이게 변경되면 화면 갱신 필요
                         await model.updateProfileImage();

                         setState(() {
                         });
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              model.getProfileImageUrl()),
                        ),
                      ),
                    ),
                    // 이메일 가데이터에서 교체
                    // const Text(
                    //   'testEmail@test.com',
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // )
                    Text(model.getEmail(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // const Text('닉네임'),
                    Text(model.getNickName()),
                    const SizedBox(height: 8),
                    // 사진 3개 넣는 부분은 Row사용.
                    // Row는 꽉 채우는 습성을 가지고 있음.
                    Row(
                      // 꽉 채우지말고 작게 만들라고 이거씀.
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com'
                          '/images?q=tbn:ANd9GcQywdIalUPi7VsG2'
                          '-Ycs1hXMmDQkSYJdJ3e0A&usqp=CAUc',
                          width: 70,
                          height: 70,
                          // 정해준 크기에 맞게끔 꽉 채워줌.
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 4),
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com'
                          '/images?q=tbn:ANd9GcQywdIalUPi7VsG2-'
                          'Ycs1hXMmDQkSYJdJ3e0A&usqp=CAUc',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 4),
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com/'
                          'images?q=tbn:ANd9GcQywdIalUPi7VsG2-Yc'
                          's1hXMmDQkSYJdJ3e0A&usqp=CAUc',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('FaceBook 친구'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('팔로우'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
