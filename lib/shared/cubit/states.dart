abstract class AppStates {}

class AppInitialStates extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;

  AppGetUserErrorState(this.error);
}

class AppGetAllUsersLoadingState extends AppStates {}

class AppGetAllUsersSuccessState extends AppStates {}

class AppGetAllUsersErrorState extends AppStates {
  final String error;

  AppGetAllUsersErrorState(this.error);
}

class AppGetPostsLoadingState extends AppStates {}

class AppGetPostsSuccessState extends AppStates {}

class AppGetPostsErrorState extends AppStates {
  final String error;

  AppGetPostsErrorState(this.error);
}

class AppChangeBottonNavBarState extends AppStates {}

class AppAddPostNavBarState extends AppStates {}

class AppProfileImageSuccessState extends AppStates {}

class AppProfileImageErrorState extends AppStates {}

class AppUploadProfileImageSuccessState extends AppStates {}

class AppUploadProfileImageErrorState extends AppStates {}

class AppCoverImageSuccessState extends AppStates {}

class AppCoverImageErrorState extends AppStates {}

class AppUploadCoverImageSuccessState extends AppStates {}

class AppUploadCoverImageErrorState extends AppStates {}

class AppUserUpdateErrorState extends AppStates {
  final String error;

  AppUserUpdateErrorState(this.error);
}

class AppUserUpdateLoadingState extends AppStates {}

class AppCreatePostLoadingState extends AppStates {}

class AppCreatePostSuccessState extends AppStates {}

class AppCreatePostErrorState extends AppStates {}

class AppPostImageSuccessState extends AppStates {}

class AppPostImageErrorState extends AppStates {}

class AppRemovePostImageState extends AppStates {}

class AppLikePostSuccessState extends AppStates {}

class AppLikePostErrorState extends AppStates {
  final String error;

  AppLikePostErrorState(this.error);
}

class AppCommentPostSuccessState extends AppStates {}

class AppCommentPostErrorState extends AppStates {
  final String error;

  AppCommentPostErrorState(this.error);
}

//chats
class AppSendMessageSuccessState extends AppStates {}

class AppSendMessageErrorState extends AppStates {}

class AppGetMessagesSuccessState extends AppStates {}