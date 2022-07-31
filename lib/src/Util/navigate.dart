import 'package:flutter/material.dart';
import 'package:rpgaming/src/Util/custom_page_route.dart';

Future<void> to(BuildContext context, Widget page) async {
  Navigator.of(context).push(
    CustomPageRouteFade(child: page, duration: const Duration(milliseconds: 400)),
  );
}

Future<void> pushNamed(context, String route) async {
  await Navigator.of(context).pushNamed(route);
}