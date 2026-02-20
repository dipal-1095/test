import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/feature/auth/cubit/auth_cubit.dart';
import 'package:practice/feature/auth/cubit/auth_state.dart';
import 'package:practice/feature/auth/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => AuthCubit(),
        child: LoginScreen(),
      ),
    );
  }
}
