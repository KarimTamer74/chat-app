import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatapp/cubits/login_cubit/login_cubit.dart';
import 'package:chatapp/cubits/login_cubit/login_states.dart';
import 'package:chatapp/helper/helper.dart';
import 'package:chatapp/shared_widgets/custom_submit.dart';
import 'package:chatapp/shared_widgets/custom_text_form_field.dart';
import 'package:chatapp/shared_widgets/custom_title.dart';
import 'package:chatapp/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false; //to show loading indicator if network was slow

  String? email,
      password; // to accept email and pass from user and create an account

  GlobalKey<FormState> formKey =
      GlobalKey(); //to use Form() widget and validate TextFormField()

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.push(
            context,
            PageTransition(
                curve: Curves.bounceIn,
                type: PageTransitionType.leftToRightWithFade,
                child: ChatPage(),
                duration: Duration(milliseconds: 800)),
          );
          Duration(seconds: 5);
          showSnackBar(context, 'Successfully logined ✔️');
        } else if (state is LoginFailureState) {
          isLoading = false;
          showSnackBar(context, state.errorMassage!);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          //ModalProgressHUD >>- packdge to show loading indicator
          inAsyncCall: isLoading, // required with ModalProgressHUD
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 4, 24, 40),
            body: Form(
              key: formKey, //required with Form()
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView(children: [
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(kLogo),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Color.fromARGB(236, 176, 203, 216),
                        fontSize: 24,
                        fontFamily: 'Pacifico-Regular',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TitleWidget(title: 'Login'),
                  CustomTextFormField(
                    obscureText: false,
                    hint: 'Enter your Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  CustomTextFormField(
                    obscureText: true,
                    hint: 'Enter your Password',
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  CustomSubmit(
                      text: '  Sign in',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<UserLoginCubit>(context)
                              .userLogin(email!, password!);
                        }
                      }),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'don\'t have an account?  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Color(0xFF2196F3)),
                      ),
                    )
                  ]),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
