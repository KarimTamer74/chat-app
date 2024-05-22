import 'package:bloc/bloc.dart';
import 'package:chatapp/cubits/login_cubit/login_states.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(LoginInitialState());
}
