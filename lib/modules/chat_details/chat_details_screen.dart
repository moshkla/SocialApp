import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel? userModel;

  ChatDetailsScreen({Key? key, this.userModel}) : super(key: key);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMessages(receiverId: userModel!.uId);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('${userModel!.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: AppCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            {
                              var message =
                                  AppCubit.get(context).messages[index];

                              if (AppCubit.get(context).userModel!.uId ==
                                  message.senderId)
                                return buildMyMessage(message);

                              return buildMessage(message);
                            }
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15.0,
                              ),
                          itemCount: AppCubit.get(context).messages.length),
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type message here ..',
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  AppCubit.get(context).sendMessage(
                                      reciverId: userModel!.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text('${model.text}')),
    );

Widget buildMyMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        child: Text(model.text.toString()),
      ),
    );
