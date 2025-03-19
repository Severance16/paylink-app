class Ticket {
  int id;
  double value;
  String cellPhone;
  String message;
  String transactionalId;
  String supplierId;

  Ticket({
    required this.id,
    required this.value,
    required this.cellPhone,
    required this.message,
    required this.transactionalId,
    required this.supplierId
  });

  static Ticket blank() {
    return Ticket(id: 0, value: 0, cellPhone: "", message: "", transactionalId: "", supplierId: "");
  }

}
