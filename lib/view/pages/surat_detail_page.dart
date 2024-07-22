import 'package:alquran_digital/bloc/surat_detail_bloc.dart';
import 'package:alquran_digital/view/organism/surat_detail_organism.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuratDetailPage extends StatefulWidget {
  const SuratDetailPage({super.key, required this.nomor});

  final int nomor;

  @override
  State<SuratDetailPage> createState() => _SuratDetailPageState();
}

class _SuratDetailPageState extends State<SuratDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<SuratDetailBloc>().add(GetSuratDetailEvent(nomor: widget.nomor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah'),
      ),
      body: BlocBuilder<SuratDetailBloc, SuratDetailState>(
        builder: (context, state) {
          if (state is SuratDetailSuccess) {
            return SuratDetailOrganism(surat: state.surat.data);
          } else if (state is SuratDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuratDetailFailed) {
            return Center(child: Text(state.error));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
