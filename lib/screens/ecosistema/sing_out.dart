import 'package:flutter/material.dart';
import 'package:rive_animation/screens/ecosistema/inicial_screen.dart';

class singout_screen extends StatefulWidget {
  const singout_screen({Key? key}) : super(key: key);

  @override
  State<singout_screen> createState() => _singout_screenState();
}

class _singout_screenState extends State<singout_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: Text("Logout"),
          onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => IntroductionScreen()));
          },

        ),

      ),
    );
  }
}
