import 'package:chatapp/cubits/login_cubit/login_cubit.dart';
import 'package:chatapp/views/chat_view.dart';
import 'package:chatapp/views/home_view.dart';
import 'package:chatapp/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserLoginCubit(),
        ),
        
      ],
      child: MaterialApp(
        routes: {
          'LoginPage': (context) => LoginPage(),
          'RegisterPage': (context) => RegisterPage(),
          'ChatPage': (context) => ChatPage()
        },
        initialRoute: 'LoginPage',
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
