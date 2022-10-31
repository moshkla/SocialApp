import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var userModel = AppCubit.get(context).userModel;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(
                text: 'Update',
                function: () {
                  cubit.updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                }),
            SizedBox(
              width: 15.0,
            )
          ]),
          body: ConditionalBuilder(
            condition: state is! AppGetUserLoadingState,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is AppUserUpdateLoadingState)
                      LinearProgressIndicator(),
                    if (state is AppUserUpdateLoadingState)
                      SizedBox(
                        height: 5,
                      ),
                    Container(
                      height: 190.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${userModel.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16.0,
                                      )),
                                  onPressed: () {
                                    cubit.getCoverImage();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    )),
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (cubit.profileImage != null ||
                        cubit.coverImage != null)
                      Row(
                        children: [
                          if (cubit.profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: () {
                                      cubit.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    btnText: 'upload profile',
                                  ),
                                  if (state is AppUserUpdateLoadingState)
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  if (state is AppUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (cubit.coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: ()
                                    {
                                      cubit.uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    btnText: 'upload cover',
                                  ),
                                  if (state is AppUserUpdateLoadingState)
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  if (state is AppUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (cubit.profileImage != null ||
                        cubit.coverImage != null)
                      SizedBox(
                        height: 20.0,
                      ),
                    defaultFormField(
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Name Required';
                        }
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Bio Required';
                        }
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      controller: bioController,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Phone Required';
                        }
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call,
                      controller: phoneController,
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
