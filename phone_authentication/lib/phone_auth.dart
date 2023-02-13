import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/homepage.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController pinController = TextEditingController();
    UserCredential? user;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    Future getPhoneAuth() async {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneController.text,
          timeout: const Duration(seconds: 60),
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            var result =
                await firebaseAuth.signInWithCredential(phoneAuthCredential);
            user = result;
            print("User$user");
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const HomePage()),
                ),
              );
            }
          },
          verificationFailed: ((error) {
            print(error);
          }),
          codeSent: ((verificationId, forceResendingToken) {
            showDialog(
                context: context,
                builder: ((context) {
                  return AlertDialog(
                    title: const Text('Enter the code'),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: pinController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: (() async {
                            var smsCode = pinController.text;
                            PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: smsCode);
                            var result = await firebaseAuth
                                .signInWithCredential(phoneAuthCredential);
                            user = result;
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const HomePage()),
                                ),
                              );
                            }
                          }),
                          child: const Text('Press'),
                        ),
                      ],
                    ),
                  );
                }));
          }),
          codeAutoRetrievalTimeout: ((verificationId) {}));
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    label: Text("Phone Number"),
                    hintText: "Please enter your phone number",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: (() {
                  getPhoneAuth();
                }),
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
