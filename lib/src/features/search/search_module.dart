import 'package:brasil_cripto/src/features/app_module.dart';
import 'package:brasil_cripto/src/features/search/view/search_view.dart';
import 'package:brasil_cripto/src/features/search/view_model/search_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  viewModels(Injector i) {
    i.addLazySingleton(SearchViewModel.new);
  }

  @override
  void binds(Injector i) {
    viewModels(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => SearchView(
        viewModel: Modular.get(),
        search: r.args.data['search'],
      ),
    );
  }
}
