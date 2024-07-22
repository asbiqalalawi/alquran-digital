import 'package:alquran_digital/app/view/atom/color_atom.dart';
import 'package:alquran_digital/bloc/tafsir_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TafsirPage extends StatefulWidget {
  const TafsirPage({super.key, required this.nomor, this.surat});

  final int nomor;
  final String? surat;

  @override
  State<TafsirPage> createState() => _TafsirPageState();
}

class _TafsirPageState extends State<TafsirPage> {
  @override
  void initState() {
    super.initState();
    context.read<TafsirBloc>().add(GetTafsirEvent(nomor: widget.nomor));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tafsir ${widget.surat}'),
      ),
      body: BlocBuilder<TafsirBloc, TafsirState>(
        builder: (context, state) {
          if (state is TafsirSuccess) {
            final tafsir = state.tafsir.data;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<TafsirBloc>().add(GetTafsirEvent(nomor: widget.nomor));
              },
              child: Scrollbar(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorAtom.black2,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Ayat ${tafsir.tafsir?[index].ayat}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: ColorAtom.purple,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(tafsir.tafsir?[index].teks ?? ''),
                      ],
                    ),
                  ),
                  itemCount: tafsir.tafsir?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                ),
              ),
            );
          } else if (state is TafsirLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TafsirFailed) {
            return Center(child: Text(state.error));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
