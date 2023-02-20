import 'package:flutter/material.dart';
import 'package:webdesign/pages/register/widgets/large_register.dart';

class SmallRegister extends StatelessWidget {
  const SmallRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fbakgrunn.png?alt=media&token=5dec6ed3-4f53-469f-bf00-9d094e25cf07'),
                fit: BoxFit.cover)),
        child: RegisterBox(),
      ),
    );
  }
}