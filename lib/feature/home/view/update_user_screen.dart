import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/feature/home/cubit/user_cubit.dart';
import 'package:practice/feature/home/cubit/user_status.dart';
import 'package:practice/feature/home/model/user_model.dart';

import '../../../helper/validate_check.dart';

class UpdateUserScreen extends StatefulWidget {
  final UserModel user;
  const UpdateUserScreen({super.key, required this.user});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = widget.user.email ?? '';
    nameController.text = widget.user.name ?? '';
    passwordController.text = widget.user.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update User Screen")),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) => ValidateCheck.emptyValidation(value),
              ),
              SizedBox(height: 10),
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
                      UserModel user = UserModel(
                        id: widget.user.id,
                        email: emailController.text,
                        name: nameController.text,
                        password: passwordController.text,
                      );
                      context.read<UserCubit>().updateUser(
                        widget.user.id!,
                        user,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.purple.shade400,
                  ),
                  child: BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state.userStatus == UserStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("User updated successfully!")),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    builder: (context, state) {
                      if (state.userStatus == UserStatus.loading) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      return Text(
                        "Update",
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
