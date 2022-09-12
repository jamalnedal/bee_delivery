class Orders{
  late String id;
  late String gmail;
  late String firstName;
  late String mobile;
  late String deliveryCompany;
  late String location;
  late String trackingNumber;
  late String orderStatus;
  late String deliveryEmployeeName;
  late double latitude;
  late double longitude;
  Orders();
  Orders.fromMap(Map<String,dynamic>map){
    gmail=map['gmail'];
    firstName=map['firstName'];
    mobile=map['mobile'];
    deliveryCompany=map['deliveryCompany'];
    location=map['location'];
    trackingNumber=map['trackingNumber'];
    orderStatus=map['orderStatus'];
    deliveryEmployeeName=map['deliveryEmployeeName'];
    latitude=map['latitude'];
    longitude=map['longitude'];
  }
  Map<String,dynamic>toMAp(){
    Map<String, dynamic> map=<String,dynamic>{};
    map['gmail']=gmail;
    map['firstName']=firstName;
    map['mobile']=mobile;
    map['deliveryCompany']=deliveryCompany;
    map['location']=location;
    map['trackingNumber']=trackingNumber;
    map['orderStatus']=orderStatus;
    map['deliveryEmployeeName']=deliveryEmployeeName;
    map['latitude']=latitude;
    map['longitude']=longitude;
    return map;

  }}