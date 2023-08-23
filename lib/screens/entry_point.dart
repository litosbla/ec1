import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/screens/componentes/side_menu_bar.dart';
import 'package:rive_animation/screens/home/home_screen.dart';
import 'package:rive_animation/screens/utils/rive_utils.dart';

import 'componentes/menu_btn.dart';
import 'componentes/rive_assets.dart';

class EntryPoint extends StatefulWidget{

  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin{
  RiveAsset selectedBottonNav = bottomNavs.first;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 200)
    )..addListener(() {
      setState(() {

      });
    });
    animation= Tween<double>(begin: 0,end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)
    );
    scalAnimation= Tween<double>(begin: 1,end: 0.8).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn)
    );

    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){


    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
              left: isSideMenuClosed?-288:0,
              height: MediaQuery.of(context).size.height,
              child: const SideMenu()
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(animation.value - 30 * animation.value* pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value *288,0 ),
                child: Transform.scale(
                  scale: scalAnimation.value,
                    child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                        child: HomeScreen()
                    )
                )
            ),
          ),
          AnimatedPositioned(
            duration: Duration(microseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? 0: 220,
            top: 16,
            child: MenuBtn(
              riveOnInit: (artboard){
                StateMachineController controller = RiveUtils.getRiveController(
                    artboard,
                  stateMachineName: "State Machine",

                );
                isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                isSideBarClosed.value = true;

              },
              press: (){
                isSideBarClosed.value=!isSideBarClosed.value;
                if (isSideMenuClosed){
                  _animationController.forward();
                }else{
                  _animationController.reset();
                }
                setState(() {
                  isSideMenuClosed = isSideBarClosed.value;
                });
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(24))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              ...List.generate(bottomNavs.length, (index) => GestureDetector( // esto viene siendo un ciclo
                onTap: (){
                  bottomNavs[index].input!.change(true);
                  if(bottomNavs[index]!=selectedBottonNav){
                    setState(() {
                      selectedBottonNav = bottomNavs[index]; // seleccionar el que se esta presionando para poner los otros en un shade
                    });
                  }
                  Future.delayed(const Duration(seconds: 1), (){
                    bottomNavs[index].input!.change(false);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    AnimatedBar(isActive: bottomNavs[index] == selectedBottonNav),
                    SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: bottomNavs[index]==selectedBottonNav ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavs[index].src,
                            artboard: bottomNavs[index].artboard, /// toca entrar a rive y mirar como se llama
                            onInit: (artboard)
                            {
                              StateMachineController controller = RiveUtils.getRiveController(
                                  artboard, stateMachineName: bottomNavs[index].stateMachineName /// esto sale de rive es el nombre de la maquina
                              );
                              bottomNavs[index].input = controller.findSMI("active") as SMIBool; //  esto esta en rives lo que debe ponerse

                            },

                          ),
                        ),
                    ),
                  ],
                ),
              )
              )

            ],

          ),

        ),
      ),
    );
  }
}


class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(12),

        )
      ),
    );
  }
}

