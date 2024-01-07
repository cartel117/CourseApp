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
                        children: showbodyList(context, Provider.of<SubjectSystemViewModel>(context,
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

  List<Widget> showbodyList(BuildContext context, SubjectSystemViewModel model) {
    List<Widget> list = [];
    Text text = Text("你目前的選課如下 :",style: TextStyle(fontSize: 28,color: Colors.black),textAlign: TextAlign.center);
    list.add(text);
    list.add(SizedBox(height: 15));

    List<Map<String, dynamic>> selectedCourses = model.selectedStudentCourses;
    for (var i = 0; i < selectedCourses.length; i++){
      Map<String, dynamic> courseInfo = selectedCourses[i];
      String courseName = courseInfo["course_name"];
      Row row = selectedCourseRow(Icons.calendar_month, courseName);
      list.add(row);
      list.add(SizedBox(height: 12));
      }
    list.add(Divider(height: 0.0,color: Color.fromRGBO(178, 180, 182, 1)));
    list.add(SizedBox(height: 8));
    Text text2 = Text("以下是可以選得課程清單 :",style: TextStyle(fontSize: 28,color: Colors.black),textAlign: TextAlign.center);
    list.add(text2);
    list.add(SizedBox(height: 15));
    list = list + showCourseList(context, model);
    
    return list;
  }

  List<Widget> showCourseList(BuildContext context, SubjectSystemViewModel model) {
    List<Map<String, dynamic>> courses = model.courses;
    List<Widget> list = [];

    for (var i = 0; i < courses.length; i++){
      Map<String, dynamic> courseInfo = courses[i];
      String courseName = courseInfo["course_name"];
      bool isSelected = courseInfo["isSelected"];
      int courseID = courseInfo["course_id"];
      print("courseName -> $courseName");
      Container row = courseRow(Icons.menu_book, courseName,model,courseID,isSelected: isSelected);
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
      list.add(Divider(height: 0.0,color: Color.fromRGBO(178, 180, 182, 1)));
    }

    return list;
  }


  Container courseRow(IconData icondata,String labeltext,SubjectSystemViewModel model,
  int courseID,
  {maxLines = 1, isSelected = false}
) {
  return Container(
    height: 50.0,
    padding: const EdgeInsets.all(8.0),
    // decoration: BoxDecoration(
    //   border: Border.all(
    //     color: Colors.grey,
    //     width: 1.0,
    //   ),
    //   borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
    // ),
    child: Row(
      children: [
        SizedBox(width: 18),
        Icon(icondata,size: 30,color: Color.fromRGBO(120, 120, 120, 1),),
        SizedBox(width: 18),
        Flexible(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              labeltext,
              style: TextStyle(fontSize: 23, color: Colors.black),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 38,
          height: 38,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Center(
                child: Icon(
                  isSelected ? Icons.delete : Icons.add,
                  size: 22,
                  color: isSelected ? Colors.red : Colors.blue,
                ),
              ),
              onTap: () {
                isSelected
                    ? model.deleteStudentCourse(courseID)
                    : model.addStudentCourse(courseID);
              },
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    ),
  );
}



    Row selectedCourseRow(IconData icondata, String labeltext,{maxLines = 1}) {
    return Row(
      children: [
        SizedBox(width: 18),
        Icon(icondata,size: 22,color: Colors.grey),
        SizedBox(width: 18),
        Flexible(
          child: Container(
          alignment: Alignment.centerLeft,
          child: Text(labeltext,style: TextStyle(fontSize: 23,color: Colors.black),),
        )),
      ],
    );
  }

}

