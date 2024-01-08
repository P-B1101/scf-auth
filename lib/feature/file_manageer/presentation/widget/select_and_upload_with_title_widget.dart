import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/utils/enums.dart';

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
typedef TitleChangeListener = void Function(String title);

class SelectAndUploadWithTitleWidget extends StatelessWidget {
  final FileUploadedListener onFileUploaded;
  final FileSizeFailureListener onFileSizeFailure;
  final FileExtensionFailureListener onFileExtensionFailure;
  final FileFailureListener onFileFailure;
  final TitleChangeListener onTitleChange;
  final String titleLabel;
  final String titleHint;
  final String fileLabel;
  final String fileHint;
  final String? titleError;
  final String? fileError;
  final String? name;
  final Function()? onDeleteClick;
  final String? title;

  const SelectAndUploadWithTitleWidget({
    super.key,
    required this.onFileUploaded,
    required this.onFileExtensionFailure,
    required this.onFileSizeFailure,
    required this.onFileFailure,
    required this.onTitleChange,
    required this.titleHint,
    required this.titleLabel,
    required this.fileHint,
    required this.fileLabel,
    this.title,
    this.titleError,
    this.fileError,
    this.name,
    this.onDeleteClick,
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
        titleError: titleError,
        titleHint: titleHint,
        titleLabel: titleLabel,
        name: name ?? '',
        onDeleteClick: onDeleteClick,
        title: title ?? '',
        onTitleChange: onTitleChange,
        fileError: fileError,
        fileHint: fileHint,
        fileLabel: fileLabel,
      ),
    );
  }
}

class _SelectAndUploadWidget extends StatefulWidget {
  final FileUploadedListener onFileUploaded;
  final FileSizeFailureListener onFileSizeFailure;
  final FileExtensionFailureListener onFileExtensionFailure;
  final FileFailureListener onFileFailure;
  final TitleChangeListener onTitleChange;
  final String titleLabel;
  final String titleHint;
  final String fileLabel;
  final String fileHint;
  final String? titleError;
  final String? fileError;
  final String name;
  final Function()? onDeleteClick;
  final String title;

  const _SelectAndUploadWidget({
    Key? key,
    required this.onFileExtensionFailure,
    required this.onFileSizeFailure,
    required this.onFileUploaded,
    required this.onFileFailure,
    required this.onTitleChange,
    required this.titleError,
    required this.titleHint,
    required this.titleLabel,
    required this.name,
    required this.onDeleteClick,
    required this.title,
    required this.fileError,
    required this.fileHint,
    required this.fileLabel,
  }) : super(key: key);

  @override
  State<_SelectAndUploadWidget> createState() => __SelectAndUploadWidgetState();
}

class __SelectAndUploadWidgetState extends State<_SelectAndUploadWidget> {
  final _controller = TextEditingController();
  final _node = FocusNode();
  final _titleController = TextEditingController();
  final _titleNode = FocusNode();
  UploadFileResult _result = UploadFileResult.init();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.name;
    _titleController.text = widget.title;
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _node.dispose();
    _titleNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SelectAndUploadBloc, SelectAndUploadState>(
          listener: (context, state) {
            if (state is SelectAndUploadSuccessState) {
              _result = _result.copyWith(
                fileName: state.result.first.fileName,
                urn: state.result.first.urn,
              );
              _controller.text = _result.fileName ?? '';
              widget.onFileUploaded(_result);
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
        builder: (context) => Wrap(
          spacing: 86,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputLabelWidget(
                    widget.titleLabel,
                    hasError: _hasTitleError,
                  ),
                  const SizedBox(height: 18),
                  MInputWidget(
                    controller: _titleController,
                    focusNode: _titleNode,
                    hint: widget.titleHint,
                    error: widget.titleError,
                    onTextChange: _onTitleChange,
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
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: UiUtils.maxInputSize),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputLabelWidget(
                    widget.fileLabel,
                    hasError: _hasFileError,
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
                        hint: widget.fileHint,
                        isReadOnly: true,
                        error: widget.fileError,
                        suffixWidget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: BlocBuilder<SelectAndUploadBloc,
                              SelectAndUploadState>(
                            builder: (context, state) => AnimatedCrossFade(
                              duration: UiUtils.duration,
                              sizeCurve: UiUtils.curve,
                              firstCurve: UiUtils.curve,
                              secondCurve: UiUtils.curve,
                              crossFadeState:
                                  state is SelectAndUploadLoadingState
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
          ],
        ),
      );

  void _onDeleteClick() {
    _controller.clear();
    widget.onDeleteClick?.call();
  }

  void _onStartSelectFileAndUpload() {
    context.read<SelectAndUploadBloc>().add(StartSelectAndUploadEvent(
          title: _titleController.text,
          type: UploadFileType.registration,
          isMultiSelect: false,
        ));
  }

  void _onTitleChange(String title) {
    _result = _result.copyWith(title: title);
    widget.onTitleChange(title);
  }

  bool get _hasTitleError =>
      widget.titleError != null && widget.titleError!.isNotEmpty;

  bool get _hasFileError =>
      widget.fileError != null && widget.fileError!.isNotEmpty;

  bool get _hasDelete => widget.onDeleteClick != null;
}
