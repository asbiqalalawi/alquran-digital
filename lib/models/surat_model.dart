class SuratResponseModel {
  int? code;
  String? message;
  List<SuratModel>? data;

  SuratResponseModel({
    this.code,
    this.message,
    this.data,
  });

  factory SuratResponseModel.fromJson(Map<String, dynamic> json) => SuratResponseModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? [] : List<SuratModel>.from(json["data"]!.map((x) => SuratModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SuratDetailResponseModel {
  int code;
  String message;
  SuratModel data;

  SuratDetailResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SuratDetailResponseModel.fromJson(Map<String, dynamic> json) => SuratDetailResponseModel(
        code: json["code"],
        message: json["message"],
        data: SuratModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class SuratModel {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  Map<String, String>? audioFull;
  List<AyatModel>? ayat;
  List<TafsirModel>? tafsir;
  SuratSelanjutnyaModel? suratSelanjutnya;
  SuratSelanjutnyaModel? suratSebelumnya;

  SuratModel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audioFull,
    this.ayat,
    this.tafsir,
    this.suratSelanjutnya,
    this.suratSebelumnya,
  });

  factory SuratModel.fromJson(Map<String, dynamic> json) => SuratModel(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
        tempatTurun: json["tempatTurun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: Map.from(json["audioFull"]!).map((k, v) => MapEntry<String, String>(k, v)),
        ayat: json["ayat"] == null ? [] : List<AyatModel>.from(json["ayat"]!.map((x) => AyatModel.fromJson(x))),
        tafsir:
            json["tafsir"] == null ? [] : List<TafsirModel>.from(json["tafsir"]!.map((x) => TafsirModel.fromJson(x))),
        suratSelanjutnya: (json["suratSelanjutnya"] == null || json["suratSelanjutnya"] == false)
            ? null
            : SuratSelanjutnyaModel.fromJson(json["suratSelanjutnya"]),
        suratSebelumnya: (json["suratSebelumnya"] == null || json["suratSebelumnya"] == false)
            ? null
            : SuratSelanjutnyaModel.fromJson(json["suratSebelumnya"]),
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
        "tempatTurun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audioFull": Map.from(audioFull!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ayat": ayat == null ? [] : List<dynamic>.from(ayat!.map((x) => x.toJson())),
        "tafsir": tafsir == null ? [] : List<dynamic>.from(tafsir!.map((x) => x.toJson())),
        "suratSelanjutnya": suratSelanjutnya?.toJson(),
        "suratSebelumnya": suratSebelumnya?.toJson(),
      };
}

class AyatModel {
  int nomorAyat;
  String teksArab;
  String teksLatin;
  String teksIndonesia;
  Map<String, String> audio;

  AyatModel({
    required this.nomorAyat,
    required this.teksArab,
    required this.teksLatin,
    required this.teksIndonesia,
    required this.audio,
  });

  factory AyatModel.fromJson(Map<String, dynamic> json) => AyatModel(
        nomorAyat: json["nomorAyat"],
        teksArab: json["teksArab"],
        teksLatin: json["teksLatin"],
        teksIndonesia: json["teksIndonesia"],
        audio: Map.from(json["audio"]).map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "nomorAyat": nomorAyat,
        "teksArab": teksArab,
        "teksLatin": teksLatin,
        "teksIndonesia": teksIndonesia,
        "audio": Map.from(audio).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class SuratSelanjutnyaModel {
  int nomor;
  String nama;
  String namaLatin;
  int jumlahAyat;

  SuratSelanjutnyaModel({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
  });

  factory SuratSelanjutnyaModel.fromJson(Map<String, dynamic> json) => SuratSelanjutnyaModel(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "namaLatin": namaLatin,
        "jumlahAyat": jumlahAyat,
      };
}

class TafsirModel {
  int ayat;
  String teks;

  TafsirModel({
    required this.ayat,
    required this.teks,
  });

  factory TafsirModel.fromJson(Map<String, dynamic> json) => TafsirModel(
        ayat: json["ayat"],
        teks: json["teks"],
      );

  Map<String, dynamic> toJson() => {
        "ayat": ayat,
        "teks": teks,
      };
}
