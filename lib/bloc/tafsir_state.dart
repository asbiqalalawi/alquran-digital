part of 'tafsir_bloc.dart';

@immutable
sealed class TafsirState {}

final class TafsirInitial extends TafsirState {}

final class TafsirLoading extends TafsirState {}

final class TafsirFailed extends TafsirState {
  final String error;

  TafsirFailed({required this.error});
}

final class TafsirSuccess extends TafsirState {
  final SuratDetailResponseModel tafsir;

  TafsirSuccess({required this.tafsir});
}
