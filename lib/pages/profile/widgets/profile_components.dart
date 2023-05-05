import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webdesign/core/utils/responsive/theme.dart';
import '../../home/widgets/main_home.dart';


// Header info widget.
// Displays user name, profile picture and log out button.
headerInfo(String userName, context) {
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
                      onPressed: () async {
                        // Signout function with Firebase.
                        // Afterwards the user is sent to the home page.
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LargeHome()));
                      },
                      child: const Text("Logg ut"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      // Round style for the profile picture
                      child: ClipOval(
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/ungansatt123.appspot.com/o/assets%2Fprofile-circle-icon-512x512-dt9lf8um.png?alt=media&token=6b6eec31-abc3-43ad-ba01-69b374731ba9',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Display username, it comes from the profile_view.
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              // Display email, Stored in Firebase plugin.
                              FirebaseAuth.instance.currentUser!.email
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// User Settings Widget
// Min Side page is not created yet.
minSide(double width, double height) {
  return Flexible(
    child: InkWell(
      // This will eventually take the user to the User Settings page.
      onTap: () {},
      onHover: (value) => {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: appColor,
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
              color: appColor,
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
                            child: const Icon(Icons.arrow_forward_ios),
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

// User Favorites Widget
// Favorites page is not created yet.
favoritter(double width, double height) {
  return Flexible(
    child: InkWell(
      // This will eventually take the user to the User Favorites page.
      onTap: () {},
      onHover: (value) => {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: appColor,
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
              color: appColor,
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
                            child: const Icon(Icons.arrow_forward_ios),
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

// Users Ads Widget
// Users Ads page is not created yet.
mineAnnonser(double width, double height) {
  return Flexible(
    child: InkWell(
      // This will eventually take the user to the Users Ads page.
      onTap: () {},
      onHover: (value) => {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: appColor,
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
              color: appColor,
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
                            child: const Icon(Icons.arrow_forward_ios),
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
