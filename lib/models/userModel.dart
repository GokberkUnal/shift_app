
class UserModel {

  String? id;
  String? name;
  String? email;
  int? color;

  UserModel({ this.id, this.name ,this.email,this.color});


  factory UserModel.fromMap(map,String userId) {
    return UserModel(
      id: userId,
      name: map["userName"],
      email: map["userMail"],
      color: map["userColor"]
    );
  }


  
      
 



}