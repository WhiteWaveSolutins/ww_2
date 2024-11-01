enum CustomizeBody {
  square,
  circle,
  circular,
  japnese,
  pointed_edge_cut,
  pointed_smooth,
  rounded_in_smooth,
  diamond,
  mosaic,
  circle_zebra,
  edge_cut,
  leaf,
  pointed_in,
  round,
  rounded_pointed,
  star,
  rounded_in,
  dot,
  circle_zebra_vertical,
  edge_cut_smooth,
  pointed,
  pointed_in_smooth,
}

enum CustomizeEye {
  frame0,
  frame1,
  frame2,
  frame3,
  frame4,
  frame5,
  frame6,
  frame7,
  frame8,
  frame10,
  frame11,
  frame12,
  frame13,
  frame14,
  frame16,
}

enum CustomizeEyeBall {
  ball0,
  ball1,
  ball2,
  ball3,
  ball5,
  ball6,
  ball7,
  ball8,
  ball10,
  ball11,
  ball12,
  ball13,
  ball14,
  ball15,
  ball16,
  ball17,
  ball18,
  ball19,
}

String enumCustomizeIcon(String type) {
  return 'assets/customize/${type.replaceAll('_', '-')}.png';
}
