import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/models/qr_code/data_qr_code.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/images.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/state_manager/qr_code/action.dart';
import 'package:ww_2/ui/state_manager/qr_code/state.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/buttons/main_button.dart';
import 'package:ww_2/ui/widgets/buttons/simple_button.dart';
import 'package:ww_2/ui/widgets/image_back.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';
import 'package:share_plus/share_plus.dart';

class GenerateResultScreen extends StatefulWidget {
  final DataQrCode data;

  const GenerateResultScreen({
    super.key,
    required this.data,
  });

  @override
  State<GenerateResultScreen> createState() => _GenerateResultScreenState();
}

class _GenerateResultScreenState extends State<GenerateResultScreen> {
  late Store<AppState> _store;

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
    _store.dispatch(LoadQrCodeGenerateAction(data: widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return ImageBack(
      image: AppImages.back,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('GENERATE'),
          centerTitle: true,
          leading: const LeftButton(),
        ),
        body: StoreConnector<AppState, QrCodeState>(
          converter: (store) => store.state.qrCodeGeneratedState,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 20,
                ),
              );
            }
            if (state.isError) return Center(child: Text(state.errorMessage));
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.memory(
                        state.code!.image,
                        width: 350,
                        height: 350,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  state.code!.data.custom.first,
                  style: AppText.text1.copyWith(
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (state.code!.data.custom.length > 1)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      for (var text in state.code!.data.custom.sublist(1)) ...[
                        Opacity(
                          opacity: .5,
                          child: Text(
                            text,
                            style: AppText.text16,
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ],
                  ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: SimpleButton(
                        onTap: () => Share.shareXFiles(
                          [
                            XFile.fromData(
                              state.code!.image,
                              mimeType: 'image/png',
                            ),
                          ],
                        ),
                        title: 'Share',
                        icon: AppIcons.share,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SimpleButton(
                        onTap: () {
                          getItService.qrCodeUseCase.addSave(state.code!);
                          getItService.navigatorService.onFirst();
                          getItService.navigatorService.onCreated();
                        },
                        title: 'Save',
                        icon: AppIcons.save,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    MainButton(
                      onPressed: () => getItService.navigatorService.onGenerateCustomize(
                        qr: state.code!,
                      ),
                      title: 'Сustomize',
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 27),
                      child: SvgIcon(
                        icon: AppIcons.color,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
