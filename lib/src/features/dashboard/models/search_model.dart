class SearchModel {
  final String id;
  final String name;
  final String apiSymbol;
  final String symbol;
  final int marketCapRank;
  final String thumb;
  final String large;

  SearchModel({
    required this.id,
    required this.name,
    required this.apiSymbol,
    required this.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.large,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      name: json['name'],
      apiSymbol: json['api_symbol'],
      symbol: json['symbol'],
      marketCapRank: json['market_cap_rank'],
      thumb: json['thumb'],
      large: json['large'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'api_symbol': apiSymbol,
      'symbol': symbol,
      'market_cap_rank': marketCapRank,
      'thumb': thumb,
      'large': large,
    };
  }
}
