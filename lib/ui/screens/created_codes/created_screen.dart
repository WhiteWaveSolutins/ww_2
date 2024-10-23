import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/created_codes/widgets/created_code_card.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_codes_empty.dart';
import 'package:ww_2/ui/state_manager/qr_code/action.dart';
import 'package:ww_2/ui/state_manager/qr_code/state.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/delete_dismissible.dart';

import 'widgets/created_codes_generate.dart';

class CreatedScreen extends StatefulWidget {
  const CreatedScreen({super.key});

  @override
  State<CreatedScreen> createState() => _CreatedScreenState();
}

class _CreatedScreenState extends State<CreatedScreen> {
  final controller = TextEditingController();

  late Store<AppState> _store;

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
    if (_store.state.createdQrCodeListState.codes.isEmpty) {
      _store.dispatch(LoadCreatedQrCodeListAction());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Created codes'),
        centerTitle: true,
        leading: const LeftButton(),
      ),
      body: StoreConnector<AppState, QrCodeListState>(
        converter: (store) => store.state.createdQrCodeListState,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state.isError) return Center(child: Text(state.errorMessage));
          var showCodes = state.codes.toList();
          if (controller.text.isNotEmpty) {
            showCodes = showCodes
                .where((e) => e.data.toDataForDataBase().contains(controller.text))
                .toList();
          }
          return ListView(
            children: [
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  style: AppText.text2.copyWith(
                    color: AppColors.white,
                    height: 1,
                  ),
                  controller: controller,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (state.codes.isEmpty) ...[
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                const CreatedCodesGenerate()
              ] else ...[
                if (showCodes.isEmpty)
                  const SavedCodesEmpty()
                else
                  for (var code in showCodes) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DeleteDismissible(
                        onDelete: () => getItService.qrCodeUseCase.deleteSave(code),
                        child: CreatedCodeCard(qr: code),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
              ],
            ],
          );
        },
      ),
    );
  }
}
