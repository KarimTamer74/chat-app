import 'package:bloc/bloc.dart';
import 'package:chatapp/cubits/login_cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(LoginInitialState());
  Future<void> userLogin(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final auth = FirebaseAuth.instance;
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email')
        emit(LoginFailureState(errorMassage: 'Invalid email address.'));
      else if (e.code == 'wrong-password')
        emit(LoginFailureState(
            errorMassage: 'Wrong password provided for that user.'));
      else {
        emit(LoginFailureState(
            errorMassage: 'Please check the correct email and password.'));
      }
    } catch (e) {
      emit(LoginFailureState(errorMassage: e.toString()));
    }
  }
}
