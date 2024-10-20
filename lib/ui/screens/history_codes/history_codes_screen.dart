import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/screens/history_codes/widgets/history_code_card.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_codes_scan.dart';
import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/locale_code/state.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/delete_dismissible.dart';

class HistoryCodesScreen extends StatefulWidget {
  const HistoryCodesScreen({super.key});

  @override
  State<HistoryCodesScreen> createState() => _HistoryCodesScreenState();
}

class _HistoryCodesScreenState extends State<HistoryCodesScreen> {
  late Store<AppState> _store;

  @override
  void initState() {
    super.initState();
    _store = StoreProvider.of<AppState>(context, listen: false);
    if (_store.state.historyCodeListState.codes.isEmpty) {
      _store.dispatch(LoadHistoryLocalCodeListAction());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan history'),
        centerTitle: true,
        leading: const LeftButton(),
        actions: [
          IconButton(
            onPressed: getItService.localCodeUseCase.deleteHistoryAll,
            icon: const Icon(
              CupertinoIcons.trash,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: StoreConnector<AppState, LocalCodeListState>(
        converter: (store) => store.state.historyCodeListState,
        builder: (context, state) {
          if (state.isLoading) return const Center(child: CircularProgressIndicator());
          if (state.isError) return Center(child: Text(state.errorMessage));
          if (state.codes.isEmpty) return const Center(child: SavedCodesScan());
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.codes.length,
            itemBuilder: (_, index) => DeleteDismissible(
              onDelete: () => getItService.localCodeUseCase.deleteHistory(state.codes[index]),
              child: HistoryCodeCard(localBarcode: state.codes[index]),
            ),
            separatorBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: AppColors.white.withOpacity(.5)),
            ),
          );
        },
      ),
    );
  }
}
