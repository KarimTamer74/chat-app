import 'package:chatapp/cubits/register_cubit/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegisterCubit extends Cubit<RegisterState> {
  UserRegisterCubit() : super(RegisterInitialState());

  Future<void> userRigester(
      {required String email,
      required String password,
      required String rewritePassword}) async {
    emit(RegisterLoadingState());
    try {
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (password != rewritePassword) {
        emit(RegisterFailureState(errorMassage: 'Passwords do not match'));
      } else
        emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        emit(RegisterFailureState(
            errorMassage: 'The password provided is too weak.'));
      else if (e.code == 'email-already-in-use')
        emit(RegisterFailureState(
            errorMassage: 'The account already exists for that email.'));
      else
        emit(RegisterFailureState(
            errorMassage: 'an error occured: ' + e.code.toString()));
    } catch (e) {
      emit(RegisterFailureState(
          errorMassage: 'an error occured: ' + e.toString()));
    }
  }
}
