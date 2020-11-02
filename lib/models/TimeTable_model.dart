class Shipment {
  String title;
  String etd;
  String cutoff;
  String eta;
  String trackingnumber;
  String comments;

  Shipment(
      {this.title,
      this.etd,
      this.cutoff,
      this.eta,
      this.trackingnumber,
      this.comments});

  Shipment.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    etd = json['etd'];
    cutoff = json['cutoff'];
    eta = json['eta'];
    trackingnumber = json['trackingnumber'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['etd'] = this.etd;
    data['cutoff'] = this.cutoff;
    data['eta'] = this.eta;
    data['trackingnumber'] = this.trackingnumber;
    data['comments'] = this.comments;
    return data;
  }
}
