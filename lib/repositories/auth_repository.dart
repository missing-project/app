import 'package:missing_application/models/auth_model.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  User currentUser = User.empty;
  List<Case> bookmarks = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future signIn(String id, String password) async {
    final rsp = await AuthService.login(id, password);
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', rsp['accessToken']);
    currentUser = User.fromJson(rsp['loginUser']);
  }

  Future<bool> signInAuto() async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString('token') ?? '';
    // if (token.isNotEmpty && token != 'null') {
    //   final rsp = await AuthService.getMe();
    //   currentUser = User.fromJson(rsp);
    // }

    return token.isNotEmpty && token != 'null';
  }

  Future<bool> idCheck(String id) async {
    final rsp = await AuthService.checkIdDuplicate(id);
    return rsp['isUsable'];
  }

  Future<String> emailCheck(String email) async {
    final rsp = await AuthService.sendEmailAuthizationCode(email);
    return rsp['code'].toString();
  }

  Future<bool> signUp(String id, String email, String password) async {
    final isSuccess = await AuthService.createUser(id, email, password);
    return isSuccess;
  }

  Future bookmarkGet() async {
    final response = await AuthService.findBookmarks();
    bookmarks = response.map((el) => Case.fromJson(el)).toList();
  }

  Future bookMarkAdd(Case arg) async {
    await AuthService.createBookmark(arg.id);
    bookmarks.add(arg);
  }

  Future bookMarkDel(Case arg) async {
    await AuthService.deleteBookmark(arg.id);
    bookmarks.removeWhere((el) => el.id == arg.id);
  }
}
