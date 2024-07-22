import 'package:alquran_digital/app/view/atom/color_atom.dart';
import 'package:alquran_digital/models/surat_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuratMolecule extends StatelessWidget {
  const SuratMolecule({
    super.key,
    this.surat,
  });

  final SuratModel? surat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.goNamed(
        'surat',
        pathParameters: {
          'nomor': surat?.nomor.toString() ?? '',
        },
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Container(
        decoration: const ShapeDecoration(
          shape: StarBorder(
            points: 8.00,
            rotation: 0.00,
            innerRadiusRatio: 0.80,
            pointRounding: 0.00,
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
              '${surat?.nomor ?? 0}',
              style: const TextStyle(
                color: ColorAtom.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      title: Text(
        surat?.namaLatin ?? '',
        style: const TextStyle(color: ColorAtom.white),
      ),
      subtitle: Text(
        '${surat?.tempatTurun?.toUpperCase()} | ${surat?.arti}',
        style: const TextStyle(
          color: ColorAtom.grey,
          fontSize: 12,
        ),
      ),
      trailing: Text(
        surat?.nama ?? '',
        style: const TextStyle(
          fontSize: 18,
          color: ColorAtom.purple,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
