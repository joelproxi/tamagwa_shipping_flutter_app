// import 'package:equatable/equatable.dart';

class PriceList {
  final String id;
  final String description;
  final String seafreightPrice;
  final String airfreightPrice;
  final String packagingPrice;

  PriceList(
      {this.id,
      this.description,
      this.seafreightPrice,
      this.airfreightPrice,
      this.packagingPrice});

  factory PriceList.fromJson(Map<String, dynamic> json) {
    return PriceList(
      id: json['id'],
      description: json['description'],
      seafreightPrice: json['seafreight_price'],
      airfreightPrice: json['airfreight_price'],
      packagingPrice: json['packaging_price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['seafreight_price'] = this.seafreightPrice;
    data['airfreight_price'] = this.airfreightPrice;
    data['packaging_price'] = this.packagingPrice;
    return data;
  }

  @override
  List<Object> get props => [
        this.id,
        this.description,
        this.seafreightPrice,
        this.airfreightPrice,
        this.packagingPrice
      ];
}
