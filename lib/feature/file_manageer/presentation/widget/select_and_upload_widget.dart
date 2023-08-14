import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/input/m_input_widget.dart';
import '../../../../core/components/loading/adaptive_loading_widget.dart';
import '../../../../core/components/text/input_label_widget.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../injectable_container.dart';
import '../../../cdn/domain/entity/upload_file_result.dart';
import '../../../cdn/presentation/bloc/select_and_upload_bloc.dart';

typedef FileUploadedListener = void Function(UploadFileResult result);
typedef FileSizeFailureListener = void Function(int size);
typedef FileExtensionFailureListener = void Function(String extension);
typedef FileFailureListener = void Function(String? message);

class SelectAndUploadWidget extends StatelessWidget {
  final FileUploadedListener onFileUploaded;
  final FileSizeFailureListener onFileSizeFailure;
  final FileExtensionFailureListener onFileExtensionFailure;
  final FileFailureListener onFileFailure;
  final String label;
  final String hint;
  final String? error;
  final String? name;
  final String title;

  const SelectAndUploadWidget({
    super.key,
    required this.onFileUploaded,
    required this.onFileExtensionFailure,
    required this.onFileSizeFailure,
    required this.onFileFailure,
    required this.hint,
    required this.label,
    required this.title,
    this.error,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectAndUploadBloc>(
          create: (context) => getIt<SelectAndUploadBloc>(),
        ),
      ],
      child: _SelectAndUploadWidget(
        onFileExtensionFailure: onFileExtensionFailure,
        onFileSizeFailure: onFileSizeFailure,
        onFileUploaded: onFileUploaded,
        onFileFailure: onFileFailure,
        error: error,
        hint: hint,
        label: label,
        name: name ?? '',
        title: title,
      ),
    );
  }
}

class _SelectAndUploadWidget extends StatefulWidget {
  final FileUploadedListener onFileUploaded;
  final FileSizeFailureListener onFileSizeFailure;
  final FileExtensionFailureListener onFileExtensionFailure;
  final FileFailureListener onFileFailure;
  final String label;
  final String hint;
  final String? error;
  final String name;
  final String title;

  const _SelectAndUploadWidget({
    Key? key,
    required this.onFileExtensionFailure,
    required this.onFileSizeFailure,
    required this.onFileUploaded,
    required this.onFileFailure,
    required this.error,
    required this.hint,
    required this.label,
    required this.name,
    required this.title,
  }) : super(key: key);

  @override
  State<_SelectAndUploadWidget> createState() => __SelectAndUploadWidgetState();
}

class __SelectAndUploadWidgetState extends State<_SelectAndUploadWidget> {
  final _controller = TextEditingController();
  final _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.name;
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SelectAndUploadBloc, SelectAndUploadState>(
          listener: (context, state) {
            if (state is SelectAndUploadSuccessState) {
              final result = state.result.copyWith(
                title: widget.title,
              );
              _controller.text = result.fileName;
              widget.onFileUploaded(result);
            } else if (state is SelectAndUploadFileSizeFailureState) {
              widget.onFileSizeFailure(state.size);
            } else if (state is SelectAndUploadFileExtensionFailureState) {
              widget.onFileExtensionFailure(state.extensions);
            } else if (state is SelectAndUploadFailureState) {
              widget.onFileFailure(state.message);
            }
          },
        ),
      ],
      child: _child,
    );
  }

  Widget get _child => Builder(
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  onTap: _onStartSelectFileAndUpload,
                  child: MInputWidget(
                    controller: _controller,
                    focusNode: _node,
                    isReadOnly: true,
                    hint: widget.hint,
                    error: widget.error,
                    suffixWidget: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: BlocBuilder<SelectAndUploadBloc,
                          SelectAndUploadState>(
                        builder: (context, state) => AnimatedCrossFade(
                          duration: UiUtils.duration,
                          sizeCurve: UiUtils.curve,
                          firstCurve: UiUtils.curve,
                          secondCurve: UiUtils.curve,
                          crossFadeState: state is SelectAndUploadLoadingState
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          firstChild: SizedBox(
                            width: 32,
                            height: 32,
                            child: InkWell(
                              onTap: _onStartSelectFileAndUpload,
                              customBorder: const CircleBorder(),
                              child: const Center(
                                child: Icon(
                                  Fonts.upload,
                                  size: 20,
                                  color: MColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          secondChild: const AdaptiveLoadingWidget(
                            size: 24,
                            stroke: 2,
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
      );

  void _onStartSelectFileAndUpload() {
    context
        .read<SelectAndUploadBloc>()
        .add(StartSelectAndUploadEvent(title: widget.title));
  }

  bool get _hasError => widget.error != null && widget.error!.isNotEmpty;
}
