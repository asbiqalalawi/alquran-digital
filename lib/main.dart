import 'package:alquran_digital/app/view/atom/color_atom.dart';
import 'package:alquran_digital/app/view/atom/route/route.dart';
import 'package:alquran_digital/bloc/surat_bloc.dart';
import 'package:alquran_digital/bloc/surat_detail_bloc.dart';
import 'package:alquran_digital/bloc/tafsir_bloc.dart';
import 'package:alquran_digital/services/surat_service.dart';
import 'package:alquran_digital/services/tafsir_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SuratBloc(SuratService()),
        ),
        BlocProvider(
          create: (context) => SuratDetailBloc(SuratService()),
        ),
        BlocProvider(
          create: (context) => TafsirBloc(TafsirService()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Al-quran Digital',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorAtom.black,
          textTheme: GoogleFonts.latoTextTheme().apply(
            bodyColor: ColorAtom.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: ColorAtom.black,
            titleTextStyle: TextStyle(
              color: ColorAtom.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: ColorAtom.purple,
            ),
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
