import 'package:develop_world/routes/routes.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Container(
            width: 420,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'email',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'nickname',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          navKey.currentState!.pushNamed(routeHome);
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text(
                          '회원가입',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
