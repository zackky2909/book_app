// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_register/bloc/signin/signin_bloc.dart';
import 'package:test_register/presentation/widgets/Remember.dart';
import 'package:test_register/presentation/widgets/button.dart';
import 'package:test_register/presentation/widgets/snackbar.dart';
import 'package:test_register/repository/user_repository.dart';
import 'package:test_register/setup/constant.dart';

class SignIn extends StatefulWidget {
  final UserRepository _userRepository;
  static String routeName = 'SignIn';
  SignIn({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool notVisible = false;
  final keys = GlobalKey<FormState>();
  late SigninBloc _signinBloc;
  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _signinBloc = BlocProvider.of<SigninBloc>(context);
    emailController.addListener(() {
      _signinBloc.add(SignInEmailChange(email: emailController.text));
    });
    passwordController.addListener(() {
      _signinBloc.add(SignInPasswordChange(password: passwordController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SignInState>(
      listener: (context, signinstate) {
        if (signinstate.isFailure) {
          CustomSnackbar.show(context, 'Sign in Fail');
        }
      },
      child: BlocBuilder<SigninBloc, SignInState>(
        builder: (context, signinstate) {
          if (signinstate.isFailure) {
            print('fail');
          } else if (signinstate.isSubmitting) {
            return Container(
                color: color4,
                child: Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 3, color: color1)));
          } else if (signinstate.isSuccess) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, 'Intro');
            });
          }
          return Scaffold(
            backgroundColor: color3,
            appBar: AppBar(
              title: Text(
                'Sign in',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(height: 120),
                    Column(
                      children: [
                        Form(
                          child: Column(children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  labelText: 'Email',
                                  hintText: 'Enter your email',
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: IconButton(
                                        onPressed: () {
                                          emailController.clear();
                                        },
                                        icon: emailController.text.isEmpty
                                            ? Icon(Icons.email_rounded,
                                                color: color1.withOpacity(0.5))
                                            : Icon(Icons.close,
                                                color:
                                                    color1.withOpacity(0.5))),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: color1.withOpacity(0.5)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 1.5, color: color1))),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: !notVisible,
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  labelText: 'Password',
                                  hintText: 'At least 8 characters',
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            notVisible = !notVisible;
                                          });
                                        },
                                        icon: notVisible
                                            ? Icon(Icons.visibility,
                                                color: color1.withOpacity(0.5))
                                            : Icon(Icons.visibility_off,
                                                color:
                                                    color1.withOpacity(0.5))),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: color1.withOpacity(0.5)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 1.5, color: color1))),
                            ),
                          ]),
                        ),
                        SizedBox(height: 20),
                        RowRemember(),
                        SizedBox(height: 100),
                        BottomButton(
                          press: () {
                            _signinBloc.add(SignInButtonPressed(
                                email: emailController.text,
                                password: passwordController.text));
                          },
                          color: color1,
                          text: 'Continue',
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text('or sign in with',
                        style: TextStyle(
                            fontSize: 14, color: color1.withOpacity(0.5))),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildSocialButton(
                            child: SvgPicture.asset(
                                'assets/icons/facebook-2.svg')),
                        buildSocialButton(
                            child: SvgPicture.asset(
                                'assets/icons/google-icon.svg')),
                        buildSocialButton(
                            child:
                                SvgPicture.asset('assets/icons/twitter.svg')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSocialButton({required Widget child}) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color4,
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: child,
      ),
    );
  }
}
