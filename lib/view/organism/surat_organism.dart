import 'package:alquran_digital/bloc/surat_bloc.dart';
import 'package:alquran_digital/models/surat_model.dart';
import 'package:alquran_digital/view/molecule/surat_molecule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuratOrganism extends StatelessWidget {
  const SuratOrganism({
    super.key,
    required this.surat,
  });

  final List<SuratModel>? surat;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SuratBloc>().add(GetSuratEvent());
      },
      child: Scrollbar(
        child: ListView.builder(
          itemBuilder: (context, index) => SuratMolecule(surat: surat?[index]),
          itemCount: surat?.length,
        ),
      ),
    );
  }
}
