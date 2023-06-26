import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_renew/auth/auth_gate.dart';
import 'package:instagram_clone_renew/tab/firebase_options.dart';

void main() async {
  // 파이어베이스 사용할 때 필요함.
  // 파이어베이스.옵션.다트 파일은 숨겨야함. 노출되면 안됨.
  // google-services.json파일도 마찬가지임
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}
