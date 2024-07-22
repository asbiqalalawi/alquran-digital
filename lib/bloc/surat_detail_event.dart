part of 'surat_detail_bloc.dart';

@immutable
sealed class SuratDetailEvent {}

final class GetSuratDetailEvent extends SuratDetailEvent {
  final int nomor;

  GetSuratDetailEvent({required this.nomor});
}
