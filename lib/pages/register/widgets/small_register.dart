import 'package:flutter/material.dart';
import 'package:webdesign/pages/register/widgets/large_register.dart';

class SmallRegister extends StatelessWidget {
  const SmallRegister({super.key});

  @override
  Widget build(BuildContext context) {
    // Creates a visual scaffold for Material Design widgets.
    return Scaffold(
      // Container decorated with an image for the background.
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fbakgrunn.png?alt=media&token=5dec6ed3-4f53-469f-bf00-9d094e25cf07'),
                // The image will cover the screen.
                fit: BoxFit.cover)),
                // The same registerbox is used for the small and bix screen.
        child: RegisterBox(),
      ),
    );
  }
}
