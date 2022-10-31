import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/new_post/new_post_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SocailHomeLayout extends StatelessWidget {
  const SocailHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppAddPostNavBarState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles![cubit.currentIndex]),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Add Post'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
            BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),
          ],),
        );
        // return ConditionalBuilder(
        //     condition: cubit.model != null,
        //     builder: (context)=>Scaffold(
        //       appBar: AppBar(
        //         title: Text('Home'),
        //       ),
        //       body: Column(
        //         children: [
        //           if(!FirebaseAuth.instance.currentUser!.emailVerified)
        //           Container(
        //             padding: EdgeInsets.symmetric(horizontal: 20.0),
        //             color: Colors.amber.shade400,
        //             child: Row(
        //               children: [
        //                 Icon(Icons.info_outline),
        //                 SizedBox(
        //                   width: 15.0,
        //                 ),
        //                 Expanded(child: Text('verfy Your Email Please')),
        //                 defaultTextButton(
        //                     text: 'SEND',
        //                     function: () {
        //                       FirebaseAuth.instance.currentUser!.sendEmailVerification()
        //                           .then((value) {
        //                             showToast(msg: 'check your Email !!', state: ToastStates.SUCCESS);
        //                       }).catchError((error){
        //
        //                       });
        //                     }),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     fallback: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }
}
