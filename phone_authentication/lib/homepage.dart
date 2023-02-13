import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Authentication is successfull',
                style: TextStyle(fontSize: 20, color: Colors.deepPurple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
