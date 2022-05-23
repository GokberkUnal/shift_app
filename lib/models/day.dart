
import 'package:shift_app/models/slot.dart';


class Day {
  var id;
  String day;
  String date;
  List<Slot> slots=[
 ];
  Day({this.id,required this.day,required this.date,required this.slots});

  factory Day.fromMap(map,String dayId,List<Slot> slots){
   return Day(id:dayId,
   day: map["day"],
    date:map["date"],
    slots:slots);
  }
}