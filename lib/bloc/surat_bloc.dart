import 'package:alquran_digital/models/surat_model.dart';
import 'package:alquran_digital/services/surat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'surat_event.dart';
part 'surat_state.dart';

class SuratBloc extends Bloc<SuratEvent, SuratState> {
  final SuratService _service;

  SuratBloc(this._service) : super(SuratInitial()) {
    on<GetSuratEvent>((event, emit) async {
      try {
        emit(SuratLoading());
        final suratResponse = await _service.getSurat();
        emit(SuratSuccess(surat: suratResponse));
      } catch (e) {
        emit(SuratFailed(error: e.toString()));
      }
    });
  }
}
