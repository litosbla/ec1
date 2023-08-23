
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive_animation/screens/entry_point.dart';
import 'package:rive_animation/screens/home/home_screen.dart';

import '../../reusable/reusable_widget.dart';
class singUpScreen extends StatefulWidget {
  const singUpScreen({Key? key}) : super(key: key);

  @override
  State<singUpScreen> createState() => _singUpScreenState();
}

class _singUpScreenState extends State<singUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sing Up",
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
        ) ,
      ),
      body: Container(
        // Puedes personalizar el color aquí
        height: MediaQuery.of(context).size .height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color:  Colors.white,

        ),
        child: SingleChildScrollView(

          child: Column(
            children: [
              _Clipper(context),
              Padding(padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width*0.15
              ),
                child: Column(
                  children: [
                    Text(
                        'Sing IN',
                        style: TextStyle
                          (fontSize: 18.0)
                    ),
                    SizedBox(height: 30,),
                    reusableTextField("Enter Username", Icons.person_outline, false, _userNameController),
                    SizedBox(height: 30,),
                    reusableTextField("Enter email", Icons.person_outline, false, _emailTextController),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    reusableTextField("Enter Password", Icons.lock_outline  , true, _passwordTextController),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    singInSingUpButton(context, false, () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                          password: _passwordTextController.text).then((value){
                            print("Created new Account");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const EntryPoint()));
                      }).onError((error, stackTrace) {print("errorrrrrrr ${error.toString()}");});

                    }),
                    //singUpOption(),
                    Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.1))

                  ],
                ),
              ),
            ],
          ),
        ),



      ),
    );
  }
}
Widget _Clipper(BuildContext context){
  return ClipPath(
    clipper: DoubleCircleClipper(),
    //clipper: DiagonalPathClipperTwo(),
    child: Container(
      height: MediaQuery.of(context).size.height*0.3,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFDD38FF),Color(0xFFFFF358)], begin:Alignment.centerLeft ,end:Alignment.centerRight )
      ),



    ),
  );
}

class DoubleCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Define los radios y las posiciones de las elipses
    double radiusX1 = size.width * 0.5;
    double radiusY1 = size.height * 0.35;
    double radiusX2 = size.width * 0.4;
    double radiusY2 = size.height * 0.45;

    Offset center1 = Offset(size.width * 0.3, 0);
    Offset center2 = Offset(size.width * 0.7,0);

    // Agrega las elipses a la ruta
    path.addOval(Rect.fromCenter(center: center1, width: radiusX1 * 2, height: radiusY1 * 2));
    path.addOval(Rect.fromCenter(center: center2, width: radiusX2 * 2, height: radiusY2 * 2));

    // Agrega los segmentos de línea que conectan las elipses
    path.moveTo(center1.dx + radiusX1, center1.dy);
    path.lineTo(center2.dx - radiusX2, center2.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}