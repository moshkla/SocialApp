import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login_screen/cubit/states.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/network/dio_helper.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '$email',
        password: '$password').then((value){
          emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorState(error));
    });
  }

  bool isSecurePass = true;

  bool changePassShow() {
    emit(SocialLoginChangePassState());
    return isSecurePass = !isSecurePass;
  }
}