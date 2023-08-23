import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../componentes/animated_btn.dart';
import '../componentes/custom_singin_dialog.dart';
import '../componentes/sing_in_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  bool isSingInDialogShown = false;
  late RiveAnimationController _btnAnimationController;


  @override
  void initState(){
    _btnAnimationController = OneShotAnimation("active",
    autoplay: false);
  }
  @override
  Widget build(BuildContext context) {
    double viewInset =MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          ////////////////////////////////////////////////
          //              Animación Inicial
          ///////////////////////////////////////////////
          Positioned(
            //height: 100,
              bottom: 200,
              left: 100,
              width: MediaQuery.of(context).size.width*1.7,
              child: Image.asset("assets/Backgrounds/Spline.png")
          ),
          Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20,sigmaY: 10),

              )
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50,sigmaY: 50),
                child: const SizedBox(),
              )
          ),
          ////////////////////////////////////////////////
          //               Texto
          ///////////////////////////////////////////////
          AnimatedPositioned(
            top: isSingInDialogShown ? -50 : 0,
            duration: Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),

                  child: Center(
                    child: Column(


                      children: [
                        const Spacer(),
                        SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height*0.1),
                              const Text(
                                  "SemiosisLab",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 45,
                                  fontFamily: "Poppins",
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height*0.15),
                              const Text(
                                "''Si el espíritu empresarial es la sangre vital de la economía, los creadores de ecosistemas son el sistema circulatorio, las arterias y venas que facilitan el flujo de ideas, recursos, conexiones y colaboraciones en los ecosistemas empresariales''",
                                textAlign: TextAlign.justify
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height*0.02),
                              const Text(
                                  "Jeff Bennett",
                                style: TextStyle(fontStyle: FontStyle.italic),

                              )

                            ],
                          ),
                        ),
                        const Spacer(flex: 2),
                        AnimatedBtn(btnAnimationController: _btnAnimationController,
                        press: (){
                          _btnAnimationController.isActive = true;
                          Future.delayed(Duration(milliseconds: 500),(){
                            setState(() {
                              isSingInDialogShown = true;
                            });
                            CustomSinginDialog(
                              context,
                            onClosed: (_){
                                setState(() {
                                  isSingInDialogShown = false;
                                });
                            });
                          });

                        },),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                        )
                      ],
                    ),
                  ),
                ),
            ),
          )

        ],
      ),

    );
  }


}



