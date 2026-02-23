import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/feature/home/cubit/user_cubit.dart';
import 'package:practice/feature/home/cubit/user_status.dart';
import 'package:practice/feature/home/view/update_user_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //    context.read<UserCubit>().fetchUser();
    //  })
    context.read<UserCubit>().fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.userStatus == UserStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.userStatus == UserStatus.empty) {
            return Center(child: Text("User list is empty"));
          }

          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            itemCount: state.users!.length,
            itemBuilder: (context, index) {
              final user = state.users![index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListTile(
                  title: Text(user.name ?? ' - '),
                  subtitle: Text(user.email ?? ' - '),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    side: BorderSide(color: Colors.black12),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () =>
                            context.read<UserCubit>().deleteUser(user.id ?? ''),
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<UserCubit>(),
                                child: UpdateUserScreen(user: user),
                              ),
                            ),
                          );
                        },
                        child: Icon(Icons.edit, color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
