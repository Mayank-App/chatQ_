class FirebaseUserDetailModel
{
   String email ;
   String name ;
   String ?imageUrl  ;
   String pass ;
   String uid ;
   String joinDate ;
   FirebaseUserDetailModel({
      required this.email,
      required this.name,
      required this.uid,
      required this.joinDate,
      required  this.pass,
       this.imageUrl
}
       );
   Map<String,dynamic> toMap() {
      return <String,dynamic> {
         "email" :email,
         "name" :name,
         "imageUrl":imageUrl,
         "pass":pass,
         "uid":uid,
         "joinDate":joinDate
      };
   }
   factory FirebaseUserDetailModel.fromJson(Map<String, dynamic> json) {
      return FirebaseUserDetailModel(
         email: json['email'],
         name: json['name'],
         imageUrl: json['imageUrl'],
         pass: json['pass'],
         uid: json['uid'],
         joinDate: json['joinDate'],
      );
   }
}