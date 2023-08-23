import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:rive_animation/reusable/reusable_widget.dart';
import 'package:rive_animation/screens/ecosistema/sing_up_screen.dart';
import 'package:rive_animation/screens/home/home_screen.dart';

import '../entry_point.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  double _offset=0.0;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double progress = _offset.clamp(0.0, screenHeight) / screenHeight;


    return Scaffold(
      body:PageView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color(0xFFDD38FF),Color(0xFFFFF358)], // Cambia estos colores según tus preferencias
                begin: Alignment.centerLeft, // Cambia el punto de inicio a la izquierda
                end: Alignment.centerRight, // Cambia el punto de fin a la derecha
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  //bottom: 100,
                  //left: 50,
                    bottom: MediaQuery.of(context).size.height*0.22,
                    left: MediaQuery.of(context).size.height*0.07,

                    width: MediaQuery.of(context).size.width*1.4,
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width*0.8,
                      backgroundColor: Colors.white,

                    )
                ),
                Positioned(
                  //bottom: 100,
                  //left: 50,
                    bottom: MediaQuery.of(context).size.height*0.57,
                    left:  -MediaQuery.of(context).size.width*0.68,

                    width: MediaQuery.of(context).size.width*1.4,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xFFFFDE59),Color(0xFFFF914D)]
                          )
                      ),
                    )
                ),
                Positioned(
                  //bottom: 100,
                  //left: 50,
                    bottom: MediaQuery.of(context).size.height*0.4,
                    left:  -MediaQuery.of(context).size.width*0.65,

                    width: MediaQuery.of(context).size.width*1.4,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xFF8C52FF),Color(0xFFFF914D)]
                          )
                      ),
                    )
                ),
                Positioned(
                  //bottom: 100,
                  //left: 50,
                    bottom: MediaQuery.of(context).size.height*0.15,
                    left:  -MediaQuery.of(context).size.width*0.24,

                    width: MediaQuery.of(context).size.width*1.4,
                    child: Container(
                      width: 250,
                      height:250,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xFFFF66C4),Color(0xFFFFDE59)]
                          )
                      ),
                    )
                ),
                Positioned(
                  //bottom: 100,
                  //left: 50,
                  top: 0,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,left: MediaQuery.of(context).size.height*0.07 ),

                      child: Center(
                        child: Column(
                          children: [

                            SizedBox(
                                height: MediaQuery.of(context).size.height*0.25),
                            const Text(
                              'ECOSISTEMA DE LIDERAZGO FEMENINO',
                              textAlign: TextAlign.right ,
                              style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: "Poppins",
                                  height: 1.2,
                                  fontWeight: FontWeight.bold
                              ),
                              softWrap: true,
                            ),


                            const Text(
                              'powered by:',
                              textAlign: TextAlign.center ,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Poppins",
                                height: 1.2,
                              ),
                              softWrap: true,
                            ),




                          ],
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
          Container(
             // Puedes personalizar el color aquí
            height: screenHeight,
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
                            'Diseño de inicio de sesión',
                            style: TextStyle
                              (fontSize: 18.0)
                        ),
                        SizedBox(height: 30,),
                        reusableTextField("Enter Username", Icons.verified_user, false, _emailTextController),
                        SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                        reusableTextField("Enter Password", Icons.lock, true, _passwordTextController),
                        SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                        singInSingUpButton(context, true, (){
                          FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text)
                          .then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> EntryPoint() ));
                          }).onError((error, stackTrace) {Navigator.push(context, MaterialPageRoute(builder:(context) => singUpScreen() ));});

                        }),
                        singUpOption(),
                        Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.1))

                      ],
                    ),
                    ),
                  ],
                ),
            ),



          )
        ],

      )
    );
  }
  Row singUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "¿No tienes cuenta?",
          style: TextStyle(color: Colors.black38),),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:(context) => singUpScreen() ));
          },
          child: const Text(
            " Sing Up",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )
        )
      ],
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