import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_app/product_guid_page.dart';
import 'package:grocery_app/screen/forgot_page.dart';
import 'package:grocery_app/screen/sign_up_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 600;
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Email/Username field
                      SizedBox(
                        width: isTablet ? 400 : double.infinity,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            } else if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Password field
                      SizedBox(
                        width: isTablet ? 400 : double.infinity,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: obscureText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      SizedBox(height: 10),
                      // "Forgot Password?" link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Login Button
                      SizedBox(
                        width: isTablet ? 300 : double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Perform login
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductGridPage(),
                                  ),
                                );
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Sign Up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
