import 'package:firebase_auth/firebase_auth.dart';
import 'package:idea_list/api/idea_api.dart';
import 'package:idea_list/api/user_api.dart';
import 'package:idea_list/view_model/auth_model.dart';
import 'package:idea_list/view_model/idea_list_model.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  Provider<IdeaApi>.value(
    value: IdeaApi(),
  ),
  Provider<UserApi>.value(
    value: UserApi(),
  ),
  ProxyProvider<UserApi, AuthModel>(
    builder: (_, userApi, __) => AuthModel(userApi),
  ),
  ChangeNotifierProxyProvider<IdeaApi, IdeaListModel>(
    builder: (_, ideaApi, __) => IdeaListModel(ideaApi),
  ),
  StreamProvider<FirebaseUser>.value(
    value: AuthModel.authUser$,
  ),
];
