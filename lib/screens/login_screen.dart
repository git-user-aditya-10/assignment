import 'package:assingment/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SingleChildScrollView(
            child: Column(
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.yellow
                      ),
                      child: Stack(
                          children: [
                            Positioned(
                              bottom:60,
                                left: 20,
                                child: Text("Hello",
                                  style: TextStyle(color: Colors.brown[600], fontSize: 40,fontWeight: FontWeight.bold),
                                ),
                            ),
                            Positioned(
                              bottom:10,
                              left: 20,
                              child: Text("LOGIN HERE....",
                                style: TextStyle(color: Colors.brown[800], fontSize: 40,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Form(
                          key:controller.formkey,
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: controller.emailctrl,
                                decoration: InputDecoration(
                                  label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                  ),
                                  hintText: 'Enter your Email',
                                ),
                                validator: (val) => val == null || val.isEmpty ? "Enter Email" : null,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: controller.passctrl,
                                decoration: InputDecoration(
                                  label: Text("Password",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                                ),
                                  hintText: 'Enter your Password'
                              ),
                                validator: (val) => val == null || val.isEmpty ? "Enter password" : null,
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(value: controller.rememberme.value, onChanged: (value) {
                                  setState(() {
                                    controller.rememberme.value;
                                  });
                                },
                                  activeColor: Colors.yellow,
                                  checkColor: Colors.brown,
                                ),
                                Text("Remember me", style: TextStyle(color: Colors.brown),),
                                Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("Forgot Password?", style: TextStyle(color: Colors.brown)),
                                ),
            
                              ],
                            ),
                            SizedBox(height: 20,),
                            const SizedBox(height: 20,),
                            Obx(() => controller.loading.value
                                ? const CircularProgressIndicator(
                              color: Colors.brown,
                            )
                                :  SizedBox(
                              width: 400,
                              child: ElevatedButton(
                                onPressed: controller.tryLogin,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  backgroundColor: Colors.brown[400],
                                  foregroundColor: Colors.yellow
                                ),
                                child: const Text("Login"),
                              ),
                            )
                            ),
                            SizedBox(height: 30,),
                          ]
                        ))
                      ),
                    )
                  ],
            ),
          ),
    );
  }
}
