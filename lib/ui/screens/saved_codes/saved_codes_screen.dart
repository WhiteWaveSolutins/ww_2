import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_code.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/filter_type_code.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_code_card.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_codes_empty.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_codes_scan.dart';
import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/locale_code/state.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/delete_dismissible.dart';

class SavedCodesScreen extends StatefulWidget {
  const SavedCodesScreen({super.key});

  @override
  State<SavedCodesScreen> createState() => _SavedCodesScreenState();
}

class _SavedCodesScreenState extends State<SavedCodesScreen> {
  late TypeCode? selectedType;
  late Store<AppState> _store;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedType = null;
    _store = StoreProvider.of<AppState>(context, listen: false);
    if (_store.state.savedCodeListState.codes.isEmpty) {
      _store.dispatch(LoadSaveLocalCodeListAction());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved codes'),
        centerTitle: true,
        leading: const LeftButton(),
      ),
      body: StoreConnector<AppState, LocalCodeListState>(
        converter: (store) => store.state.savedCodeListState,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state.isError) return Center(child: Text(state.errorMessage));
          var showCodes = <LocalBarcode>[];
          if (selectedType == null) {
            showCodes = state.codes.toList();
          } else {
            showCodes = state.codes.where((e) => e.type == selectedType).toList();
          }
          if (controller.text.isNotEmpty) {
            showCodes = showCodes.where((e) => e.title.contains(controller.text)).toList();
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
              if (state.codes.isNotEmpty) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 46,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(width: 16),
                      FilterTypeCode(
                        type: null,
                        selected: selectedType == null,
                        onTap: () => setState(() => selectedType = null),
                      ),
                      const SizedBox(width: 8),
                      for (var type in TypeCode.values) ...[
                        FilterTypeCode(
                          type: type,
                          selected: selectedType == type,
                          onTap: () => setState(() => selectedType = type),
                        ),
                        const SizedBox(width: 8),
                      ],
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              if (state.codes.isEmpty) ...[
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                const SavedCodesScan(),
              ] else ...[
                if (showCodes.isEmpty)
                  const SavedCodesEmpty()
                else
                  for (var code in showCodes) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DeleteDismissible(
                        onDelete: () => getItService.localCodeUseCase.deleteSave(code),
                        child: SavedCodeCard(localBarcode: code),
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
