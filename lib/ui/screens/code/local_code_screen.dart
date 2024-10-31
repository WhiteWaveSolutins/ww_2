import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_code.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/state.dart';
import 'package:ww_2/ui/widgets/app_barcode.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/buttons/simple_button.dart';
import 'package:ww_2/ui/widgets/image_back.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

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
                showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (context) => DeleteQr(
                    onDelete: () {
                      getItService.localCodeUseCase.deleteSave(localBarcode);
                      getItService.navigatorService.onPop();
                      getItService.navigatorService.onPop();
                    },
                  ),
                );
              },
              icon: const SvgIcon(icon: AppIcons.trash),
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
              StoreConnector<AppState, SubscriptionState>(
                converter: (store) => store.state.subscriptionState,
                builder: (context, state) {
                  return SimpleButton(
                    onTap: () async {
                      if (!state.hasPremium) {
                        getItService.navigatorService.onGetPremium();
                        return;
                      }
                      final url = Uri.parse(localBarcode.data);
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    title: 'Open in browser',
                    icon: AppIcons.globe,
                    centerTitle: true,
                  );
                },
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

class DeleteQr extends StatelessWidget {
  final Function() onDelete;

  const DeleteQr({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Navigator.of(context).pop,
      onHorizontalDragStart: (_) => Navigator.of(context).pop(),
      child: Stack(
        children: [
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomRight,
          ),
          Positioned(
            top: 55,
            right: 10,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 163,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 20,
                      sigmaY: 20,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (_) => CupertinoAlertDialog(
                                title: const Text('Clear history'),
                                content: const Text('Are you sure you want to remove this code'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    onPressed: onDelete,
                                    isDefaultAction: true,
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: Navigator.of(context).pop,
                                    isDefaultAction: true,
                                    child: const Text(
                                      "No",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Delete',
                              style: AppText.text3.copyWith(
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.white.withOpacity(.1),
                          height: 1,
                        ),
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Cancel',
                              style: AppText.text3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
