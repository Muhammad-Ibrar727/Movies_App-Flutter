import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.withOpacity(0.1),
          child: Center(
            child: InkWell(
                onTap: () {
                  Navigator.popAndPushNamed(context, 'logIn');
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),

              //scroll view to prevent the overflow in the field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Center(child: Text('Logo')),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Create your new account',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Display name ",
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.2)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Your email",
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.2)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Password",
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.2)),
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Retype password",
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.2)),
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber),
                        child: const Center(
                            child: Text(
                          'Register Now',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Icon(Icons.g_mobiledata),
                              SizedBox(
                                width: 36,
                              ),
                              Text(
                                'Register with google',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              'By registering, you are agreeing to our Terms of use and Privacy Policy.',

                              softWrap: true, // Ensures the text will wrap
                              overflow:
                                  TextOverflow.visible, // Prevents truncation
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
