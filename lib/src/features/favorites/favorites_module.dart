import 'package:brasil_cripto/src/features/app_module.dart';
import 'package:brasil_cripto/src/features/favorites/view/favorite_view.dart';
import 'package:brasil_cripto/src/features/favorites/view_model/favorite_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  viewModel(Injector i) {
    i.addLazySingleton(FavoriteViewModel.new);
  }

  @override
  void binds(Injector i) {
    viewModel(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => FavoriteView(
        viewModel: Modular.get(),
      ),
    );
  }
}
