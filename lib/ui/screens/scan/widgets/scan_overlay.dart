import 'package:flutter/material.dart';
import 'package:ww_2/ui/resurses/colors.dart';

class ScanOverlay extends StatelessWidget {
  const ScanOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 300,
        height: 500,
        child: Stack(
          children: [
            _Box(alignment: Alignment.topLeft),
            _Box(alignment: Alignment.topRight),
            _Box(alignment: Alignment.bottomLeft),
            _Box(alignment: Alignment.bottomRight),
          ],
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final Alignment alignment;

  const _Box({
    super.key,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: alignment == Alignment.topLeft ? const Radius.circular(20) : Radius.zero,
              topRight: alignment == Alignment.topRight ? const Radius.circular(20) : Radius.zero,
              bottomRight:
                  alignment == Alignment.bottomRight ? const Radius.circular(20) : Radius.zero,
              bottomLeft:
                  alignment == Alignment.bottomLeft ? const Radius.circular(20) : Radius.zero,
            ),
            border: Border(
              top: ![Alignment.topRight, Alignment.topLeft].contains(alignment)
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.white, width: 3),
              left: ![Alignment.bottomLeft, Alignment.topLeft].contains(alignment)
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.white, width: 3),
              bottom: ![Alignment.bottomRight, Alignment.bottomLeft].contains(alignment)
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.white, width: 3),
              right: ![Alignment.topRight, Alignment.bottomRight].contains(alignment)
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.white, width: 3),
            ),
          ),
          child: const SizedBox(
            width: 50,
            height: 80,
          ),
        ),
      ),
    );
  }
}
