import 'package:alquran_digital/app/view/atom/const/service_const.dart';
import 'package:alquran_digital/models/surat_model.dart';

class TafsirService {
  Future<SuratDetailResponseModel> getTafsir(int nomor) async {
    try {
      final response = await ServiceConst.dio.get('/api/v2/tafsir/$nomor');
      final tafsir = SuratDetailResponseModel.fromJson(response.data);
      return tafsir;
    } catch (_) {
      rethrow;
    }
  }
}
