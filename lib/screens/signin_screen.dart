import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tazkira/constants/constants.dart';
import 'package:tazkira/logic/auth/auth_cubit.dart';
import 'package:tazkira/routing/routes.dart';
import 'package:tazkira/widgets/main_elevated_button.dart';
import 'package:tazkira/widgets/main_segmented_button.dart';
import 'package:tazkira/widgets/main_text_form_field.dart';


class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {
                  if (state is AuthSuccessState){
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.homeScreen,
                    );
                  } else if (state is AuthErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errMessage,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  bool isPasswordVisible = state is PasswordVisibilityState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      mainSegmentedButton(context),
                      SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        tazkaroLogo,
                        height: 80,
                      ),
                      Text(
                        'Tazkira App',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'An easy way to write and organize your notes and ideas.',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      mainTextFormField(
                        controller: emailController,
                        labelText: 'Email',
                        prefixIcon: Icon(
                          FontAwesomeIcons.envelopeCircleCheck,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      mainTextFormField(
                        obscureText: !isPasswordVisible,
                        controller: passwordController,
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<AuthCubit>()
                                .togglePasswordVisibilityIcon();
                          },
                          icon: Icon(
                            isPasswordVisible ? FontAwesomeIcons.lockOpen : FontAwesomeIcons.lock,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      mainElevatedButton(
                        text: 'Sign In',
                        onPressed: () {
                          context.read<AuthCubit>().signIn(
                              email: emailController.text,
                              password: passwordController.text,
                          );
                        },
                      ),
                      SizedBox(height: 20,),
                      mainElevatedButton(
                        text: 'Sign In with Google',
                        icon: FontAwesomeIcons.squareGooglePlus,
                        onPressed: () {
                          context.read<AuthCubit>().signInWithGoogle();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account!',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'SignUp',
                              style: TextStyle(
                                color: Color(0xff003A61),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
