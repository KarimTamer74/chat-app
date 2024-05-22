import 'package:chatapp/cubits/register_cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRegisterCubit extends Cubit<RegisterState> {
  UserRegisterCubit() : super(RegisterInitialState());
}
