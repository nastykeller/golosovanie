import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jkh/auth/index.dart';
import 'package:jkh/login/index.dart';
import 'voting/index.dart';

const String ROOT_URL = 'http://192.168.0.109:8000';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOловосание',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        backgroundColor: Colors.blue[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
          create: (context) => AuthBloc(UnAuthState()), child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnAuthState) {
          return LoginPage();
        }
        if (state is InAuthState) {
          return MultiBlocProvider(providers: [
            BlocProvider<VotingCubit>(
                create: (context) => VotingCubit()..loadAllVotings())
          ], child: VotingPage());
        }
      },
    );
  }
}
