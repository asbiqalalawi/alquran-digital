part of 'surat_bloc.dart';

@immutable
sealed class SuratState {}

final class SuratInitial extends SuratState {}

final class SuratLoading extends SuratState {}

final class SuratFailed extends SuratState {
  final String error;

  SuratFailed({required this.error});
}

final class SuratSuccess extends SuratState {
  final SuratResponseModel surat;

  SuratSuccess({required this.surat});
}
