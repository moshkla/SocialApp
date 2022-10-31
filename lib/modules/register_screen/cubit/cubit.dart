import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/modules/register_screen/cubit/states.dart';
import 'package:social/shared/components/components.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String? email,
    required String? password,
    required String? name,
    required String? phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: '$email', password: '$password')
        .then((value) {
              userCreate(
                  email: '$email',
                  name: '$name',
                  phone: '$phone',
                  uId: '${value.user!.uid}');
            })
        .catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error));
    });
  }

  void userCreate({
    required String? email,
    required String? name,
    required String? phone,
    required String? uId,
  }) {
    emit(SocialUserCreateLoadingState());
    SocialUserModel model =
        SocialUserModel(
            email: email,
            name: name,
            phone: phone,
            image: 'https://i.stack.imgur.com/l60Hf.png',
            cover: 'https://cdn.statically.io/img/codetheweb.blog/assets/img/posts/css-advanced-background-images/cover.jpg?f=webp&w=720',
            bio: 'write your bio ...',
            isEmailVerified:false,
            uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialUserCreateSuccessState());
    }).catchError((error) {
      emit(SocialUserCreateErrorState(error.toString()));
    });
  }
}
