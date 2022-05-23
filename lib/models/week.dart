import 'package:shift_app/models/day.dart';

class Week{
  var id;
  List<Day> week=[];
  Week({this.id,required this.week});

  factory Week.fromMap(map,String weekId,List<Day>weekdata){
    return Week(id:weekId,week: weekdata);
  }



}