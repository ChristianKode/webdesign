import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeRegister extends StatelessWidget {
  const LargeRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/register_background.jpg'),
                fit: BoxFit.cover)),
        child: RegisterBox(),
      ),
    );
  }
}

class RegisterBox extends StatelessWidget {
  RegisterBox({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 500,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Text(
              'Velkommen',
              style: GoogleFonts.tinos(
                  fontSize: 50, color: const Color.fromRGBO(102, 82, 143, 1.0)),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: SizedBox(
                      child: TextField(
                          decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(102, 82, 143, 1.0),
                                width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        )),
                        hintText: 'Fornavn',
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: SizedBox(
                      child: TextField(
                          decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(102, 82, 143, 1.0),
                                width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        )),
                        hintText: 'Etternavn',
                      )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              child: SizedBox(
                child: TextField(
                  //controller: emailController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(102, 82, 143, 1.0),
                              width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      hintText: 'Epost'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: SizedBox(
                      child: TextField(
                          //controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(102, 82, 143, 1.0),
                                    width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            )),
                            hintText: 'Passord',
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    child: SizedBox(
                      child: TextField(
                          decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(102, 82, 143, 1.0),
                                width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        )),
                        hintText: 'Telefon',
                      )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 160,
              height: 40,
              child: newMethod(),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton newMethod() {
    return ElevatedButton(
                onPressed: () {
                  /*FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);*/
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    backgroundColor: const Color.fromRGBO(102, 82, 143, 1.0)),
                child: const Text(
                  'Lag bruker',
                  style: TextStyle(fontSize: 15),
                ));
  }
}