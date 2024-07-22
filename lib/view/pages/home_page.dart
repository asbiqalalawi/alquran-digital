import 'package:alquran_digital/bloc/surat_bloc.dart';
import 'package:alquran_digital/view/organism/surat_organism.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<SuratBloc>().add(GetSuratEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baca Qur\'an'),
      ),
      body: BlocBuilder<SuratBloc, SuratState>(
        builder: (context, state) {
          if (state is SuratSuccess) {
            return SuratOrganism(surat: state.surat.data);
          } else if (state is SuratLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuratFailed) {
            return Center(child: Text(state.error));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
