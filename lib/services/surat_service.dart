import 'package:alquran_digital/app/view/atom/const/service_const.dart';
import 'package:alquran_digital/models/surat_model.dart';

class SuratService {
  Future<SuratResponseModel> getSurat() async {
    try {
      final response = await ServiceConst.dio.get('/api/v2/surat');
      final surat = SuratResponseModel.fromJson(response.data);
      return surat;
    } catch (_) {
      rethrow;
    }
  }

  Future<SuratDetailResponseModel> getSuratDetail(int nomor) async {
    try {
      final response = await ServiceConst.dio.get('/api/v2/surat/$nomor');
      final surat = SuratDetailResponseModel.fromJson(response.data);
      return surat;
    } catch (_) {
      rethrow;
    }
  }
}
