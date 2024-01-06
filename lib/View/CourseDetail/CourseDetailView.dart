import 'package:course_app/View/CourseDetail/CourseDetailViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_app/View/commonUI/CommonUI.dart';
// import 'package:intl/intl.dart';

class CourseDetailView extends StatefulWidget{
  Map<String, dynamic> courseInfo = {};
  CourseDetailView(this.courseInfo);

  @override
  _CourseDetailViewState createState() => _CourseDetailViewState(courseInfo);
}

class _CourseDetailViewState extends State<CourseDetailView>{
  Map<String, dynamic> courseInfo = {};
  _CourseDetailViewState(this.courseInfo);

@override
  void initState();

   @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CourseDetailViewModel>(
      create: (_) => CourseDetailViewModel(courseInfo),
      builder: (context, widget) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Color.fromRGBO(147, 133, 122, 1.0),
          body: Column(
            children: [
              HeadlineWithBack(context, "課程簡介",isHideBackBtn: true),
              Divider(height: 0.0,indent: 0.0,color: Color.fromRGBO(178, 180, 182, 1)),
              Expanded(child: ListView(
                children: [
                  Text("課程名稱：" + Provider.of<CourseDetailViewModel>(context,listen: true).courseName,
                  style: TextStyle(fontSize: 28,color: Colors.black),
                  textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Text("課程簡介：",
                  style: TextStyle(fontSize: 28,color: Colors.grey),
                  textAlign: TextAlign.center),
                  const SizedBox(height: 2),
                  Text(Provider.of<CourseDetailViewModel>(context,listen: true).courseDescription,
                  style: TextStyle(fontSize: 28,color: Colors.grey),
                  textAlign: TextAlign.center),
                  const SizedBox(height: 15),
                  Text("開始時間:" + Provider.of<CourseDetailViewModel>(context,listen: true).startDateStr,
                  style: TextStyle(fontSize: 28,color: Colors.blue),
                  textAlign: TextAlign.center),
                  const SizedBox(height: 15),
                  Text("結束時間:" + Provider.of<CourseDetailViewModel>(context,listen: true).endDateStr,
                  style: TextStyle(fontSize: 28,color: Colors.blue),
                  textAlign: TextAlign.center),
                  const SizedBox(height: 15),
                  ExpansionTile(
                    title: Text("講師姓名:" + Provider.of<CourseDetailViewModel>(context,listen: true).instructorInfo?["username"] ?? "",
                  style: TextStyle(fontSize: 28,color: Colors.grey),textAlign: TextAlign.center),
                    children: showCourseList(context, Provider.of<CourseDetailViewModel>(context,listen: true))),
                ],
              )),
            ],
          ),
        );
      },
    );
  }

List<Widget> showCourseList(BuildContext context, CourseDetailViewModel model){
  List<Map<String, dynamic>> courses = model.instructorCourses;
  List<Widget> list = [];

  list.add(Text("email: " + model.instructorInfo?["email"] ?? "",
   style: TextStyle(fontSize: 25,color:Color.fromRGBO(192, 192, 192, 1.0)),
   textAlign: TextAlign.center));
  list.add(Text("phone: " + model.instructorInfo?["phone"] ?? "",
  style: TextStyle(fontSize: 25,color: Color.fromRGBO(192, 192, 192, 1.0)),
  textAlign: TextAlign.center));

   for (var i = 0; i < courses.length; i++){
      Map<String, dynamic> courseInfo = courses[i];
      String courseName = courseInfo["course_name"];
      Row row = courseRow(Icons.calendar_month_outlined, courseName);
      list.add(row);
      list.add(SizedBox(height: 12));
    }

    return list;
}

  Row courseRow(IconData icondata, String labeltext,{maxLines = 1}) {
    return Row(
      children: [
        SizedBox(width: 18),
        Icon(icondata,size: 22,color: Color.fromRGBO(192, 192, 192, 1.0)),
        SizedBox(width: 18),
        Flexible(
          child: Container(
          alignment: Alignment.centerLeft,
          child: Text(labeltext,style: TextStyle(fontSize: 23,color: Colors.black12),),
        )),
        SizedBox(width: 10),
        // Container(
        //   width: 38, // Set the width to make the touch area wider
        //   height: 38, // Set the height to make the touch area taller
        //   child: Material(
        //     color: Color.fromRGBO(192, 192, 192, 1.0), // Set the material color to transparent
        //     child: InkWell(
        //       borderRadius: BorderRadius.circular(24), // Set the border radius for a circular shape
        //       child: Center(
        //         child: Icon(
        //           Icons.details,
        //           size: 22,
        //           color: Color.fromRGBO(192, 192, 192, 1.0),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

