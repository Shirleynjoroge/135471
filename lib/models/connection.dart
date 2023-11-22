class Connection {
  String id;
  String connectionName;
  String location;
  double amount;
  int itemNumber;
  int connectionStatus;
  String? createdBy;
  String createdDate;
  String? updatedBy;
  String? updatedDate;
  Connection({
    required this.id,
    required this.connectionName,
    required this.location,
    required this.amount,
    required this.itemNumber,
    required this.connectionStatus,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });
}
