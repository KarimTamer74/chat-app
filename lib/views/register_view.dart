import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/cubits/register_cubit/register_cubit.dart';
import 'package:chatapp/cubits/register_cubit/register_states.dart';
import 'package:chatapp/helper/helper.dart';
import 'package:chatapp/shared_widgets/custom_submit.dart';
import 'package:chatapp/shared_widgets/custom_title.dart';
import 'package:chatapp/shared_widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password, rewritePass;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserRegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          isLoading = false;
          showSnackBar(context, 'Successfully registered ✔️');
          Navigator.pop(context);
        } else if (state is RegisterFailureState) {
          isLoading = false;
          showSnackBar(context, state.errorMassage!);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: false,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Create account',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2196F3)),
                      ),
                    ),
                    const Text(
                      'Please enter your details',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const TitleWidget(title: 'Your email'),
                    CustomTextFormField(
                      obscureText: false,
                      hint: 'Enter your email',
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TitleWidget(title: 'Password'),
                    CustomTextFormField(
                      obscureText: true,
                      hint: 'Enter your password',
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TitleWidget(title: 'Rewrite password'),
                    CustomTextFormField(
                      obscureText: true,
                      hint: 'Rewrite password',
                      onChanged: (data) {
                        rewritePass = data;
                      },
                    ),
                    CustomSubmit(
                        text: '  Register',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<UserRegisterCubit>(context)
                                .userRigester(
                                    email: email!,
                                    password: password!,
                                    rewritePassword: rewritePass!);
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 238, 241, 243)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'LoginPage');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Color(0xFF2196F3), fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
