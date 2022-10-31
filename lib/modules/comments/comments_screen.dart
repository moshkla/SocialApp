import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';

class CommentsScreen extends StatelessWidget {
  final int index;
  CommentsScreen(this.index, {Key? key}) : super(key: key);
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Comments'),
          ),
          body: Column(
            children: [

             Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultFormField(
                    controller: commentController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Your Name';
                      }
                    },
                    label: 'write a comment !!',
                    prefix: Icons.message,
                  suffix:Icons.arrow_forward,
                  suffixPressed: (){
                      cubit.commentPost(cubit.postsId![index], commentController.text);
                  }
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
