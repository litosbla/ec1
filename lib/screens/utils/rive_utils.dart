import 'package:rive/rive.dart';

class RiveUtils{
  static StateMachineController getRiveController(Artboard artboard, {stateMachineName="State Machine 1"}){
    print("Artboard name: ${artboard.name}");
    print("State machine name: $stateMachineName");
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard,stateMachineName); // revisar las animaciones en rive
    artboard.addController(controller!);

    return controller;
  }
}