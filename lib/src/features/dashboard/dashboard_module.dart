import 'package:brasil_cripto/src/features/app_module.dart';
import 'package:brasil_cripto/src/features/dashboard/view/dashboard_view.dart';
import 'package:brasil_cripto/src/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  void dataServices(Injector i) {}

  void viewModels(Injector i) {
    i.addLazySingleton(DashboardViewModel.new);
  }

  @override
  void binds(Injector i) {
    dataServices(i);
    viewModels(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => DashboardView(viewModel: Modular.get()));
  }
}
