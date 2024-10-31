import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ww_2/data/models/local_barcode/local_barcode.dart';
import 'package:ww_2/domain/di/get_it_services.dart';
import 'package:ww_2/domain/enums/type_code.dart';
import 'package:ww_2/ui/resurses/colors.dart';
import 'package:ww_2/ui/resurses/icons.dart';
import 'package:ww_2/ui/resurses/text.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_code_card.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_codes_empty.dart';
import 'package:ww_2/ui/screens/saved_codes/widgets/saved_codes_scan.dart';
import 'package:ww_2/ui/state_manager/locale_code/action.dart';
import 'package:ww_2/ui/state_manager/locale_code/state.dart';
import 'package:ww_2/ui/state_manager/store.dart';
import 'package:ww_2/ui/widgets/box_active.dart';
import 'package:ww_2/ui/widgets/buttons/left_button.dart';
import 'package:ww_2/ui/widgets/delete_dismissible.dart';
import 'package:ww_2/ui/widgets/svg_icon.dart';

class SavedCodesScreen extends StatefulWidget {
  const SavedCodesScreen({super.key});

  @override
  State<SavedCodesScreen> createState() => _SavedCodesScreenState();
}

class _SavedCodesScreenState extends State<SavedCodesScreen> {
  List<TypeCode> selectedTypes = [];
  late Store<AppState> _store;
  final controller = TextEditingController();

  bool sortName = false;
  bool sortDate = false;

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
      appBar: AppBar(
        title: const Text('Saved codes'),
        centerTitle: true,
        leading: const LeftButton(),
        actions: [
          StoreConnector<AppState, LocalCodeListState>(
            converter: (store) => store.state.savedCodeListState,
            builder: (context, state) {
              if (state.codes.isEmpty) return const SizedBox();
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) {
                          return _Filter(
                            selected: selectedTypes,
                            onSelected: (t) {
                              if (selectedTypes.contains(t)) {
                                selectedTypes.remove(t);
                              } else {
                                selectedTypes.add(t);
                              }
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const SvgIcon(icon: AppIcons.filter),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) {
                          return _Sort(
                            sortDate: sortDate,
                            sortName: sortName,
                            onSortDate: (s) => setState(() => sortDate = s),
                            onSortName: (s) => setState(() => sortName = s),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const SvgIcon(icon: AppIcons.sort),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: StoreConnector<AppState, LocalCodeListState>(
        converter: (store) => store.state.savedCodeListState,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 20,
                color: Colors.white,
              ),
            );
          }
          if (state.isError) return Center(child: Text(state.errorMessage));
          var showCodes = <LocalBarcode>[];
          if (selectedTypes.isEmpty) {
            showCodes = state.codes.toList();
          } else {
            showCodes = state.codes.where((e) => selectedTypes.contains(e.type)).toList();
          }
          if (controller.text.isNotEmpty) {
            showCodes = showCodes.where((e) => e.title.contains(controller.text)).toList();
          }
          final now = DateTime.now();
          showCodes.sort((a, b) => (a.created ?? now).compareTo(b.created ?? now));
          if (!sortDate) showCodes = showCodes.reversed.toList();
          showCodes.sort((a, b) => (a.title).compareTo(b.title));
          if (!sortName) showCodes = showCodes.reversed.toList();
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

class _Filter extends StatelessWidget {
  final Function(TypeCode) onSelected;
  final List<TypeCode> selected;

  const _Filter({
    super.key,
    required this.onSelected,
    required this.selected,
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
                        for (int i = 0; i < TypeCode.values.length; i++) ...[
                          GestureDetector(
                            onTap: () {
                              onSelected(TypeCode.values[i]);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    typeCodeToIcon(TypeCode.values[i]),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 7),
                                  Expanded(
                                    child: Text(
                                      typeCodeToString(TypeCode.values[i]),
                                      style: AppText.text3,
                                    ),
                                  ),
                                  Opacity(
                                    opacity: selected.contains(TypeCode.values[i]) ? 1 : 0,
                                    child: const BoxActive(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (i != TypeCode.values.length - 1)
                            Divider(
                              color: AppColors.white.withOpacity(.1),
                              height: 1,
                            ),
                        ],
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

class _Sort extends StatefulWidget {
  final Function(bool) onSortDate;
  final Function(bool) onSortName;
  final bool sortDate;
  final bool sortName;

  const _Sort({
    super.key,
    required this.onSortDate,
    required this.onSortName,
    required this.sortDate,
    required this.sortName,
  });

  @override
  State<_Sort> createState() => _SortState();
}

class _SortState extends State<_Sort> {
  bool isDate = true;

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
            top: 30,
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
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => isDate = true),
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text(
                                      'By date',
                                      style: AppText.text3,
                                    ),
                                    Opacity(
                                      opacity: !isDate ? 0 : 1,
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
                              onTap: () => setState(() => isDate = false),
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text(
                                      'By name',
                                      style: AppText.text3,
                                    ),
                                    Opacity(
                                      opacity: isDate ? 0 : 1,
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
                                if (isDate) {
                                  widget.onSortDate(false);
                                } else {
                                  widget.onSortName(false);
                                }
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
                                      opacity: (isDate ? widget.sortDate : widget.sortName) ? 0 : 1,
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
                                if (isDate) {
                                  widget.onSortDate(true);
                                } else {
                                  widget.onSortName(true);
                                }
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
                                      opacity:
                                          !(isDate ? widget.sortDate : widget.sortName) ? 0 : 1,
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
