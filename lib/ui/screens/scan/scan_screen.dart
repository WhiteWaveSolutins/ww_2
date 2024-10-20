import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/scan/widgets/scan_overlay.dart';
import 'package:ww_2/ui/screens/scan/widgets/successfully_scan.dart';
import 'package:ww_2/ui/state_manager/store.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final controller = MobileScannerController();
  late BarcodeCapture? code;
  late Store<AppState> _store;
  late List<LocalBarcode> codes;

  @override
  void initState() {
    super.initState();
    code = null;
    _store = StoreProvider.of<AppState>(context, listen: false);
    codes = _store.state.savedCodeListState.codes.toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScan(BarcodeCapture data) async {
    if (code == null) {
      code = data;
      if (codes.isNotEmpty) {
        final result =
            codes.where((e) => e.data == (data.barcodes.firstOrNull?.displayValue ?? '')).toList();
        if (result.isNotEmpty) {
          getItService.navigatorService.onPop();
          getItService.navigatorService.onLocalCode(barcode: result.first);
          return;
        }
      }
      getItService.localCodeUseCase.addHistory(data);
      await showModalBottomSheet(
        context: context,
        constraints: BoxConstraints(
          minHeight: 100,
          maxHeight: MediaQuery.of(context).size.height - 150,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => SuccessfullyScan(barcode: data),
      );
      code = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: controller,
            onDetect: onScan,
            overlayBuilder: (context, constraints) => const ScanOverlay(),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 24,
            child: const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _Top(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Top extends StatelessWidget {
  const _Top({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'SCANNING CODE',
            textAlign: TextAlign.center,
            style: AppText.text16,
          ),
        ),
        GestureDetector(
          onTap: getItService.navigatorService.onPop,
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.clear,
              size: 15,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
