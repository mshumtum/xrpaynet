import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xr_paynet/core/base_cubit/ApiState.dart';

import 'BaseRepository.dart';

class BaseCubit extends Cubit<ApiState>{
  final BaseRepo baseRepo;
  BaseCubit(this.baseRepo) : super(InitTodoState());

  Future<void> callLoginApi (request) async {
    emit(LoadingTodoState());
    final _response = await baseRepo.callLoginApi(request);
    emit(ResponseTodoState(_response));
  }

}