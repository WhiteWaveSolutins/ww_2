import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/state.dart';
import 'package:ww_2/ui/widgets/buttons/button_with_icon.dart';
import 'package:ww_2/ui/widgets/gradient_text.dart';
import 'package:ww_2/ui/widgets/image_back.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Store<AppState> _store;

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
    if (_store.state.savedCodeListState.codes.isEmpty) {
      _store.dispatch(LoadSaveLocalCodeListAction());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        child: ImageBack(
          image: AppImages.mainBack,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 11),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 1,
                      onPressed: getItService.navigatorService.onSettings,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(.2),
                          border: Border.all(color: AppColors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(13),
                        child: const SvgIcon(
                          icon: AppIcons.setting,
                          color: AppColors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.black,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary,
                            blurRadius: 53,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppImages.scanner,
                      ),
                    ),
                    Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'QR & Barcode',
                      style: AppText.h2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GradientText.primary(
                      'Scaner',
                      style: AppText.h2.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ButtonWithIcon(
                  onPressed: getItService.navigatorService.onScan,
                  title: 'SCANNING CODE',
                  icon: AppIcons.qrCode,
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    _Button(
                      title: 'Saved',
                      icon: AppIcons.star,
                      onTap: getItService.navigatorService.onSavedCodes,
                    ),
                    const SizedBox(width: 9),
                    _Button(
                      title: 'Scan history',
                      icon: AppIcons.clock,
                      onTap: getItService.navigatorService.onHistoryCodes,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                StoreConnector<AppState, SubscriptionState>(
                  converter: (store) => store.state.subscriptionState,
                  builder: (context, state) {
                    return Row(
                      children: [
                        _Button(
                          onTap: () {
                            if (state.hasPremium) {
                              getItService.navigatorService.onGenerate();
                            } else {
                              getItService.navigatorService.onGetPremium();
                            }
                          },
                          title: 'Generate',
                          icon: AppIcons.generate,
                          isPay: !state.hasPremium,
                        ),
                        const SizedBox(width: 4),
                        _Button(
                          onTap: () {
                            if (state.hasPremium) {
                              getItService.navigatorService.onCreated();
                            } else {
                              getItService.navigatorService.onGetPremium();
                            }
                          },
                          title: 'Created',
                          icon: AppIcons.layers,
                          isPay: !state.hasPremium,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final String icon;
  final bool isPay;
  final Function()? onTap;

  const _Button({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.isPay = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 1,
            onPressed: onTap,
            child: Container(
              margin: const EdgeInsets.only(
                top: 5,
                right: 5,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.2),
                borderRadius: BorderRadius.circular(20),
                border: const Border(
                  bottom: BorderSide(
                    color: AppColors.primary,
                    width: 4,
                  ),
                ),
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
                      const SizedBox(height: 8),
                      SvgIcon(
                        icon: icon,
                        color: AppColors.primary,
                        size: 50,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: AppText.text1.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isPay)
            Image.asset(
              AppImages.almaz,
              width: 40,
            ),
        ],
      ),
    );
  }
}
