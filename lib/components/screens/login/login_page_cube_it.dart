import '../../core/base_cubit/base_cubit.dart';
import '../../core/base_cubit/base_state.dart';

class LoginPageCubeIt extends BaseCubit {
  LoginPageCubeIt(super.state);
  // final GetWikiListUseCase _getWikiListUseCase;
  //
  // LoginPageCubeIt({
  //   required GetWikiListUseCase getWikiListUseCase,
  // })  : _getWikiListUseCase = getWikiListUseCase,
  //       super(LoginPageCubeItInitialState());
  //
  // Future<void> getWikiList(String query) async {
  //   try {
  //     final response =
  //     await _getWikiListUseCase.call(GetWikiListParams(query: query));
  //
  //     response.fold(
  //           (failure) {
  //         handleFailure(failure);
  //       },
  //           (response) {
  //         emit(GetWikiListSuccess(wikiList: response, hasNextPage: false));
  //       },
  //     );
  //   } catch (e) {
  //     emit(FailedState(e.toString()));
  //   }
  // }
}