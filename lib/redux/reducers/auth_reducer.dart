import 'package:redux/redux.dart';
import 'package:flutter_dynamic/redux/models/auth_state.dart';
import 'package:flutter_dynamic/redux/actions/auth_actions.dart';

Reducer<AuthState> authReducer = combineReducers([
  new TypedReducer<AuthState,UserLoginRequest>(userLoginRequestReducer),
  new TypedReducer<AuthState,UserLoginSuccess>(userLoginSuccessReducer),
  new TypedReducer<AuthState,UserLoginFailure>(userLoginFailureReducer),
  new TypedReducer<AuthState,UserLogout>(userLogoutReducer),
  new TypedReducer<AuthState,UserRegisterRequest>(userRegisterRequestReducer),
  new TypedReducer<AuthState,UserRegisterSuccess>(userRegisterSuccessReducer),
  new TypedReducer<AuthState,UserRegisterFailure>(userRegisterFailureReducer),
  new TypedReducer<AuthState,UserCoinSuccess>(userCoinReducer),
]);

AuthState userLoginRequestReducer(AuthState authState,UserLoginRequest request){
  return authState.copyWith(
    isAuthenticated: false,
    isAuthenticating: true
  );
}

AuthState userLoginSuccessReducer(AuthState authState,UserLoginSuccess success){
  return authState.copyWith(
      isAuthenticated: true,
      isAuthenticating: false,
      user: success.user
  );
}

AuthState userLoginFailureReducer(AuthState authState,UserLoginFailure failure){
  return authState.copyWith(
      isAuthenticated: false,
      isAuthenticating: false,
      error: failure.error
  );
}

AuthState userLogoutReducer(AuthState auth, UserLogout action) {
  return new AuthState();
}

AuthState userRegisterRequestReducer(AuthState authState,UserRegisterRequest request){
  return authState.copyWith(
      isAuthenticated: false,
      isRegistering: true
  );
}

AuthState userRegisterSuccessReducer(AuthState authState,UserRegisterSuccess success){
  return authState.copyWith(
      isAuthenticated: true,
      isRegistering: false,
      user: success.user
  );
}

AuthState userRegisterFailureReducer(AuthState authState,UserRegisterFailure failure){
  return authState.copyWith(
      isAuthenticated: false,
      isRegistering: false,
      error: failure.error
  );
}

AuthState userCoinReducer(AuthState authState, UserCoinSuccess action) {
  return authState.copyWith(
    rankData: action.rankData
  );
}