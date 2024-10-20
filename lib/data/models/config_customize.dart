import 'package:flutter/material.dart';
import 'package:ww_2/domain/enums/customize.dart';
import 'package:ww_2/ui/resurses/extension.dart';

class ConfigCustomize {
  late CustomizeBody? body;
  late CustomizeEye? eye;
  late CustomizeEyeBall? eyeBall;
  late Color? color;
  late String? logo;
  late Color? back;
  late List<String>? gradient;

  ConfigCustomize({
    this.body,
    this.eye,
    this.eyeBall,
    this.logo,
    this.color,
    this.back,
    this.gradient,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (body != null) map.addAll({'body': body!.name.replaceAll('_', '-')});
    if (eye != null) map.addAll({'eye': eye!.name});
    if (logo != null) map.addAll({'logo': '#$logo'});
    if (eyeBall != null) map.addAll({'eyeBall': eyeBall!.name});
    if ((gradient ?? []).isNotEmpty) {
      map.addAll({
        'gradientColor1': gradient!.first,
        'gradientColor2': gradient!.last,
      });
    }
    if (color != null) {
      map.addAll({
        'bodyColor': color!.toHex(),
        'eye1Color': color!.toHex(),
        'eye2Color': color!.toHex(),
        'eye3Color': color!.toHex(),
        'eyeBall1Color': color!.toHex(),
        'eyeBall2Color': color!.toHex(),
        'eyeBall3Color': color!.toHex(),
      });
    }
    if (back != null) map.addAll({'bgColor': back!.toHex()});
    return map;
  }
}
