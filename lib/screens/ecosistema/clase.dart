import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class curso_modulo extends StatefulWidget {
  const curso_modulo({Key? key}) : super(key: key);

  @override
  State<curso_modulo> createState() => _curso_moduloState();
}

class _curso_moduloState extends State<curso_modulo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color:Color(0xFF7F14F3)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
            child: Column(


              children: [
                // aca pongo la primera fila donde va titulo e imagenes
                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "TITULO DEL MODULO O CLASE",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Poppins",
                              height: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                            softWrap: true  ,

                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(children: List.generate(
                          3,
                              (index) => Transform.translate(
                            offset: Offset((-10*index).toDouble(),0),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage:  AssetImage("assets/avaters/Avatar ${index+1}.jpg"),
                            ),
                          ),
                        )),
                      )


                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width*0.2,
                  bottom: MediaQuery.of(context).size.height*0.1
                ),
                child: Column(
                  children: [
                    Text(
                      "Aca va la introducion del modulo o de la clase tiene que ser breve corto y substancial",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Poppins",
                        color: Colors.white70
                      ),
                      softWrap: true,

                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "tiempo de estudio 3 horas , .... n modulos",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 10,

                          fontFamily: "Poppins",
                          color: Colors.white70
                        ),


                      ),
                    ),






                  ],
                ),
                ),






              ],

            ),
          ),


    )
    );
  }
}
