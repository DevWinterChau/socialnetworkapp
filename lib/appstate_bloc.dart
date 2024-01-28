import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialnetworkapp/providers/bloc_provider.dart';

enum  AppState {loading, unAuthorized, authorized, registerAccount}

class AppStateBloc implements BlocBase{
  final _appState = BehaviorSubject<AppState>.seeded(AppState.loading);

  Stream<AppState> get appStateBloc => _appState.stream;

  AppState get appStateValue => _appState.stream.value;

  AppState get initState => AppState.loading;


  String langCode = 'en';

  AppStateBloc(){
    launchApp();
  }

  Future<void> launchApp() async{
    final prefs = await SharedPreferences.getInstance();
    final authorlevel = prefs.getInt("authorized") ?? 0;
    switch(authorlevel){
      case 2:
        await changeAppState(AppState.authorized);
        break;
      case 3:
        await changeAppState(AppState.registerAccount);
        break;
      default:
        await changeAppState(AppState.unAuthorized);
    }
  }

  Future<void> changeAppState(AppState appState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("authorized", appState.index);
    print('đã thay đổi');
    _appState.sink.add(appState);
    print(appStateValue);
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await changeAppState(AppState.unAuthorized);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _appState.close();
  }}