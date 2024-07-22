import 'package:alquran_digital/view/pages/home_page.dart';
import 'package:alquran_digital/view/pages/surat_detail_page.dart';
import 'package:alquran_digital/view/pages/tafsir_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: 'surat/:nomor',
          name: 'surat',
          builder: (BuildContext context, GoRouterState state) {
            return SuratDetailPage(nomor: int.parse(state.pathParameters['nomor']!));
          },
          routes: [
            GoRoute(
              path: 'tafsir/:nomorsurat',
              name: 'tafsir',
              builder: (BuildContext context, GoRouterState state) {
                return TafsirPage(
                  nomor: int.parse(state.pathParameters['nomorsurat']!),
                  surat: state.extra as String,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
