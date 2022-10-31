import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/social_home_layout.dart';
import 'package:social/shared/bloc_observer.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/network/local/cashe_helper.dart';
import 'package:social/shared/styles/themes.dart';

import 'modules/login_screen/social_login_screen.dart';

void main() async {
  Widget widget;
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CasheHelper.init();
  uId = CasheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = SocailHomeLayout();
  } else {
    widget = SocialLoginScreen();
  }
  BlocOverrides.runZoned(
        () {
      // Use cubits...
      runApp(MyApp(startWidget: widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({Key? key, this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home: startWidget,
            );
          }),
    );
  }
}
