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
         "imageUrl":imageUrl=="" ? "https://media.istockphoto.com/id/1131164548/vector/avatar-5.jpg?s=1024x1024&w=is&k=20&c=t1UxKUo5asF5EL4bncWciZwcWfIs9NOf7zfwy1dWl2U=":imageUrl,
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