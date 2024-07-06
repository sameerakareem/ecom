import 'dart:convert';
import 'package:ecommerse/utils/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../HomePage.dart';
import '../home.dart';
import '../models/registration_model.dart';
import '../utils/colors.dart';
import 'AuthRepository.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formPass = GlobalKey<FormState>();

  @override
  void dispose() {
    _username.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authRepository: AuthRepository()),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SizedBox(
              height: 300,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Image(
                  image: AssetImage("assets/images/logo.jpg"),
                  height: 280,
                  width: 350,
                ),
              ),
            ),
            const SizedBox(height: 10),
            buildWidget(),
            buildWidgetPass(),
            const SizedBox(height: 10),
            buttonLogin(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildWidget() {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: TextFormField(
          controller: _username,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 20.0),
            hintText: "Enter User Name",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter User Name';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildWidgetPass() {
    return Form(
      key: _formPass,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        child: TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20.0),
              hintText: "Enter Password"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Password';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buttonLogin() {
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50, top: 5),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            AppController.saveIsLogged(true);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => Home(),
              ),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return MaterialButton(
            elevation: 5,
            color: buttonColor,
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false &&
                  (_formPass.currentState?.validate() ?? false)) {
                BlocProvider.of<LoginBloc>(context).add(
                  LoginButtonPressed(
                    username: _username.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: state is LoginLoading
                ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
                : const Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
