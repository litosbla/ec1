import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/entry_point.dart';

import '../utils/rive_utils.dart';

class SingInForm extends StatefulWidget {
  const SingInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SingInForm> createState() => _SingInFormState();
}

class _SingInFormState extends State<SingInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShowLoading = false;
  bool isShowConfetti =false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyle(color: Colors.black54),
              ),
              Padding(/////////////////              email
                padding: const EdgeInsets.only(top:8 , bottom: 16),
                child: TextFormField(
                  validator: (value){
                    if (value!.isEmpty){return "";}
                    return null;

                  },
                  onSaved: (email){},
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/email.svg"),
                      )
                  ),
                ),
              ),
              Text(
                "Password",
                style: TextStyle(color: Colors.black54),
              ),
              Padding( /////////////////              PASSWORD
                padding: const EdgeInsets.only(top:8 , bottom: 16),
                child: TextFormField(
                  validator: (value){
                    if (value!.isEmpty){return "";}
                    return null;
                  },
                  onSaved: (password  ){},
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/password.svg"),
                      )
                  ),
                ),
              ),
              Padding( /////////////////              BOTON
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                    onPressed: (){
                      setState(() {
                        isShowLoading = true;
                        isShowConfetti = true;
                      });
                      Future.delayed(
                        Duration(seconds: 1), (){
                        if(_formKey.currentState!.validate()){ //////////////  valida si estan completos los textfield
                          check.fire();
                          Future.delayed(Duration(seconds: 2),
                              (){
                                    setState(() {
                                      isShowLoading = false;
                                    });
                                    setState(() {
                                      isShowConfetti = true;
                                    });
                                    confetti.fire();
                                    Future.delayed(Duration(seconds: 1),(){
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => EntryPoint())
                                      );
                                    }
                                    );
                              });

                        }else{
                          error.fire();
                          Future.delayed(Duration(seconds: 2),(){
                            setState(() {
                              isShowLoading = false;
                            });
                          });
                        }
                      },
                      );

                },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF77D8E),
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24)
                        )
                    )
                ),
                    icon: const Icon(CupertinoIcons.arrow_right,
                      color: Color(0xFFFE0037),),
                    label: const Text("Sing In")),
              )
            ],
          ),
        ),
        isShowLoading
        ? CustomPositioned(
          child: RiveAnimation.asset(
         "assets/RiveAssets/check.riv",
         onInit: (artboard){
           StateMachineController controller =
               RiveUtils.getRiveController(artboard);
           check = controller.findSMI("Check") as SMITrigger;
           error = controller.findSMI("Error") as SMITrigger;
           reset = controller.findSMI("Reset") as SMITrigger;
         },
        ),
        )
        :const SizedBox(),
        isShowConfetti
        ? CustomPositioned(
          child: Transform.scale(
            scale: 7,
            child: RiveAnimation.asset("assets/RiveAssets/confetti.riv",
              onInit: (artboard){
                 StateMachineController controller =
                 RiveUtils.getRiveController(artboard);
                 confetti = controller.findSMI("Trigger explosion") as SMITrigger;

        },
        ),
          ),
        ): const SizedBox(),

      ],
    );
  }
}
class CustomPositioned extends StatelessWidget {
  const CustomPositioned({Key? key, required this.child, this.size = 100}) : super(key: key);

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          Spacer(flex: 2)
        ],
      ),

    );
  }
}
