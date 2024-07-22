part of 'tafsir_bloc.dart';

@immutable
sealed class TafsirEvent {}

final class GetTafsirEvent extends TafsirEvent {
  final int nomor;

  GetTafsirEvent({required this.nomor});
}
