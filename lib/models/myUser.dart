class myUser {
  static  String collectionName='USERS';
  String id;
  String fName;
  String lName;
  String email;
  String userName;

// without pass cause i will n't save  or generate it
  myUser(
      {required this.id,
      required this.fName,
      required this.lName,
      required this.email,
      required this.userName});

  myUser.fromJson(Map<String, dynamic> map)
      : this(
            id: map['id'],
            email: map['email'],
            fName: map['fName'],
            lName: map["lName"],
            userName: map['userName']);
  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "fName":fName,
      "lName":lName,
      "email":email,
      "userName":userName
    };
  }
}
