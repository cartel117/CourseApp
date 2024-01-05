import 'package:course_app/View/CourseDetail/CourseDetailView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_app/View/SubjectSystemViewModel.dart';
import 'commonUI/CommonUI.dart';

class SubjectSystemView extends StatefulWidget{
  SubjectSystemView() {}

  @override
  _SubjectSystemState createState() => _SubjectSystemState();

}

class _SubjectSystemState extends State<SubjectSystemView> {

  @override
  void initState() {
    print("SubjectSystemState init state");
  }

   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubjectSystemViewModel>(
      create: (_) => SubjectSystemViewModel(),
      builder: (context, widget) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Color.fromRGBO(147, 133, 122, 1.0),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                HeadlineWithBack(context, "選課系統"),
                const Divider(height: 0.0,color: Color.fromRGBO(178, 180, 182, 1),),
                 Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: 1,
                      itemBuilder: (context, index) => Column(
                        // children: [
                        //   courseRow(Icons.menu_book, Provider.of<SubjectSystemViewModel>(context,
                        //                   listen: true).courseName),
                        //   SizedBox(height: 12,),
                        //   courseRow(Icons.menu_book, "test1"),
                        //   SizedBox(height: 12,),
                        //   courseRow(Icons.menu_book, "test2"),
                        // ],
                        children: showCourseList(context, Provider.of<SubjectSystemViewModel>(context,
                                          listen: true)),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> showCourseList(BuildContext context, SubjectSystemViewModel model) {
    List<Map<String, dynamic>> courses = model.courses;
    List<Widget> list = [];

    for (var i = 0; i < courses.length; i++){
      Map<String, dynamic> courseInfo = courses[i];
      String courseName = courseInfo["course_name"];
      print("courseName -> $courseName");
      Row row = courseRow(Icons.menu_book, courseName);
      GestureDetector gesture = GestureDetector(
        child: row,
        onTap: () {
          print("courseName = $courseName is clicking");
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CourseDetailView(courseInfo)
          ));
        },
      );
      list.add(gesture);
      list.add(SizedBox(height: 12,));
    }

    return list;
  }


  Row courseRow(IconData icondata, String labeltext,
      {maxLines = 1}) {
    return Row(
      children: [
        SizedBox(
          width: 18,
        ),
        Icon(
          icondata,
          size: 22,
          color: Color.fromRGBO(120, 120, 120, 1),
        ),
        SizedBox(
          width: 18,
        ),
        // Text("文化課",textAlign: Alignment.center,),
        Flexible(
            child: Container(
          alignment: Alignment.centerLeft,
          child: Text(labeltext,style: TextStyle(fontSize: 23,color: Colors.black),),
        )),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 38, // Set the width to make the touch area wider
          height: 38, // Set the height to make the touch area taller
          child: Material(
            color: Colors.transparent, // Set the material color to transparent
            child: InkWell(
              borderRadius: BorderRadius.circular(24), // Set the border radius for a circular shape
              child: Center(
                child: Icon(
                  Icons.details,
                  size: 22,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
              },
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

}

