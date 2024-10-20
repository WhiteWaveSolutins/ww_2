import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_code.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/widgets/app_barcode.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/buttons/simple_button.dart';
import 'package:ww_2/ui/widgets/image_back.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class LocalCodeScreen extends StatelessWidget {
  final LocalBarcode localBarcode;

  const LocalCodeScreen({
    super.key,
    required this.localBarcode,
  });

  @override
  Widget build(BuildContext context) {
    return ImageBack(
      image: AppImages.back,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Scan saved'),
          centerTitle: true,
          leading: const LeftButton(),
          actions: [
            IconButton(
              onPressed: () {
                getItService.localCodeUseCase.deleteSave(localBarcode);
                getItService.navigatorService.onPop();
              },
              icon: const Icon(
                CupertinoIcons.trash,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 35),
              Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: AppBarcode(
                        data: localBarcode.barcodeData,
                        radius: 30,
                        size: 300,
                        padding: localBarcode.format != BarcodeFormat.qrCode ? 20 : 15,
                      ),
                    ),
                    if (localBarcode.type != null)
                      Text(
                        typeCodeToIcon(localBarcode.type!),
                        style: const TextStyle(fontSize: 25),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                localBarcode.title,
                style: AppText.text1.copyWith(
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              SimpleButton(
                onTap: () async {
                  final url = Uri.parse(localBarcode.data);
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                title: 'Open in browser',
                icon: AppIcons.globe,
                centerTitle: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SimpleButton(
                      onTap: () => Share.share(localBarcode.data),
                      title: 'Share',
                      icon: AppIcons.share,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SimpleButton(
                      onTap: () => getItService.navigatorService.onSaveCode(barcode: localBarcode),
                      title: 'Edit',
                      icon: AppIcons.save,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
