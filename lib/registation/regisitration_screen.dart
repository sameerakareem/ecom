import 'package:ecommerse/registation/regisitration_bloc.dart';
import 'package:ecommerse/registation/regisitration_event.dart';
import 'package:ecommerse/registation/regisitration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../login/login_screen.dart';
import '../utils/colors.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RegistrationBloc(),
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else if (state is RegistrationFailure) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Registration Failed'),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Back',
                                style: GoogleFonts.poppins(
                                    fontSize: 14.px, color: buttonColor),
                              ),
                              Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                    fontSize: 14.px, color: buttonColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Create an account',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30.px),
                            ),
                          ),
                          const SizedBox(height: 30),
                          CreateAccountWidget(
                            label: 'Name',
                            hintText: 'Name',
                            controller: nameController,
                          ),
                          const SizedBox(height: 30),
                          CreateAccountWidget(
                            label: 'Email',
                            hintText: 'Email *',
                            controller: emailController,
                          ),
                          SizedBox(height: 30),
                          CreateAccountWidget(
                            label: 'Password',
                            hintText: 'Password *',
                            controller: passwordController,
                          ),
                          SizedBox(height: 30),
                          TextButton(
                            onPressed: state is RegistrationLoading
                                ? null
                                : () {
                              BlocProvider.of<RegistrationBloc>(context)
                                  .add(RegistrationSubmitted(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: state is RegistrationLoading
                                    ? Colors.grey
                                    : buttonColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: state is RegistrationLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                'CREATE ACCOUNT',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CreateAccountWidget extends StatelessWidget {
  const CreateAccountWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.3)),
        contentPadding: EdgeInsets.all(10),
      ),
    );
  }
}
