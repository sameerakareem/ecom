


import 'package:ecommerse/splash_page.dart';
import 'package:ecommerse/themes/theme_provider.dart';
import 'package:ecommerse/utils/AppRoutes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'E Commerce ',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: _registerRoutes(context),
      initialRoute: AppRoutes.splash,
    );
  }

  Map<String, WidgetBuilder> _registerRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      AppRoutes.splash: (context) => SplashPage(),
     // AppRoutes.login: (context) => _buildLoginBloc(context),
     // AppRoutes.register: (context) => _buildRegister(context),
    };
  }

  // BlocProvider<LoginBloc> _buildLoginBloc(BuildContext context) {
  //   return BlocProvider<LoginBloc>(
  //     create: (context) => LoginBloc(userDetailsDao:_userDetailsDao),
  //     child: const LoginPage(),
  //   );
  // }
  // BlocProvider<RegistrationBloc> _buildRegister(BuildContext context) {
  //   return BlocProvider<RegistrationBloc>(
  //     create: (context) => RegistrationBloc(_userDetailsDao),
  //     child:  RegistrationScreen(),
  //   );
  // }



}





