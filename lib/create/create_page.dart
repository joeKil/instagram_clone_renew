import 'dart:io';
import 'package:flutter/material.dart';
import 'package:instagram_clone_renew/create/create_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final model = CreateModel();

  final _titleTextController = TextEditingController();

  File? _image;

  bool isLoading = false;

  @override
  void dispose() {
    _titleTextController.dispose();
    super.dispose();
  }

  // StatelessWidget은 변수를 쓸 수 없다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        actions: [
          IconButton(
            onPressed: () async {
              // 이미지 피커 실행
              print('눌렀다');
              if (_image != null && _titleTextController.text.isNotEmpty) {
                // 로딩 시작
                setState(() {
                isLoading = true;
                });

               await model.uploadPost(
                  _titleTextController.text,
                  _image!,
                );
               // 로딩 끝
                setState(() {
                  isLoading = false;
                });
                print('끝났다');

                // context쓰게 된다면 이런 코드를 써줘야지 에러가 안난다.
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // 공사장표시 없애기 위해 사용하는 싱글차일드스크롤뷰
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                // 텍스트컨트롤러 연결
                // 이걸 통해서 게시물쓰기 정보 얻을 수 있다.
                controller: _titleTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "제목을 입력하세요",
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 20),
              // 사진이 있으면 이게 안나오고, 사진이 없으면 플레이스홀더가 나옴
              // SizedBox(
              //   width: 300,
              //   height: 300,
              //   child: Placeholder(),
              // ),
              if (isLoading) const CircularProgressIndicator(),
              ElevatedButton(
                onPressed: () async {
                  // 파일 리턴
                  _image = await model.getImage();
                  // 화면 갱신코드 작성.
                  setState(() {});
                },
                child: const Text('이미지 선택'),
              ),
              // 웹에서 이미지 가져와서 보여주는 중. 임이의 이미지 url사용한거임.
              // 실제 이미지를 골라오려면 image.file 사용해야함
              if (_image != null) Image.file(_image!),

              // Image.network(
              //   'https://encrypted-zqleXOplBczVUrX9npQGOYMQ&usqp=CAU',
              //   // 가로만 고정
              //   width: 300,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
