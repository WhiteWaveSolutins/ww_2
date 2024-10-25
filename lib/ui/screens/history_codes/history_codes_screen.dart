import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/history_codes/widgets/history_code_card.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_codes_scan.dart';
import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/locale_code/state.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/box_active.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/delete_dismissible.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class HistoryCodesScreen extends StatefulWidget {
  const HistoryCodesScreen({super.key});

  @override
  State<HistoryCodesScreen> createState() => _HistoryCodesScreenState();
}

class _HistoryCodesScreenState extends State<HistoryCodesScreen> {
  late Store<AppState> _store;
  final sortKey = GlobalKey();
  bool sort = false;

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
          StoreConnector<AppState, LocalCodeListState>(
            converter: (store) => store.state.historyCodeListState,
            builder: (context, state) {
              if (state.codes.isEmpty) return Container();
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (context) {
                      final renderBox = sortKey.currentContext!.findRenderObject() as RenderBox;
                      final offset = renderBox.localToGlobal(Offset.zero);
                      return _Sort(
                        offset: offset,
                        sort: sort,
                        onSort: (s) => setState(() => sort = s),
                      );
                    },
                  );
                },
                child: Container(
                  key: sortKey,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const SvgIcon(icon: AppIcons.sort),
                ),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: StoreConnector<AppState, LocalCodeListState>(
        converter: (store) => store.state.historyCodeListState,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CupertinoActivityIndicator(
                    radius: 20,)
                   );
          }
          if (state.isError) return Center(child: Text(state.errorMessage));
          if (state.codes.isEmpty) return const Center(child: SavedCodesScan());
          var codes = state.codes.toList();
          final now = DateTime.now();
          codes.sort((a, b) => (a.created ?? now).compareTo(b.created ?? now));
          if (!sort) codes = codes.reversed.toList();
          return Stack(
            alignment: Alignment.center,
            children: [
              ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: codes.length,
                itemBuilder: (_, index) => DeleteDismissible(
                  onDelete: () => getItService.localCodeUseCase.deleteHistory(codes[index]),
                  child: HistoryCodeCard(localBarcode: codes[index]),
                ),
                separatorBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(color: AppColors.white.withOpacity(.5)),
                ),
              ),
              Positioned(
                bottom: 50,
                child: CupertinoButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                        title: const Text('Clear history'),
                        content: const Text('Do you really want to delete all historye'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            onPressed: () {
                              getItService.localCodeUseCase.deleteHistoryAll();
                              Navigator.of(context).pop();
                            },
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.red),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 18),
                        Text(
                          'Clear history',
                          style: AppText.text3,
                        ),
                        const SizedBox(width: 16),
                        const SvgIcon(icon: AppIcons.trash),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Sort extends StatelessWidget {
  final Offset offset;
  final Function(bool) onSort;
  final bool sort;

  const _Sort({
    super.key,
    required this.offset,
    required this.onSort,
    required this.sort,
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
            top: offset.dy,
            right: 10,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Container(
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
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text(
                                'By date',
                                style: AppText.text3,
                              ),
                              const BoxActive(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
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
                                onSort(false);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text(
                                      'Increase',
                                      style: AppText.text3,
                                    ),
                                    Opacity(
                                      opacity: sort ? 0 : 1,
                                      child: const BoxActive(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors.white.withOpacity(.1),
                              height: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                onSort(true);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text(
                                      'Decrease',
                                      style: AppText.text3,
                                    ),
                                    Opacity(
                                      opacity: !sort ? 0 : 1,
                                      child: const BoxActive(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
