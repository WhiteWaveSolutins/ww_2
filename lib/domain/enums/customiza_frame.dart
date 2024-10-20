import 'package:flutter/material.dart';
import 'package:ww_2/data/models/config_customize.dart';
import 'package:ww_2/domain/enums/customize.dart';
import 'package:ww_2/ui/resurses/extension.dart';

enum CustomizeFrame {
  classic,
  rainbow,
  cyberpunk,
  twitter,
  blue,
  facebook,
  mosaic,
  light,
  jungle,
  rain,
  youtube,
  point,
}

String customizeFrameIcon(CustomizeFrame frame) {
  return 'assets/customize/pattern/${frame.name}.png';
}

String customizeFrameTitle(CustomizeFrame frame) {
  if (frame == CustomizeFrame.cyberpunk) return 'Cyber punk';
  if (frame == CustomizeFrame.youtube) return 'YouTube';
  return frame.name.capitalize();
}

ConfigCustomize? frameToConfig(CustomizeFrame? frame) {
  if (frame == null) return null;
  final map = {
    CustomizeFrame.classic: ConfigCustomize(),
    CustomizeFrame.rainbow: ConfigCustomize(
      eyeBall: CustomizeEyeBall.ball5,
      eye: CustomizeEye.frame13,
      gradient: ['#ff0301', '#b067f9'],
    ),
    CustomizeFrame.cyberpunk: ConfigCustomize(
      gradient: ['#535be1', '#b067f9'],
      eye: CustomizeEye.frame3,
      eyeBall: CustomizeEyeBall.ball16,
    ),
    CustomizeFrame.twitter: ConfigCustomize(
      eye: CustomizeEye.frame5,
      eyeBall: CustomizeEyeBall.ball1,
      color: Colors.blueAccent,
      body: CustomizeBody.circular,
      logo: 'twitter',
    ),
    CustomizeFrame.blue: ConfigCustomize(
      eyeBall: CustomizeEyeBall.ball1,
      color: Colors.blue,
    ),
    CustomizeFrame.facebook: ConfigCustomize(
      eye: CustomizeEye.frame2,
      eyeBall: CustomizeEyeBall.ball2,
      color: Colors.blueAccent,
      logo: 'facebook',
    ),
    CustomizeFrame.mosaic: ConfigCustomize(
      gradient: ['#983a40', '#2970ae'],
      eye: CustomizeEye.frame4,
      eyeBall: CustomizeEyeBall.ball7,
      body: CustomizeBody.mosaic,
    ),
    CustomizeFrame.light: ConfigCustomize(
      eye: CustomizeEye.frame13,
      eyeBall: CustomizeEyeBall.ball15,
      body: CustomizeBody.circular,
      color: Colors.blueAccent,
    ),
    CustomizeFrame.jungle: ConfigCustomize(
      eye: CustomizeEye.frame14,
      eyeBall: CustomizeEyeBall.ball16,
      body: CustomizeBody.rounded_pointed,
      color: Colors.lightGreen,
    ),
    CustomizeFrame.rain: ConfigCustomize(
      eye: CustomizeEye.frame13,
      eyeBall: CustomizeEyeBall.ball15,
      body: CustomizeBody.round,
      color: Colors.blue,
    ),
    CustomizeFrame.youtube: ConfigCustomize(
      eye: CustomizeEye.frame13,
      eyeBall: CustomizeEyeBall.ball15,
      body: CustomizeBody.mosaic,
      color: Colors.red,
      logo: 'youtube',
    ),
    CustomizeFrame.point: ConfigCustomize(
      eyeBall: CustomizeEyeBall.ball14,
      body: CustomizeBody.dot,
      color: Colors.blue,
    ),
  };
  return map[frame]!;
}
