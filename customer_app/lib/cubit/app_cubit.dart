import 'package:bloc/bloc.dart';
import 'package:customer_app/models/shared_preferences/shared_preferences_model.dart';
import 'package:customer_app/service/base_service.dart';
import 'package:customer_app/service/service_path.dart';
import 'package:customer_app/widgets/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'app_state.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(InitialState()) {
    appIntroductionHandler();
  }

  /// Initial State
  void introduce() {
    emit(FirstOpenState());
  }

  Future<void> authenticate() async {
    String? currentToken = await SharedPref.read(SharedPrefPath.token);
    if (currentToken != null && !isTokenExpired(currentToken)) {
      emit(AuthenticatedState());
    }
  }

  void timeout(BuildContext context) {
    emit(TimedOutState());
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  void unAuthenticate() {
    emit(UnauthenticatedState());
  }

  void appIntroductionHandler() async {
    final flag = await introductionFlag();
    if (flag) {
      authenticationHandler();
      return;
    }
    introduce();
  }

  void authenticationHandler() async {
    var tokenInDate = await checkToken();
    if (tokenInDate) {
      authenticate();
      return;
    }
    var refreshTokenInDate = await checkRefreshToken();
    if (refreshTokenInDate) {
      String currentRefreshToken =
          await SharedPref.read(SharedPrefPath.refreshToken);
      var newToken = await getToken(currentRefreshToken);
      if (newToken != null) {
        SharedPref.save(SharedPrefPath.token, newToken);
        authenticate();
        return;
      }
    }
    unAuthenticate();
  }

  /// Support Function
  Future<bool> checkToken() async {
    String? currentToken = await SharedPref.read(SharedPrefPath.token);
    if (currentToken != null && !isTokenExpired(currentToken)) {
      return true;
    }
    return false;
  }

  Future<bool> checkRefreshToken() async {
    String? currentRefreshToken =
        await SharedPref.read(SharedPrefPath.refreshToken);
    if (currentRefreshToken != null && !isTokenExpired(currentRefreshToken)) {
      return true;
    }
    return false;
  }

  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  Future<bool> introductionFlag() async {
    bool? opened = await SharedPref.read(SharedPrefPath.introductionFlag);
    if (opened == true) {
      return true;
    }
    return false;
  }

  void markIntroductionFlag() async {
    await SharedPref.save(SharedPrefPath.introductionFlag, true);
    unAuthenticate();
  }

  void logout() {
    clearToken();
    unAuthenticate();
  }

  void kick() {
    clearToken();
    unAuthenticate();
  }

  void warnUser(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CustomBtnAlertDialog(
              title: "Phiên đăng nhập hết hạn",
              content:
                  "Phiên đăng nhập của bạn đã hết hạn.\nVui lòng đăng nhập lại để tiếp tục.",
              buttonTitle: "OK",
              context: context,
            ));
  }

  Future<String?> getToken(String refreshToken) async {
    // TODO: Get token by refresh token
    return null;
  }

  void clearToken() {
    SharedPref.remove(SharedPrefPath.token);
    SharedPref.remove(SharedPrefPath.refreshToken);
  }
}
