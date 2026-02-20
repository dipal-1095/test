import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/feature/auth/cubit/auth_cubit.dart';
import 'package:practice/feature/auth/cubit/auth_state.dart';
import 'package:practice/feature/home/cubit/user_cubit.dart';
import 'package:practice/feature/home/view/user_screen.dart';
import 'package:practice/helper/validate_check.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) => ValidateCheck.emailValidation(value),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: showPassword,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
                validator: (value) => ValidateCheck.passwordValidation(value),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthCubit>().login(
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.purple.shade400,
                  ),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state.authStatus == AuthStatus.loading) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      if (state.authStatus == AuthStatus.success) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (context) => UserCubit(),
                              child: UserScreen(),
                            ),
                          ),
                        );
                      }

                      return Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
