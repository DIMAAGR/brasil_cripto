import 'dart:async';

// import 'package:brasil_cripto/src/features/dashboard/view/widgets/chart_button.dart';
import 'package:brasil_cripto/src/core/constants/routes.dart';
import 'package:brasil_cripto/src/features/dashboard/view/widgets/favorite_button.dart';
import 'package:brasil_cripto/src/features/dashboard/view/widgets/search_field.dart';
import 'package:brasil_cripto/src/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardView extends StatefulWidget {
  final DashboardViewModel viewModel;

  const DashboardView({super.key, required this.viewModel});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    widget.viewModel.getFavorites();
    widget.viewModel.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final controller = widget.viewModel.scrollController;

    if (controller.position.pixels >= controller.position.maxScrollExtent - 100) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 500), () {
        widget.viewModel.doSearch(widget.viewModel.searchController.text);
      });
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      widget.viewModel.searchListIndex = 0;
      widget.viewModel.searchList.clear();
      widget.viewModel.doSearch(value);
    });
  }

  @override
  void dispose() {
    widget.viewModel.scrollController.removeListener(_onScroll);
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BRASIL CRIPTO'),
        actions: [
          ValueListenableBuilder(
              valueListenable: widget.viewModel.favoriteState,
              builder: (context, value, _) {
                return FavoriteButton(
                  onTap: () {
                    Modular.to.pushNamed(AppRoutes.favorites).then((_) {
                      widget.viewModel.getFavorites();
                    });
                  },
                  favoriteLenght: widget.viewModel.favoriteLenght,
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4.5),
              ValueListenableBuilder(
                  valueListenable: widget.viewModel.favoriteState,
                  builder: (context, favValue, _) {
                    return ValueListenableBuilder(
                      valueListenable: widget.viewModel.searchState,
                      builder: (context, value, _) => SearchField(
                        scrollController: widget.viewModel.scrollController,
                        controller: widget.viewModel.searchController,
                        searchResult: widget.viewModel.searchList,
                        isFavorite: widget.viewModel.isFavorite,
                        onFavoritePressed: widget.viewModel.toggleFavorite,
                        getFavorites: widget.viewModel.getFavorites,
                        onChanged: _onSearchChanged,
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      // TODO: Só será feito se houver tempo
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 48.0),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       ChartButton(onTap: () {
      //
      //       }),
      //     ],
      //   ),
      // ),
    );
  }
}
