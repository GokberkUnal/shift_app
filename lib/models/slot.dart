class Slot {
  String? id;
  String?userName;
  int? userColor;
  bool? isEmptyFlag;

  Slot({ this.id,  this.userName,this.userColor, this.isEmptyFlag});

  factory Slot.fromMap(map, String slotId) {
    return Slot(
        id: slotId,
        userName: map["userName"],
        userColor: map["userColor"],
        isEmptyFlag: map["isEmptyFlag"]);
  }
}
