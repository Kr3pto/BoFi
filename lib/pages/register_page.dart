import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning/components/my_button.dart';
import 'package:learning/components/my_text_field.dart';
import 'package:learning/components/squareTile.dart';
import 'package:learning/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  //sign user Up
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try creating the user
    try {
      //check if password is confirmed
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // show error message,password don't match
        showErrorMessage("Passwords don't match!");
      }

      //pop the loading button
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //wrong email
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //error message to user
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                //logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(
                  height: 25,
                ),

                //Let's create an account for you
                const Text(
                  "Let's create an account for you!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //Email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Enter your Email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 30,
                ),
                //password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Enter your Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 30,
                ),

                //confirm password

                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm your Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 25,
                ),

                //sign up button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),

                const SizedBox(
                  height: 25,
                ),

                //or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 70, 70, 70),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or continue with",
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Color.fromARGB(255, 70, 70, 70),
                        ),
                      ),
                    ],
                  ),
                ),
                //google + apple signin

                const SizedBox(
                  height: 50,
                ),
                // google button
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SquareTile(
                    onTap: () => AuthService().signInWithGoogle(),
                    imagePath: 'lib/images/google.png',
                  ),

                  const SizedBox(
                    width: 10,
                  ),
                  //apple button
                  SquareTile(onTap: () {}, imagePath: 'lib/images/apple.png'),
                ]),

                const SizedBox(
                  height: 50,
                ),

                //not a member,register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style:
                          TextStyle(color: Color.fromARGB(255, 108, 108, 108)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
