import 'package:brasil_cripto/src/core/extensions/date_time.dart';
import 'package:brasil_cripto/src/core/extensions/double.dart';
import 'package:brasil_cripto/src/core/extensions/int.dart';
import 'package:brasil_cripto/src/core/theme/theme.dart';
import 'package:brasil_cripto/src/features/details/view/widgets/details_title_subtitle.dart';
import 'package:brasil_cripto/src/features/details/view/widgets/percentage_widget.dart';
import 'package:brasil_cripto/src/features/details/view_model/details_view_model.dart';
import 'package:brasil_cripto/src/features/shared/models/favorite_model.dart';
import 'package:brasil_cripto/src/features/shared/view/widgets/error_screen.dart';
import 'package:brasil_cripto/src/features/shared/view/widgets/wait_message.dart';
import 'package:brasil_cripto/src/features/shared/view_model/view_model_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatefulWidget {
  final DetailsViewModel viewModel;
  final String id;

  const DetailsView({super.key, required this.viewModel, required this.id});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  void initState() {
    widget.viewModel.init(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        actions: [
          ValueListenableBuilder(
              valueListenable: widget.viewModel.favoriteState,
              builder: (context, value, _) {
                return IconButton(
                    onPressed: () {
                      widget.viewModel.toggleFavorite(
                        FavoriteModel(
                          id: widget.viewModel.details!.id,
                          symbol: widget.viewModel.details!.symbol,
                          name: widget.viewModel.details!.name,
                          larger: widget.viewModel.details!.image.large,
                        ),
                      );
                    },
                    icon: Icon(
                      widget.viewModel.isFavorite ? Icons.star : Icons.star_border,
                    ));
              }),
          const SizedBox(width: 8),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: widget.viewModel.detailsState,
        builder: (context, value, _) {
          if (value is ErrorState) {
            return const ErrorScreen();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: value is InitialState && widget.viewModel.details == null || value is LoadingState && widget.viewModel.details == null
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      height: MediaQuery.of(context).size.height - 200,
                      child: const WaitMessage(),
                    )
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.colors(context).input,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 88,
                                width: 88,
                                child: CachedNetworkImage(
                                  imageUrl: widget.viewModel.details!.image.large,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.viewModel.details!.name,
                                        style: AppTheme.textStyle.titleSmall,
                                      ),
                                      const SizedBox(width: 8),
                                      PercentageWidget(value: widget.viewModel.details!.marketData.priceChangePercentage24h!)
                                    ],
                                  ),
                                  Text(
                                    widget.viewModel.details!.symbol.toUpperCase(),
                                    style: AppTheme.textStyle.subtitle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppTheme.colors(context).input,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Última atualização: ${widget.viewModel.details!.lastUpdated!.toFormattedString()}',
                                      style: AppTheme.textStyle.labelMedium,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.colors(context).input,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '#${widget.viewModel.details!.marketCapRank}',
                                  style: AppTheme.textStyle.labelMedium.copyWith(fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Informações de Mercado',
                            style: AppTheme.textStyle.title,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailsTitleSubtitle(
                              title: 'Preço atual (em BRL)',
                              subtitle: (widget.viewModel.details!.marketData.currentPrice['brl'] as num).toInt().toBRL(),
                              isColumn: false,
                            ),
                            DetailsTitleSubtitle(
                              title: 'Capitalização de Mercado',
                              subtitle: (widget.viewModel.details!.marketData.marketCap['usd'] as int).toUSD(),
                              isColumn: false,
                            ),
                            DetailsTitleSubtitle(
                              title: 'Avaliação Diluida',
                              subtitle: (widget.viewModel.details!.marketData.fullyDilutedValuation['usd'] as int).toUSD(),
                              isColumn: false,
                            ),
                            DetailsTitleSubtitle(
                              title: 'Vol de Negociação (24H)',
                              subtitle: (widget.viewModel.details!.marketData.totalVolume['usd'] as int).toUSD(),
                              isColumn: false,
                            ),
                            DetailsTitleSubtitle(
                              title: 'Oferta Circulante',
                              subtitle: widget.viewModel.details!.marketData.circulatingSupply!.toBR(),
                              isColumn: false,
                            ),
                            DetailsTitleSubtitle(
                              title: 'Oferta Total',
                              subtitle: widget.viewModel.details!.marketData.totalSupply!.toBR(),
                              isColumn: false,
                            ),
                            DetailsTitleSubtitle(
                              title: 'Oferta Máxima',
                              subtitle: widget.viewModel.details!.marketData.maxSupply?.toBR() ?? '',
                              isColumn: false,
                            ),
                            const SizedBox(height: 16),
                            DetailsTitleSubtitle(
                              title: 'Sobre o ${widget.viewModel.details!.name} (EN)',
                              subtitle: widget.viewModel.details!.description.en,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
