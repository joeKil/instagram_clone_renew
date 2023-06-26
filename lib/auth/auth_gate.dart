import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:instagram_clone_renew/tab_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // 이걸로 파이어베이스를 통해 인증한 객체가 있다면 그것의 정보를 이것으로 얻을 수 있음.
      // 변경이 된지 안된지 알려주는 스트림. 스트림 데이터를 기반으로 유아이로 변경해줌.
      // 로그인되고나서 화면이 자동으로 바뀌는 이유는 : 로그인되면 유아이 다시 그려줌.
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 스냅샷안에 파이어베이스가 준 유저 정보가 들어있다.
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: const [
              EmailProviderConfiguration(),
            ],
            // 로그인화면 꾸밈
            headerBuilder: (context, constraints, _) {
              return const Center(
                  child: Text(
                'Instagram Clone',
                style: TextStyle(fontSize: 40),
              ));
            },
          );
        }

        // Render your application if authenticated
        return const TabPage();
      },
    );
  }
}
