import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_workshop_tweet_app/design/app_widgets.dart';
import 'package:flutter_workshop_tweet_app/features/auth/bloc/auth_bloc.dart';

class AuthRegisterScreen extends StatefulWidget {
  const AuthRegisterScreen({super.key});

  @override
  State<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = Key('form');

  bool isLogin = true;

  AuthBloc authBloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Container(), title: AppLogoWidget()),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is! AuthActionState,
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthSuccessState) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isLogin) const SizedBox(height: 32),
                  if (!isLogin) Text("Enter your Name"),
                  if (!isLogin)
                    TextFormField(
                      controller: nameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Your Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: "Your Name"),
                    ),
                  const SizedBox(height: 32),
                  Text("Enter your Email"),
                  TextFormField(
                    controller: emailController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Your Email";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(hintText: "Your Email"),
                  ),
                  const SizedBox(height: 32),
                  Text("Enter your Password"),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Your Password";
                      } else {
                        return null;
                      }
                    },
                    decoration:
                        const InputDecoration(hintText: "Your Password"),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          onPressed: () {
                            authBloc.add(AuthenticationEvent(
                                authType: isLogin
                                    ? AuthType.login
                                    : AuthType.register,
                                email: emailController.text,
                                password: passwordController.text));
                          },
                          child: Text(isLogin ? "Login" : "Register"))),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isLogin
                          ? "Dont have an account? "
                          : "Already have an account? "),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          !isLogin ? "Login" : "Register",
                          style: TextStyle(color: Colors.deepPurple.shade200),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
