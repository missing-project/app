import 'package:missing_application/models/auth_model.dart';
import 'package:missing_application/models/case_model.dart';
import 'package:missing_application/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  User currentUser = User.empty;
  List<Case> bookmarks = [];
  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  Future signIn(String id, String password) async {
    final rsp = await AuthService.login(id, password);
    final SharedPreferences prefs = await _prefs();
    prefs.setString(PreferencesKey.accesstoken, rsp['accessToken']);
    prefs.setString(PreferencesKey.refreshtoken, rsp['refreshToken']);
    currentUser = User.fromJson(rsp['user']);
  }

  Future<bool> signInAuto() async {
    final SharedPreferences prefs = await _prefs();
    final token = prefs.getString(PreferencesKey.refreshtoken) ?? '';
    if (token.isNotEmpty && token != 'null') {
      final rsp = await AuthService.loginRemember();
      currentUser = User.fromJson(rsp['user']);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> idCheck(String id) async {
    final rsp = await AuthService.checkIdDuplicate(id);
    return rsp['isUsable'];
  }

  Future<String?> idSearch(String email) async {
    final rsp = await AuthService.searchIdByEmail(email);
    return rsp['id'];
  }

  Future<String> emailCheck(String email) async {
    final rsp = await AuthService.sendEmailAuthizationCode(email);
    return rsp['code'].toString();
  }

  Future signUp(String id, String email, String password) async {
    await AuthService.createUser(id, email, password);
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

  Future logout() async {
    final SharedPreferences prefs = await _prefs();
    prefs.remove(PreferencesKey.accesstoken);
    prefs.remove(PreferencesKey.refreshtoken);
    currentUser = User.empty;
    bookmarks = [];
  }

  Future signout() async {
    await AuthService.deleteMe();
  }

  Future userInfoChange(Map<String, dynamic> userInfo) async {
    await AuthService.changeUserInfo(userInfo);
  }

  Future resetPassword(String uid, String email) async {
    await AuthService.resetPassword(uid, email);
  }

  Future changePassword(String prev, String curr) async {
    await AuthService.changePassword(prev, curr);
  }
}
