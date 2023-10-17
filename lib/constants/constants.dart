import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

enum FormSubmissionStatus {
  initial,
  inProgress,
  success,
  failure,
  canceled,
}