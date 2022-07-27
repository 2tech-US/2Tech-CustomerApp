import 'package:bloc/bloc.dart';
import 'package:customer_app/cubit/app_cubit.dart';
import 'package:customer_app/models/authenticaton/authentication_model.dart';
import 'package:customer_app/models/shared_preferences/shared_preferences_model.dart';
import 'package:customer_app/service/base_service.dart';
import 'package:customer_app/service/service_path.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<CubitState> {
  AuthenticationCubit() : super(InitialState()) {
    startAuth();
  }

  void startAuth() async {
    LoginRequest loginRequest = LoginRequest(username: "", password: "");
    await getLocalUsername().then((username) {
      loginRequest.username = username ?? "";
    });
    login(loginRequest);
  }

  void login(LoginRequest loginRequest) {
    emit(LoginState(loginRequest));
  }

  void register() {
    emit(RegisterState());
  }

  void forgotPassword() {
    emit(ForgotPasswordState());
  }

  Future<bool> loginValid(LoginRequest loginRequest) async {
    var params = loginRequest.toJson();
    var response = await BaseService.postData(ServicePath.login, params);
    var result = LoginResponse.loginResponse(response);
    if (result == null) return false;
    saveLoginData(loginRequest);
    saveToken(result);
    return true;
  }

  Future<int> registerValid(RegisterRequest registerRequest) async {
    var params = registerRequest.toJson();
    var response = await BaseService.postData(ServicePath.register, params);
    var result = RegisterRequest.registerSuccessful(response);
    return result ?? 404;
  }

  /// Local Storage
  void saveLoginData(LoginRequest loginRequest) {
    SharedPref.save(SharedPrefPath.username, loginRequest.username);
  }

  void saveToken(LoginResponse loginResponse) {
    SharedPref.save(SharedPrefPath.token, loginResponse.token);
    SharedPref.save(SharedPrefPath.refreshToken, loginResponse.refreshToken);
  }

  Future<dynamic> getLocalUsername() async {
    return SharedPref.read("username");
  }
}
