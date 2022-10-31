import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/chats/chats_screen.dart';
import 'package:social/modules/feeds/feeds_screen.dart';
import 'package:social/modules/new_post/new_post_screen.dart';
import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/modules/users/users_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data());
      emit(AppGetUserSuccessState());
      print('user id is : ... ' + userModel!.uId!);
    }).catchError((error) {
      print('الايرور هنا وانت بتجيب اليوزر داتا $error');
      emit(AppGetUserErrorState(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String>? titles = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
      print(users);
    }
    if (index == 2) {
      emit(AppAddPostNavBarState());
    } else {
      currentIndex = index;
      emit(AppChangeBottonNavBarState());
    }
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  // Pick an image
  Future<void> getProfileImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);
      emit(AppProfileImageSuccessState());
    } else {
      print('no image selected');
      emit(AppProfileImageErrorState());
    }
  }

  File? coverImage;

  // Pick an image
  Future<void> getCoverImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverImage = File(image.path);
      emit(AppCoverImageSuccessState());
    } else {
      print('no image selected');
      emit(AppCoverImageErrorState());
    }
  }

  void uploadProfileImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    emit(AppUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(AppUploadProfileImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(AppUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(AppUploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;

  void uploadCoverImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    emit(AppUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(AppUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(AppUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(AppUploadCoverImageErrorState());
    });
  }

  // void updateUserImage({required name, required phone, required bio}) {
  //   if(coverImage !=null){
  //
  //   }else if(profileImage != null){
  //
  //   }else{
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  //
  // }
  void updateUser({
    required name,
    required phone,
    required bio,
    String? image,
    String? cover,
  }) {
    emit(AppUserUpdateLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: userModel!.isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print('الايرور هنا وانت بتupdate اليوزر داتا $error');
      emit(AppUserUpdateErrorState(error.toString()));
    });
  }

  File? postImage;

  // Pick an image
  Future<void> getPostImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      postImage = File(image.path);
      emit(AppPostImageSuccessState());
    } else {
      print('no image selected');
      emit(AppPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(AppRemovePostImageState());
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(AppCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage!.path)
        .pathSegments
        .last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
        print(value);
      }).catchError((error) {
        emit(AppCreatePostErrorState());
      });
    }).catchError((error) {
      emit(AppCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(AppCreatePostLoadingState());
    PostModel model = PostModel(
        name: userModel!.name,
        image: userModel!.image,
        uId: userModel!.uId,
        dateTime: dateTime,
        text: text,
        postImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit((AppCreatePostSuccessState()));
    }).catchError((error) {
      print(error.toString());
      emit(AppCreatePostErrorState());
    });
  }

  List<PostModel>? posts = [];
  List<String>? postsId = [];
  List<int>? likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes!.add(value.docs.length);
          postsId!.add(element.id);
          print(postsId);
          posts!.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });

      emit(AppGetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(AppLikePostSuccessState());
    }).catchError((error) {
      emit(AppLikePostErrorState(error.toString()));
    });
  }

  void commentPost(String? postId, String text) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comment': text,
    }).then((value) {
      emit(AppLikePostSuccessState());
    }).catchError((error) {
      emit(AppLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel>? users = [];

  void getUsers() {
    if (users!.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          users!.add(SocialUserModel.fromJson(element.data()));
        });

        emit(AppGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetAllUsersErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String? reciverId,
    required String? dateTime,
    required String? text,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId: reciverId,
      dateTime: dateTime,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError(() {
      emit(AppSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(AppSendMessageSuccessState());
    }).catchError(() {
      emit(AppSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance.collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots().listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(AppGetMessagesSuccessState());

    });
  }
}
