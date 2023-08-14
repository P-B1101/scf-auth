import 'package:flutter/material.dart';
import 'package:scf_auth/core/utils/assets.dart';
import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/components/text/input_label_widget.dart';
import '../../../../language/manager/localizatios.dart';

typedef AddressChangeListener = void Function(String address);

class AddressWidget extends StatefulWidget {
  final String address;
  final String? error;
  final AddressChangeListener onAddressChange;
  final bool hasLabel;
  final Function()? onDelete;
  const AddressWidget({
    super.key,
    required this.address,
    required this.error,
    required this.hasLabel,
    required this.onAddressChange,
    required this.onDelete,
  });

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final _controller = TextEditingController();
  final _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.address;
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.hasLabel)
          InputLabelWidget(
            Strings.of(context).address_label,
            hasError: _hasError,
          ),
        const SizedBox(height: 18),
        MInputWidget(
          controller: _controller,
          focusNode: _node,
          hint: Strings.of(context).address_hint,
          onTextChange: widget.onAddressChange,
          error: widget.error,
          autofillHints: const [AutofillHints.fullStreetAddress],
          isMultiLine: true,
          height: 90,
          suffixWidget: _hasDelete
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: InkWell(
                      onTap: _onDeleteClick,
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
                )
              : null,
        ),
      ],
    );
  }

  void _onDeleteClick() {
    _controller.clear();
    widget.onDelete?.call();
  }

  bool get _hasError => widget.error != null && widget.error!.isNotEmpty;

  bool get _hasDelete => widget.onDelete != null;
}
