import 'package:blink/constants.dart';
import 'package:blink/views/screens/auth/signup_screen.dart';
import 'package:blink/views/screens/auth/forget_password_screen.dart';
import 'package:blink/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 150),

              Text(
                'Welcome Back!',
                style: GoogleFonts.acme(fontSize: 34, color: Colors.black87),
              ),

              const SizedBox(height: 30),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: TextInputField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email_outlined,
                  enabled: !_isLoading,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: TextInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock_outline,
                  isObscure: !_isPasswordVisible,
                  enabled: !_isLoading,
                  suffixIcon:
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                  suffixIconOnPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: InkWell(
                  onTap:
                      _isLoading
                          ? null
                          : () async {
                            setState(() => _isLoading = true);
                            await authController.loginUser(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (!mounted) return;
                            // If login failed, stop loading. On success the auth
                            // state listener will navigate away.
                            setState(() => _isLoading = false);
                          },
                  child: Center(
                    child:
                        _isLoading
                            ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              //don't have an account button,create account
              Column(
                children: [
                  //create account
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: InkWell(
                      onTap:
                          _isLoading
                              ? null
                              : () {
                                //send user to create account screen
                                Get.off(() => SignupScreen());
                              },

                      child: Center(
                        child: Text(
                          'Create account',
                          style: TextStyle(
                            fontSize: 19,
                            color: _isLoading ? Colors.grey : Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  //forget password?
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap:
                              _isLoading
                                  ? null
                                  : () {
                                    // Navigate to the forget password screen
                                    Get.to(() => const ForgetPasswordScreen());
                                  },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 7, 53, 153),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
