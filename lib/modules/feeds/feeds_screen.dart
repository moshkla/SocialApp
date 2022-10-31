import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/post_model.dart';
import 'package:social/modules/comments/comments_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/styles/colors.dart';
import 'package:social/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts!.length > 0 && cubit.userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                          'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                        ),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Communicate with Friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPostItem(cubit.posts![index], context,index),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 8.0,
                        ),
                    itemCount: cubit.posts!.length),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context ,index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        '${AppCubit.get(context).userModel!.image}'
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(height: 1.3),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        size: 16.0,
                      ))
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Container(
              //   padding: EdgeInsetsDirectional.only(
              //     bottom: 10.0,
              //     top: 5.0,
              //   ),
              //   width: double.infinity,
              //   child: Wrap(
              //     children: [
              //       Container(
              //         child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: Text('#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption!
              //                     .copyWith(color: defaultColor))),
              //         height: 25.0,
              //         padding: EdgeInsetsDirectional.only(end: 6.0),
              //       ),
              //       Container(
              //         child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: Text('#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption!
              //                     .copyWith(color: defaultColor))),
              //         height: 25.0,
              //         padding: EdgeInsetsDirectional.only(end: 6.0),
              //       ),
              //       Container(
              //         child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: Text('#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption!
              //                     .copyWith(color: defaultColor))),
              //         height: 25.0,
              //         padding: EdgeInsetsDirectional.only(end: 6.0),
              //       ),
              //       Container(
              //         child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: Text('#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption!
              //                     .copyWith(color: defaultColor))),
              //         height: 25.0,
              //         padding: EdgeInsetsDirectional.only(end: 6.0),
              //       ),
              //       Container(
              //         child: MaterialButton(
              //             onPressed: () {},
              //             minWidth: 1.0,
              //             padding: EdgeInsets.zero,
              //             child: Text('#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption!
              //                     .copyWith(color: defaultColor))),
              //         height: 25.0,
              //         padding: EdgeInsetsDirectional.only(end: 6.0),
              //       ),
              //     ],
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15.0),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: InkWell(
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${AppCubit.get(context).likes![index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '0',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                '${AppCubit.get(context).userModel!.image}'),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Text(
                              'write a comment ... ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.3),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        navigateTo(context, CommentsScreen(index));
                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      AppCubit.get(context).likePost(AppCubit.get(context).postsId![index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
