// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_register/bloc/book/book_bloc.dart';
import 'package:test_register/bloc/bookmark/bookmark_bloc.dart';
import 'package:test_register/bloc/bookshelf/bookshelf_bloc.dart';
import 'package:test_register/bloc/signin/signin_bloc.dart';
import 'package:test_register/presentation/UI/login/Sign_in.dart';
import 'package:test_register/presentation/UI/login/Sign_up.dart';
import 'package:test_register/presentation/UI/login/askname.dart';
import 'package:test_register/presentation/UI/MainScreen/home_screen.dart';
import 'package:test_register/presentation/UI/login/intro.dart';
import 'package:test_register/presentation/UI/MainScreen/maincreen.dart';
import 'package:test_register/presentation/UI/login/splash_screen.dart';
import 'package:test_register/repository/book_repo.dart';
import 'package:test_register/repository/user_repository.dart';
import 'package:test_register/setup/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/Authentication/authenticationbloc_bloc.dart';
import 'bloc/counter/counter_cubit.dart';
import 'bloc/signup/signup_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserRepository userRepository = UserRepository();
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;
  MyApp({Key? key, UserRepository? userRepository})
      : _userRepository = userRepository!,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => UserRepository(),
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      AuthenticationBloc(userRepository: _userRepository)
                        ..add(AuthenticationStart())),
              BlocProvider(
                  create: (context) =>
                      SigninBloc(userRepository: _userRepository)),
              BlocProvider(
                  create: (context) =>
                      SignupBloc(userRepository: _userRepository)),
              BlocProvider(
                  create: (context) =>
                      BookBloc(bookRepo: BookRepo())..add(LoadBook())),
              BlocProvider(
                  create: (context) => BookmarkBloc()..add(BookmarkStart())),
              BlocProvider(
                create: (context) => CounterCubit(),
              ),
              BlocProvider(
                  create: (context) => BookshelfBloc()..add(BookshelfStart())),
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: themeData(),
                routes: {
                  SignUp.routeName: (context) =>
                      SignUp(userRepository: _userRepository),
                  SignIn.routeName: (context) =>
                      SignIn(userRepository: _userRepository),
                  AskName.routeName: (context) => AskName(),
                  Intro.routeName: (context) => Intro(),
                  HomeScreen.routeName: (context) => HomeScreen(),
                  MainScreen.routeName: (context) => MainScreen(),
                },
                home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder:
                        (context, AuthenticationState authenticationState) {
                  if (authenticationState is AuthenticationSuccess) {
                    return MainScreen();
                  } else if (authenticationState is AuthenticationFailure) {
                    return SplashScreen();
                  }
                  return SplashScreen();
                }))));
  }

  ThemeData themeData() {
    return ThemeData(
      fontFamily: 'Muli',
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: color1,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: 'Muli'),
          iconTheme: IconThemeData(color: color1)),
    );
  }
}
