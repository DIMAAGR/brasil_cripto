class DetailsModel {
  final String id;
  final String symbol;
  final String name;
  final String webSlug;
  final int? blockTimeInMinutes;
  final String? hashingAlgorithm;
  final List<String> categories;
  final Description description;
  final Links links;
  final ImageUrls image;
  final String? genesisDate;
  final double? sentimentVotesUpPercentage;
  final double? sentimentVotesDownPercentage;
  final int? watchlistPortfolioUsers;
  final int? marketCapRank;
  final MarketData marketData;
  final CommunityData? communityData;
  final DeveloperData? developerData;
  final DateTime? lastUpdated;

  DetailsModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.webSlug,
    required this.blockTimeInMinutes,
    required this.hashingAlgorithm,
    required this.categories,
    required this.description,
    required this.links,
    required this.image,
    required this.genesisDate,
    required this.sentimentVotesUpPercentage,
    required this.sentimentVotesDownPercentage,
    required this.watchlistPortfolioUsers,
    required this.marketCapRank,
    required this.marketData,
    required this.lastUpdated,
    this.communityData,
    this.developerData,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        webSlug: json['web_slug'],
        blockTimeInMinutes: json['block_time_in_minutes'],
        hashingAlgorithm: json['hashing_algorithm'],
        categories: List<String>.from(json['categories'] ?? []),
        description: Description.fromJson(json['description']),
        links: Links.fromJson(json['links']),
        image: ImageUrls.fromJson(json['image']),
        genesisDate: json['genesis_date'],
        sentimentVotesUpPercentage: (json['sentiment_votes_up_percentage'] as num?)?.toDouble(),
        sentimentVotesDownPercentage: (json['sentiment_votes_down_percentage'] as num?)?.toDouble(),
        watchlistPortfolioUsers: json['watchlist_portfolio_users'],
        marketCapRank: json['market_cap_rank'],
        marketData: MarketData.fromJson(json['market_data']),
        communityData: json['community_data'] != null ? CommunityData.fromJson(json['community_data']) : null,
        developerData: json['developer_data'] != null ? DeveloperData.fromJson(json['developer_data']) : null,
        lastUpdated: DateTime.tryParse(json['last_updated'] ?? ''),
      );
}

class Description {
  final String en;

  Description({required this.en});

  factory Description.fromJson(Map<String, dynamic> json) => Description(en: json['en'] ?? '');
}

class Links {
  final List<String> homepage;
  final String? whitepaper;
  final List<String> blockchainSites;
  final String? subredditUrl;
  final List<String> githubRepos;

  Links({
    required this.homepage,
    this.whitepaper,
    required this.blockchainSites,
    this.subredditUrl,
    required this.githubRepos,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        homepage: List<String>.from(json['homepage'] ?? []),
        whitepaper: json['whitepaper'],
        blockchainSites: List<String>.from(json['blockchain_site'] ?? []),
        subredditUrl: json['subreddit_url'],
        githubRepos: List<String>.from(json['repos_url']?['github'] ?? []),
      );
}

class ImageUrls {
  final String thumb;
  final String small;
  final String large;

  ImageUrls({
    required this.thumb,
    required this.small,
    required this.large,
  });

  factory ImageUrls.fromJson(Map<String, dynamic> json) => ImageUrls(
        thumb: json['thumb'],
        small: json['small'],
        large: json['large'],
      );
}

class MarketData {
  final Map<String, dynamic> currentPrice;
  final Map<String, dynamic> ath;
  final Map<String, dynamic> atl;
  final Map<String, dynamic> priceChangePercentage24hInCurrency;
  final double? priceChange24h;
  final double? priceChangePercentage24h;
  final double? priceChangePercentage7d;
  final double? priceChangePercentage14d;
  final double? priceChangePercentage30d;
  final double? priceChangePercentage60d;
  final double? priceChangePercentage200d;
  final double? priceChangePercentage1y;
  final Map<String, dynamic> marketCap;
  final Map<String, dynamic> fullyDilutedValuation;
  final Map<String, dynamic> totalVolume;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;

  MarketData({
    required this.currentPrice,
    required this.ath,
    required this.atl,
    required this.priceChangePercentage24hInCurrency,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.priceChangePercentage7d,
    this.priceChangePercentage14d,
    this.priceChangePercentage30d,
    this.priceChangePercentage60d,
    this.priceChangePercentage200d,
    this.priceChangePercentage1y,
    required this.marketCap,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) => MarketData(
        currentPrice: json['current_price'] ?? {},
        ath: json['ath'] ?? {},
        atl: json['atl'] ?? {},
        priceChangePercentage24hInCurrency: json['price_change_percentage_24h_in_currency'] ?? {},
        priceChange24h: (json['price_change_24h'] as num?)?.toDouble(),
        priceChangePercentage24h: (json['price_change_percentage_24h'] as num?)?.toDouble(),
        priceChangePercentage7d: (json['price_change_percentage_7d'] as num?)?.toDouble(),
        priceChangePercentage14d: (json['price_change_percentage_14d'] as num?)?.toDouble(),
        priceChangePercentage30d: (json['price_change_percentage_30d'] as num?)?.toDouble(),
        priceChangePercentage60d: (json['price_change_percentage_60d'] as num?)?.toDouble(),
        priceChangePercentage200d: (json['price_change_percentage_200d'] as num?)?.toDouble(),
        priceChangePercentage1y: (json['price_change_percentage_1y'] as num?)?.toDouble(),
        marketCap: json['market_cap'] ?? {},
        fullyDilutedValuation: json['fully_diluted_valuation'] ?? {},
        totalVolume: json['total_volume'] ?? {},
        circulatingSupply: (json['circulating_supply'] as num?)?.toDouble(),
        totalSupply: (json['total_supply'] as num?)?.toDouble(),
        maxSupply: (json['max_supply'] as num?)?.toDouble(),
      );
}

class CommunityData {
  final int? twitterFollowers;

  CommunityData({this.twitterFollowers});

  factory CommunityData.fromJson(Map<String, dynamic> json) => CommunityData(
        twitterFollowers: json['twitter_followers'],
      );
}

class DeveloperData {
  final int? forks;
  final int? stars;
  final int? subscribers;
  final int? totalIssues;
  final int? closedIssues;
  final int? pullRequestsMerged;
  final int? pullRequestContributors;

  DeveloperData({
    this.forks,
    this.stars,
    this.subscribers,
    this.totalIssues,
    this.closedIssues,
    this.pullRequestsMerged,
    this.pullRequestContributors,
  });

  factory DeveloperData.fromJson(Map<String, dynamic> json) => DeveloperData(
        forks: json['forks'],
        stars: json['stars'],
        subscribers: json['subscribers'],
        totalIssues: json['total_issues'],
        closedIssues: json['closed_issues'],
        pullRequestsMerged: json['pull_requests_merged'],
        pullRequestContributors: json['pull_request_contributors'],
      );
}
