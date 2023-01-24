import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final navLinks = ["Jobb", "Chat"];

  List<Widget> navItem(){
    return navLinks.map((text){
    return Padding(
      padding: EdgeInsets.only(left: 18),
      child: Text(text),
    );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset("/images/UngLogo.png"),
                ),
                const SizedBox(
                  width: 16,
                ),
                const   DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Text("UngAnsatt"),
                )
            ],
          ),
        ],
      ),
    );
  }
}