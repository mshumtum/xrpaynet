import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xr_paynet/components/screens/login/login_page_cube_it.dart';
import 'injection_container.dart' as di;

class BlocProviders {
  static List<SingleChildWidget> toGenerateProviders() {
    return [
      BlocProvider(
        create: (_) => di.sl<LoginPageCubeIt>(),
      ),
      // BlocProvider(
      //   create: (_) => di.sl<WikiDetailPageCubit>(),
      // ),
    ];
  }
}
