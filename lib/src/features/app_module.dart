import 'package:brasil_cripto/src/core/constants/routes.dart';
import 'package:brasil_cripto/src/core/data/datasource/local_datasource.dart';
import 'package:brasil_cripto/src/core/data/datasource/remote_datasource.dart';
import 'package:brasil_cripto/src/core/data/service/api_service.dart';
import 'package:brasil_cripto/src/features/dashboard/dashboard_module.dart';
import 'package:brasil_cripto/src/features/details/details_module.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  dataServices(Injector i) {
    i.add(ApiService.new);
    i.add(RemoteDatasource.new);
    i.add(LocalDatasource.new);
    i.add(Connectivity.new);
  }

  @override
  void binds(Injector i) {
    dataServices(i);
  }

  @override
  void routes(RouteManager r) {
    r
      ..module(AppRoutes.dashboard, module: DashboardModule())
      ..module(AppRoutes.details, module: DetailsModule());
  }
}
