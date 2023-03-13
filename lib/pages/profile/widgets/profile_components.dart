import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../chat/widgets/group_chat_list.dart';

HeaderInfo(String userName, context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 300,
    child: Center(
      child: SizedBox(
        height: 300,
        width: 1000,
        child: Padding(
          padding: const EdgeInsets.only(left: 50, top: 25, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Min Side'),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(ChatList());
                        },
                        child: const Text("Logg ut"))
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipOval(
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fprofile-circle-icon-512x512-dt9lf8um.png?alt=media&token=6b6eec31-abc3-43ad-ba01-69b374731ba9')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$userName',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.email.toString(),
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

minSide(double width, double height) {
  return Flexible(
    child: Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Column(
        children: const [Text('Endre profil')],
      ),
    ),
  );
}

favoritter(double width, double height) {
  return Flexible(
    child: Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Column(
        children: const [Text('Favoritter')],
      ),
    ),
  );
}

mineAnnonser(double width, double height) {
  return Flexible(
    child: Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Column(
        children: [Text('Mine annonser')],
      ),
    ),
  );
}
