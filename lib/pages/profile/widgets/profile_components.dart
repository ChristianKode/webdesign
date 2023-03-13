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

minSide(
  double width,
  double height,
) {
  bool onHover = false;
  return Flexible(
    child: InkWell(
      onTap: () {},
      onHover: (value) => {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          color: Colors.white,
        ),
        width: width,
        height: height,
        child: Row(
          children: [
            const Icon(
              Icons.person_2_outlined,
              color: Colors.blue,
              size: 100,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Endre profil',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('Se og konfigurer dine personlige opplysninger')
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipOval(
                          child: TextButton(
                            onPressed: () {},
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

favoritter(double width, double height) {
  return Flexible(
    child: InkWell(
      onTap: () {},
      onHover: (value) => {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          color: Colors.white,
        ),
        width: width,
        height: height,
        child: Row(
          children: [
            const Icon(
              Icons.favorite_border_outlined,
              color: Colors.blue,
              size: 100,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Favoritter',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('Se dine favoritte oppdrager')
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipOval(
                          child: TextButton(
                            onPressed: () {},
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

mineAnnonser(double width, double height) {
  return Flexible(
    child: InkWell(
      onTap: () {},
      onHover: (value) => {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          color: Colors.white,
        ),
        width: width,
        height: height,
        child: Row(
          children: [
            const Icon(
              Icons.add_business_outlined,
              color: Colors.blue,
              size: 100,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mine oppdrag',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('Se oppdragene dine som ligger ute')
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipOval(
                          child: TextButton(
                            onPressed: () {},
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
