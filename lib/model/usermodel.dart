class UserModel{
  String? name;
  String? email;
  String? uID;
  String? phone;
  String? address;
  String? image;

  UserModel({
   required this.name,
   required this.email,
    this.uID,
   required this.phone,
   required this.address,
   this.image
  });
  UserModel.fromjson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    uID = json['uID'];
    phone = json['phone'];
    address = json['address'];
    image = json['image'];
  }

  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'UID':phone,
      'address': address,
      'image': image
    };
  }
}
