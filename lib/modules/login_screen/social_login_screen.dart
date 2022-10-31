

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/social_home_layout.dart';
import 'package:social/modules/login_screen/cubit/cubit.dart';
import 'package:social/modules/register_screen/social_register_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/network/local/cashe_helper.dart';

import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) =>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (BuildContext context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              msg: state.error,
              state: ToastStates.ERROR,
            );
          }
          if(state is SocialLoginSuccessState)
          {
            CasheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value)
            {
              navigateAndFinish(
                context,
                SocailHomeLayout(),
              );
            });
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'login now to communicate with Friends',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            onTap: () {
                              print('email taped');
                            }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outlined,
                            suffix: true?Icons.visibility_outlined:Icons.visibility_off,
                            suffixPressed: () {
                              // cubit.changePassShow();
                            },
                            onSubmit: (value) {
                              // if (formKey.currentState!.validate()) {
                              //   cubit.userLogin(
                              //       email: emailController.text,
                              //       password: passwordController.text);
                              // }
                            },
                            onTap: () {
                              print('password taped');
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) {
                            return defaultButton(
                                btnText: 'login',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }

                                },
                                toUppercase: true);
                          },
                          fallback: (context) =>
                              Center(child: const CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t Have Account'),
                            defaultTextButton(
                                text: 'REGISTER',
                                function: () {
                                   navigateTo(context, SocialRegisterScreen());
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );

  }
}
