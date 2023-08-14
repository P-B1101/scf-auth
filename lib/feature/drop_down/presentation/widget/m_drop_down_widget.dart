import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/input/m_input_widget.dart';
import '../../../../core/components/loading/adaptive_loading_widget.dart';
import '../../../../core/components/text/input_label_widget.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/ui_utils.dart';
import '../cubit/drop_down_controller_cubit.dart';

typedef TitleBuilder<T> = String? Function(T? item);
typedef EnableBuilder<T> = bool? Function(T? item);

class MDropDownWidget<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final TitleBuilder<T> titleBuilder;
  final EnableBuilder<T>? enableBuilder;
  final Function(T item) onItemSelected;
  final String hint;
  final String label;
  final String? error;
  final bool isLoading;
  final Function()? onDeleteFieldClick;
  const MDropDownWidget({
    super.key,
    required this.items,
    required this.titleBuilder,
    required this.hint,
    required this.label,
    required this.onItemSelected,
    this.error,
    this.selectedItem,
    this.isLoading = false,
    this.onDeleteFieldClick,
    this.enableBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DropDownControllerCubit<T>>(
          create: (context) => DropDownControllerCubit<T>(
            items: items,
            selectedItem: selectedItem,
          ),
        ),
      ],
      child: _MDropDwonWidget<T>(
        items: items,
        selectedItem: selectedItem,
        titleBuilder: titleBuilder,
        hint: hint,
        error: error,
        label: label,
        isLoading: isLoading,
        onItemSelected: onItemSelected,
        onDeleteFieldClick: onDeleteFieldClick,
        enableBuilder: enableBuilder,
      ),
    );
  }
}

class _MDropDwonWidget<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final TitleBuilder<T> titleBuilder;
  final String hint;
  final String label;
  final String? error;
  final bool isLoading;
  final Function(T item) onItemSelected;
  final Function()? onDeleteFieldClick;
  final EnableBuilder<T>? enableBuilder;
  const _MDropDwonWidget({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.titleBuilder,
    required this.hint,
    required this.label,
    required this.error,
    required this.isLoading,
    required this.onItemSelected,
    required this.onDeleteFieldClick,
    required this.enableBuilder,
  }) : super(key: key);

  @override
  State<_MDropDwonWidget<T>> createState() => __MDropDwonWidgetState<T>();
}

class __MDropDwonWidgetState<T> extends State<_MDropDwonWidget<T>> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  OverlayEntry? _entry;
  final LayerLink _layerLink = LayerLink();
  late final DropDownControllerCubit<T> _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DropDownControllerCubit<T>>();
  }

  @override
  void dispose() {
    _closeDropDown();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _MDropDwonWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _cubit.initializeItems(widget.items);
    }
    if (oldWidget.selectedItem != widget.selectedItem) {
      _controller.text = widget.titleBuilder(widget.selectedItem) ?? '';
      context
          .read<DropDownControllerCubit<T>>()
          .onSelectedItemChange(widget.selectedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InputLabelWidget(
            widget.label,
            hasError: _hasError,
          ),
          const SizedBox(height: 18),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _openDropDown,
              child: CompositedTransformTarget(
                link: _layerLink,
                child: MInputWidget(
                  controller: _controller,
                  focusNode: _focusNode,
                  hint: widget.hint,
                  isReadOnly: true,
                  contentPadding: EdgeInsetsDirectional.only(
                    top: 20,
                    bottom: 20,
                    start: 10,
                    end: _hasDelete ? 90 : 48,
                  ),
                  suffixWidget: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AnimatedCrossFade(
                      duration: UiUtils.duration,
                      sizeCurve: UiUtils.curve,
                      firstCurve: UiUtils.curve,
                      secondCurve: UiUtils.curve,
                      crossFadeState: widget.isLoading
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: const AdaptiveLoadingWidget(
                        size: 24,
                        stroke: 2,
                      ),
                      secondChild: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_hasDelete)
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: InkWell(
                                onTap: widget.onDeleteFieldClick,
                                customBorder: const CircleBorder(),
                                child: Center(
                                  child: Icon(
                                    Fonts.trash,
                                    size: 20,
                                    color: MColors.inputBorderColorOf(context),
                                  ),
                                ),
                              ),
                            ),
                          if (_hasDelete) const SizedBox(width: 12),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: BlocBuilder<DropDownControllerCubit<T>,
                                DropDownControllerState<T>>(
                              buildWhen: (previous, current) =>
                                  previous.isOpen != current.isOpen,
                              builder: (context, state) => AnimatedRotation(
                                turns: state.isOpen ? .5 : 0,
                                duration: UiUtils.duration,
                                curve: UiUtils.curve,
                                child: AnimatedSwitcher(
                                  duration: UiUtils.duration,
                                  switchInCurve: Curves.easeIn,
                                  switchOutCurve: Curves.easeOut,
                                  child: Icon(
                                    Fonts.arrowDown,
                                    key: ValueKey(_hasError),
                                    size: 18,
                                    color: _hasError
                                        ? MColors.errorColor
                                        : MColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  error: widget.error,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openDropDown() async {
    if (widget.isLoading) return;
    if (widget.items.isEmpty) return;
    _closeKeyboard();
    _closeDropDown();
    _entry = _createSubjectOverlay<T>(
      context: context,
      onHide: _closeDropDown,
      layerLink: _layerLink,
      items: widget.items,
      selectedItem: widget.selectedItem,
      enableBuilder: widget.enableBuilder,
      onItemClick: (item) {
        _controller.text = widget.titleBuilder(item) ?? '';
        widget.onItemSelected(item);
        _closeDropDown();
      },
      titleBuilder: widget.titleBuilder,
    );
    Overlay.of(context).insert(_entry!);
    _cubit.openDropDown();
  }

  void _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void _closeDropDown() {
    _entry?.remove();
    _entry = null;
    _cubit.closeDropDown();
  }

  bool get _hasError => widget.error != null && widget.error!.isNotEmpty;

  bool get _hasDelete => widget.onDeleteFieldClick != null;
}

OverlayEntry _createSubjectOverlay<T>({
  required BuildContext context,
  required Function() onHide,
  required LayerLink layerLink,
  required List<T> items,
  required T? selectedItem,
  required Function(T) onItemClick,
  required TitleBuilder<T> titleBuilder,
  required EnableBuilder<T>? enableBuilder,
}) {
  final size = MediaQuery.sizeOf(context);
  return OverlayEntry(
    builder: (context) => SizedBox(
      width: size.width,
      height: size.height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onHide,
        child: Stack(
          children: [
            PositionedDirectional(
              start: 0,
              width: UiUtils.maxInputSize,
              child: CompositedTransformFollower(
                followerAnchor: Alignment.topLeft,
                targetAnchor: Alignment.bottomLeft,
                link: layerLink,
                showWhenUnlinked: false,
                offset: const Offset(0, 8),
                child: FadedSlideAnimation(
                  beginOffset: const Offset(0, -.05),
                  endOffset: const Offset(0, 0),
                  fadeCurve: Curves.decelerate,
                  slideCurve: Curves.decelerate,
                  fadeDuration: UiUtils.duration,
                  slideDuration: UiUtils.duration,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: UiUtils.dropDownMaxHeight,
                    ),
                    decoration: BoxDecoration(
                      color: MColors.featureBoxColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: MColors.primaryColor,
                        width: 1,
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     blurRadius: 4,
                      //     spreadRadius: 0,
                      //     color: Colors.black.withOpacity(.16),
                      //     offset: const Offset(0, 0),
                      //   ),
                      // ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (context, index) => Container(
                          height: .5,
                          width: double.infinity,
                          color: MColors.inputBorderColorOf(context),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => _ItemWidget(
                          title: titleBuilder(items[index]) ?? '-',
                          isSelected: items[index] == selectedItem,
                          item: items[index],
                          isLast: index == items.length - 1,
                          isFirst: index == 0,
                          onClick: onItemClick,
                          isEnable: enableBuilder?.call(items[index]) ?? true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ItemWidget<T> extends StatelessWidget {
  final T item;
  final bool isLast;
  final bool isFirst;
  final bool isSelected;
  final Function(T) onClick;
  final bool isEnable;
  final String title;
  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.onClick,
    required this.isSelected,
    required this.title,
    required this.isEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(isFirst ? _radius : 0),
          topLeft: Radius.circular(isFirst ? _radius : 0),
          bottomLeft: Radius.circular(isLast ? _radius : 0),
          bottomRight: Radius.circular(isLast ? _radius : 0),
        ),
        color: MColors.featureBoxColorOf(context),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (isEnable) onClick(item);
          },
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(isFirst ? _radius : 0),
            topLeft: Radius.circular(isFirst ? _radius : 0),
            bottomLeft: Radius.circular(isLast ? _radius : 0),
            bottomRight: Radius.circular(isLast ? _radius : 0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: Fonts.regular400,
                fontSize: 14,
                color:
                    MColors.textColorOf(context).withOpacity(isEnable ? 1 : .5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get _radius => 8;
}
