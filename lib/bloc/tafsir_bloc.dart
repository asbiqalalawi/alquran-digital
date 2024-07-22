import 'package:alquran_digital/models/surat_model.dart';
import 'package:alquran_digital/services/tafsir_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tafsir_event.dart';
part 'tafsir_state.dart';

class TafsirBloc extends Bloc<TafsirEvent, TafsirState> {
  final TafsirService _service;

  TafsirBloc(this._service) : super(TafsirInitial()) {
    on<GetTafsirEvent>((event, emit) async {
      try {
        emit(TafsirLoading());
        final tafsirResponse = await _service.getTafsir(event.nomor);
        emit(TafsirSuccess(tafsir: tafsirResponse));
      } catch (e) {
        emit(TafsirFailed(error: e.toString()));
      }
    });
  }
}
