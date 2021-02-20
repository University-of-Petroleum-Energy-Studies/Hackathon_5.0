class Customer {
  String uid;
  String customerId;
  String displayName;
  String phoneNumber;
  String lastPayType;
  int lastEditDate;
  int creationDateInEpoc;
  String creationDate;
  int totalRequests;
  List<String> ownerIds;

  Customer(
      {this.uid,
      this.customerId,
      this.displayName,
      this.phoneNumber,
      this.lastPayType,
      this.lastEditDate,
      this.creationDateInEpoc,
      this.creationDate,
      this.ownerIds});

  Customer.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    customerId = json['customerId'];
    lastEditDate = json['lastEditDate'];
    displayName = json['displayName'];
    phoneNumber = json['phoneNumber'];
    lastPayType = json['lastPayType'];
    creationDateInEpoc = json['creationDateInEpoc'];
    creationDate = json['creationDate'];
    ownerIds = [];
    if (json['ownerIds'] != null) {
      for (int i = 0; i < json['ownerIds'].length; i++) {
        ownerIds.add(json['ownerIds'][i]);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['customerId'] = this.customerId;
    data['lastEditDate'] = this.lastEditDate;
    data['displayName'] = this.displayName;
    data['phoneNumber'] = this.phoneNumber;
    data['lastPayType'] = this.lastPayType;
    data['creationDate'] = this.creationDate;
    data['creationDateInEpoc'] = this.creationDateInEpoc;
    if (this.ownerIds != null) {
      data['ownerIds'] = this.ownerIds;
    } else {
      data['ownerIds'] = [];
    }
    return data;
  }
}
