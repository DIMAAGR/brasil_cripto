class FavoriteModel {
  final String id;
  final String symbol;
  final String larger;
  final String name;

  FavoriteModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.larger,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        larger: json['larger'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'symbol': symbol,
        'name': name,
        'larger': larger,
      };
}
