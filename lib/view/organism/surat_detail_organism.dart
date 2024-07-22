import 'package:alquran_digital/app/view/atom/color_atom.dart';
import 'package:alquran_digital/bloc/surat_detail_bloc.dart';
import 'package:alquran_digital/models/surat_model.dart';
import 'package:alquran_digital/view/molecule/ayat_moelcule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

class SuratDetailOrganism extends StatefulWidget {
  const SuratDetailOrganism({
    super.key,
    required this.surat,
  });

  final SuratModel surat;

  @override
  State<SuratDetailOrganism> createState() => _SuratDetailOrganismState();
}

class _SuratDetailOrganismState extends State<SuratDetailOrganism> {
  final player = AudioPlayer();
  bool playing = false;
  double volume = 1.0;

  @override
  void initState() {
    super.initState();
    player.setUrl(widget.surat.audioFull?.values.first ?? '');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SuratDetailBloc>().add(GetSuratDetailEvent(nomor: widget.surat.nomor));
      },
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: (widget.surat.suratSelanjutnya != null)
                        ? TextButton.icon(
                            onPressed: () {
                              context
                                  .read<SuratDetailBloc>()
                                  .add(GetSuratDetailEvent(nomor: widget.surat.suratSelanjutnya?.nomor ?? 1));
                            },
                            label: Text(
                              '${widget.surat.suratSelanjutnya?.nomor}. ${widget.surat.suratSelanjutnya?.namaLatin}',
                              style: const TextStyle(
                                color: ColorAtom.white,
                                fontSize: 12,
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: ColorAtom.white,
                              size: 16,
                            ),
                          )
                        : const SizedBox(),
                  ),
                  Expanded(
                    child: Text(
                      '${widget.surat.nomor}. ${widget.surat.namaLatin}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: (widget.surat.suratSebelumnya != null)
                        ? TextButton.icon(
                            onPressed: () {
                              context
                                  .read<SuratDetailBloc>()
                                  .add(GetSuratDetailEvent(nomor: widget.surat.suratSebelumnya?.nomor ?? 1));
                            },
                            label: Text(
                              '${widget.surat.suratSebelumnya?.nomor}. ${widget.surat.suratSebelumnya?.namaLatin}',
                              style: const TextStyle(
                                color: ColorAtom.white,
                                fontSize: 12,
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: ColorAtom.white,
                              size: 16,
                            ),
                            iconAlignment: IconAlignment.end,
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.surat.namaLatin} (${widget.surat.arti})',
                              style: const TextStyle(
                                color: ColorAtom.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${widget.surat.tempatTurun} ${widget.surat.jumlahAyat} ayat',
                              style: const TextStyle(
                                color: ColorAtom.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => context.goNamed(
                                'tafsir',
                                pathParameters: {
                                  'nomor': widget.surat.nomor.toString(),
                                  'nomorsurat': widget.surat.nomor.toString(),
                                },
                                extra: widget.surat.namaLatin,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: ColorAtom.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.assignment_rounded,
                                      color: ColorAtom.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Lihat Tafsir',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: InkWell(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              onTap: () {
                                setState(() {
                                  if (playing) {
                                    player.stop();
                                    playing = false;
                                  } else {
                                    player.seek(Duration.zero);
                                    player.play();
                                    playing = true;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: ColorAtom.green,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      playing ? Icons.stop : Icons.play_arrow_rounded,
                                      color: ColorAtom.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      playing ? 'Stop Audio' : 'Play Audio',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => AyatMolecule(ayat: widget.surat.ayat?[index]),
                        itemCount: widget.surat.ayat?.length ?? 0,
                        separatorBuilder: (context, index) => const SizedBox(height: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (playing)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    color: ColorAtom.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        volume -= 0.5;
                        player.setVolume(volume);
                      },
                      icon: const Icon(Icons.volume_down),
                    ),
                    IconButton(
                      onPressed: () {
                        volume += 0.5;
                        player.setVolume(volume);
                      },
                      icon: const Icon(Icons.volume_up),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (player.playing) {
                            player.pause();
                          } else {
                            player.play();
                          }
                        });
                      },
                      icon: player.playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          player.stop();
                          playing = false;
                        });
                      },
                      icon: const Icon(Icons.stop),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
