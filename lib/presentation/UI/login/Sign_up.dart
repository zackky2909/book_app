// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_register/bloc/signup/signup_bloc.dart';
import 'package:test_register/presentation/widgets/button.dart';
import 'package:test_register/presentation/widgets/snackbar.dart';
import 'package:test_register/repository/user_repository.dart';
import 'package:test_register/setup/constant.dart';

class SignUp extends StatefulWidget {
  final UserRepository _userRepository;
  static String routeName = 'SignUp';

  SignUp({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool notVisible = false;
  final keys = GlobalKey<FormState>();
  late SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    emailController.addListener(() {
      _signupBloc.add(SignupEmailChange(email: emailController.text));
    });
    passwordController.addListener(() {
      _signupBloc.add(SignupPasswordChange(password: passwordController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignUpState>(
      listener: (context, signupstate) {
        if (signupstate.isFailure) {
          CustomSnackbar.show(context, 'Sign in Fail');
        }
      },
      child: BlocBuilder<SignupBloc, SignUpState>(
        builder: (context, signupstate) {
          if (signupstate.isFailure) {
          } else if (signupstate.isSubmitting) {
            return Container(
                color: color3,
                child: Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 3, color: color1)));
          } else if (signupstate.isSuccess) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, 'AskName');
            });
          }
          return Scaffold(
            backgroundColor: color3,
            appBar: AppBar(
              title: Text('Sign up',
                  style: TextStyle(
                      color: color1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              leading: Icon(Icons.arrow_back),
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
                          key: keys,
                          child: Column(children: [
                            TextFormField(
                              validator: (value) => signupstate.isValidEmail
                                  ? null
                                  : 'Invalid Email',
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
                              validator: (value) => signupstate.isValidPassword
                                  ? null
                                  : 'Password too short',
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
                        TextFormField(
                          validator: (value) {
                            if (value == passwordController.text) {
                              return null;
                            } else {
                              return 'Password not identical';
                            }
                          },
                          controller: confirmpasswordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: !notVisible,
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              labelText: 'Re-enter Password',
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
                                            color: color1.withOpacity(0.5))),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 1.5, color: color1.withOpacity(0.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(width: 1.5, color: color1))),
                        ),
                        SizedBox(height: 100),
                        BottomButton(
                          press: () async {
                            _signupBloc.add(SignupButtonPressed(
                                email: emailController.text,
                                password: passwordController.text));
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              Navigator.pushReplacementNamed(
                                  context, 'AskName');
                            });
                          },
                          color: color1,
                          text: 'Continue',
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
