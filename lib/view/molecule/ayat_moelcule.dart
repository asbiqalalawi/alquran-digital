import 'package:flutter/material.dart';
import 'package:alquran_digital/app/view/atom/color_atom.dart';
import 'package:alquran_digital/models/surat_model.dart';

class AyatMolecule extends StatelessWidget {
  const AyatMolecule({
    super.key,
    this.ayat,
    required this.onPlay,
    required this.onPause,
    required this.isPlaying,
  });

  final AyatModel? ayat;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const ShapeDecoration(
            shape: StarBorder(
              points: 10.00,
              rotation: 0.00,
              innerRadiusRatio: 0.70,
              valleyRounding: 0.60,
              side: BorderSide(
                color: ColorAtom.purple,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: 24,
              child: Text(
                '${ayat?.nomorAyat ?? 0}',
                style: const TextStyle(
                  color: ColorAtom.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  ayat?.teksArab ?? '',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: Text(
                  ayat?.teksLatin ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorAtom.purple,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: Text(
                  ayat?.teksIndonesia ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorAtom.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(isPlaying ? Icons.stop_circle : Icons.play_circle),
          onPressed: () {
            if (isPlaying) {
              onPause();
            } else {
              onPlay();
            }
          },
          color: ColorAtom.green,
        ),
      ],
    );
  }
}
