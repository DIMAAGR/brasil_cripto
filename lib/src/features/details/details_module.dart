import 'package:brasil_cripto/src/features/app_module.dart';
import 'package:brasil_cripto/src/features/details/repository/details_repository.dart';
import 'package:brasil_cripto/src/features/details/repository/details_repository_impl.dart';
import 'package:brasil_cripto/src/features/details/view/details_view.dart';
import 'package:brasil_cripto/src/features/details/view_model/details_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailsModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  void dataServices(Injector i) {
    i.add<DetailsRepository>(DetailsRepositoryImpl.new);
  }

  void viewModels(Injector i) {
    i.addLazySingleton(DetailsViewModel.new);
  }

  @override
  void binds(Injector i) {
    dataServices(i);
    viewModels(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => DetailsView(
        viewModel: Modular.get(),
        id: r.args.data['id'],
      ),
    );
  }
}
