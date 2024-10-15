import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // Method to handle password reset
  void sendPasswordResetEmail() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset link sent to your email!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back to login screen after success
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else {
          errorMessage = 'An error occurred. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your email to reset your password',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                // Email Input Field
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Send Password Reset Email Button
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: sendPasswordResetEmail,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Send Reset Link',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
