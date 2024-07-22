part of 'surat_detail_bloc.dart';

@immutable
sealed class SuratDetailState {}

final class SuratDetailInitial extends SuratDetailState {}

final class SuratDetailLoading extends SuratDetailState {}

final class SuratDetailFailed extends SuratDetailState {
  final String error;

  SuratDetailFailed({required this.error});
}

final class SuratDetailSuccess extends SuratDetailState {
  final SuratDetailResponseModel surat;

  SuratDetailSuccess({required this.surat});
}
