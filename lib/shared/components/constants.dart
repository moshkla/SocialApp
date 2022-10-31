import 'package:social/shared/network/local/cashe_helper.dart';


bool getbool(){
  switch( CasheHelper.getData(key: "isDark") ){
    case true :
      return true;
    case false:
      return false;
    default:
      return true;
  }
}

// void signOut(context){
//   CasheHelper.removeData(key: 'token').then((value){
//     navigateAndFinish(context, ShopLoginScreen());
//     showToast(msg: 'تم ستجيل الخروج بنجاح', state: ToastStates.SUCCESS);
//   });
// }
void printFullText(String text){
  final pattern= RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element)=>element.group(0));
}
String token='';
String uId='';