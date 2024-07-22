import 'package:alquran_digital/models/surat_model.dart';
import 'package:alquran_digital/services/surat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'surat_detail_event.dart';
part 'surat_detail_state.dart';

class SuratDetailBloc extends Bloc<SuratDetailEvent, SuratDetailState> {
  final SuratService _service;

  SuratDetailBloc(this._service) : super(SuratDetailInitial()) {
    on<GetSuratDetailEvent>((event, emit) async {
      try {
        emit(SuratDetailLoading());
        final suratDetailResponse = await _service.getSuratDetail(event.nomor);
        emit(SuratDetailSuccess(surat: suratDetailResponse));
      } catch (e) {
        emit(SuratDetailFailed(error: e.toString()));
      }
    });
  }
}
