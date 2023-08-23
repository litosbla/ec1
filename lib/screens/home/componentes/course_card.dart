import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../home_screen.dart';


class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key, required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
      height: 280,
      width: 260,
      decoration: BoxDecoration(
        color: course.bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12,bottom: 8),
                    child: Text(course.description, style: TextStyle(color: Colors.white70),),
                  ),
                  Text("61 SECTIONS -11 HOURS", style: TextStyle(color: Colors.white54),),
                  Spacer(),
                  Row(children: List.generate(
                    3,
                        (index) => Transform.translate(
                      offset: Offset((-10*index).toDouble(),0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:  AssetImage("assets/avaters/Avatar ${index+1}.jpg"),
                      ),
                    ),
                  ))

                ],
              )
          ),
          SvgPicture.asset(course.iconSrc)
        ],
      ),
    );
  }
}

class Course{
  final String title,description, iconSrc;
  final Color bgColor;

  Course(
      {required this.title, this.description = "Build and animate an iOS app from scratch",
        this.iconSrc ="assets/icons/ios.svg",
        this.bgColor = const Color(0xFF7553F6)
      });
}
List<Course> courses = [
  Course(title:"Animation in SwiftUI"),
  Course(
      title: "Animations in Flutter",
      iconSrc: "assets/icons/code.svg",
      bgColor: const Color(0xFF7F4ED3)
  ),

];

List<Course> recentCourses = [
  Course(title: "State Machine"),
  Course(
      title: "Animated Menu",
      bgColor: const  Color(0xFF9CC5FF),
      iconSrc: "assets/icons/code.svg"
  ),
  Course(title: "Flutter with Rive"),
  Course(
      title: "Animated Menu",
      bgColor: const  Color(0xFF9CC5FF)
  )
];