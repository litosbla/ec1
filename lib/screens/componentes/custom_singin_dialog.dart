import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive_animation/screens/componentes/sing_in_form.dart';

Future<Object?> CustomSinginDialog(BuildContext context, {required ValueChanged onClosed}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sing In",
    context: context,
    transitionDuration: Duration(milliseconds: 400),
    transitionBuilder: (_,animation,__,child){
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0,-1), end: Offset.zero);
      return  SlideTransition(
        position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut)
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Center(
      child: Container(// decoración del container
        height: 680,

        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 32),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: const BorderRadius.all(Radius.circular(40))
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent, // toca poner esto porque sino tapa el diseño visual anterior
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children:  [
                  const Text(
                    "Sing In",
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: "Poppins",

                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Join our platform and unlock a world of opportunities with exclusive access to a vast network of over 240 prestigious companies spanning various industries. Take your career to new heights and discover endless possibilities for growth and success.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SingInForm(),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "QR",
                          style: TextStyle(
                              color: Colors.black26
                          ),),
                      ),
                      Expanded(child: Divider())
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text("Sing up with Email, Apple or Google",style: TextStyle(color: Colors.black54),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){},
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset("assets/icons/email_box.svg", height: 64, width: 64,)
                      ),
                      IconButton(onPressed: (){},
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset("assets/icons/apple_box.svg", height: 64, width: 64,)
                      ),
                      IconButton(onPressed: (){},
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset("assets/icons/google_box.svg", height: 64, width: 64,)
                      ),
                    ],)

                ],
              ),
              const Positioned(
                bottom: -50,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius:16 ,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),


  ).then(onClosed);
}