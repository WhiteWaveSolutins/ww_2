import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/onboarding/widgets/onboarding_widget.dart';
import 'package:ww_2/ui/state_manager/paywall/action.dart';
import 'package:ww_2/ui/state_manager/paywall/state.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/state_manager/subscription/action.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: page == 0
            ? OnboardingWidget(
                image: Image.asset(AppImages.onboarding1),
                title: 'Qr & Barcodes scanner',
                subtitle: 'Scan QR codes or barcodes and save them to your history',
                onTapButton: () {
                  setState(() => page = 1);
                  InAppReview.instance.requestReview();
                },
              )
            : page == 1
                ? _Onboarding2(onTapButton: () => setState(() => page = 2))
                : page == 2
                    ? OnboardingWidget(
                        image: Image.asset(
                          AppImages.onboarding3,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        title: 'Generation of own Qr codes',
                        subtitle: 'Create your own Qr codes and customize them',
                        onTapButton: () => setState(() => page = 3),
                      )
                    : StoreConnector<AppState, PaywallListState>(
                        converter: (store) => store.state.paywallListState,
                        builder: (context, state) {
                          return OnboardingWidget(
                            image: Image.asset(
                              AppImages.onboarding4,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            title: 'state.paywalls.first.title',
                            subtitle: 'Start your 3-day free trial.\nThan 4.99\$ per week',
                            subtitleTapper: 'Or proceed with limited version',
                            buttonText: 'state.paywalls.first.buttonLabel',
                            tapperOnTap: getItService.navigatorService.onMain,
                            onTapButton: () {
                              final store = StoreProvider.of<AppState>(context, listen: false);
                              store.dispatch(
                                PurchaseSubscriptionAction(
                                  onFinish: getItService.navigatorService.onMain,
                                  onError: (e) {
                                    showDialog(
                                      context: context,
                                      builder: (_) => CupertinoAlertDialog(
                                        title: const Text("Some Error"),
                                        content: Text(e),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            onPressed: Navigator.of(context).pop,
                                            isDefaultAction: true,
                                            child: const Text(
                                              "Ok",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onLoad: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => const Center(
                                        child: CupertinoActivityIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                  productId: 'state.paywalls.first.productId',
                                ),
                              );
                            },
                          );
                          if (state.isLoading) {
                            return const Center(
                              child: CupertinoActivityIndicator(
                                color: Colors.white,
                                radius: 20,
                              ),
                            );
                          }
                          if (state.isError || state.paywalls.isEmpty) {
                            return CupertinoAlertDialog(
                              title: const Text("Some Error"),
                              content: Text(
                                state.isError ? state.errorMessage : 'Paywalls list is empty',
                              ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: () {
                                    final store = StoreProvider.of<AppState>(
                                      context,
                                      listen: false,
                                    );
                                    store.dispatch(LoadPaywallListAction());
                                  },
                                  isDefaultAction: true,
                                  child: const Text(
                                    'Refresh',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          }
                          return OnboardingWidget(
                            image: Image.asset(
                              AppImages.onboarding4,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            title: state.paywalls.first.title,
                            subtitle: 'Start your 3-day free trial.\nThan 4.99\$ per week',
                            subtitleTapper: 'Or proceed with limited version',
                            buttonText: state.paywalls.first.buttonLabel,
                            tapperOnTap: getItService.navigatorService.onMain,
                            onTapButton: () {
                              final store = StoreProvider.of<AppState>(context, listen: false);
                              store.dispatch(
                                PurchaseSubscriptionAction(
                                  onFinish: Navigator.of(context).pop,
                                  onError: (e) {
                                    showDialog(
                                      context: context,
                                      builder: (_) => CupertinoAlertDialog(
                                        title: const Text("Some Error"),
                                        content: Text(e),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            onPressed: Navigator.of(context).pop,
                                            isDefaultAction: true,
                                            child: const Text(
                                              "Ok",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onLoad: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => const Center(
                                        child: CupertinoActivityIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                  productId: state.paywalls.first.productId,
                                ),
                              );
                            },
                          );
                        },
                      ),
      ),
    );
  }
}

class _Onboarding2 extends StatelessWidget {
  final Function() onTapButton;

  const _Onboarding2({
    super.key,
    required this.onTapButton,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      image: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImages.onboarding2,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 40,
                ),
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  top: 38,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Text(
                  'The best application for scanning Qr codes. Clear interface, fast response. There is a function to create your own QR code. Thank you for such an app! 🚀📊',
                  style: AppText.text3.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.black,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AppImages.faceOnboarding,
                  width: 70,
                  height: 70,
                ),
              ),
            ],
          ),
        ],
      ),
      title: 'We value your feedback',
      subtitle: 'They are the ones who inspire us to keep going',
      onTapButton: onTapButton,
    );
  }
}
