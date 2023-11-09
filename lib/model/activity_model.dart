class ActivityModel {

  final String activity;

  final String type;

  final double price;

  final int participants;


  ActivityModel(this.activity, this.type, this.price, this.participants);

  factory ActivityModel.fromMap(Map<String,dynamic> map) {
    return ActivityModel(map['activity'], map['type'], map['price'], map['participants']);
  }

}