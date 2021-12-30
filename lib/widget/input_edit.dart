import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

class InputEdit extends StatefulWidget {
  const InputEdit({
    Key? key,
    required this.prefix,
    required this.securty,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  final Widget? prefix;
  final bool securty;
  final ValueChanged? onChanged;
  final String? hintText;

  @override
  State<InputEdit> createState() => _InputEditState();
}

class _InputEditState extends State<InputEdit> {
  TextEditingController? _controller;
  FocusNode? _focusNode;

  String? get text => _controller?.text;

  bool get isEmpty => text?.isNotEmpty != true;

  bool get hasFocus => _focusNode?.hasFocus == true;

  bool _hidden = true;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _focusNode = null;
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        minWidth: double.infinity,
        minHeight: AppDimens.buttonHeight,
        maxHeight: AppDimens.buttonHeight,
      ),
      child: TextField(
        controller: _controller,
        onChanged: (text) {
          setState(() {
            widget.onChanged?.call(text);
          });
        },
        focusNode: _focusNode,
        maxLines: 1,
        obscureText: widget.securty && _hidden,
        obscuringCharacter: '･',
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              color:
                  Theme.of(context).textTheme.bodyText2?.color?.withAlpha(80)),
          constraints: const BoxConstraints(
            maxWidth: double.infinity,
            minWidth: double.infinity,
            minHeight: AppDimens.buttonHeight,
            maxHeight: AppDimens.buttonHeight,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: AppDimens.buttonHeight,
            minHeight: 0,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.fromLTRB(
              AppDimens.marginSmall,
              AppDimens.marginSmall,
              AppDimens.marginSmall,
              0,
            ),
            child: widget.prefix,
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: AppDimens.buttonHeight,
            minHeight: 0,
          ),
          suffixIcon: !hasFocus
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isEmpty)
                      IconButton(
                        constraints: const BoxConstraints.tightForFinite(),
                        onPressed: () {
                          setState(() {
                            _controller?.clear();
                          });
                        },
                        padding: const EdgeInsets.fromLTRB(
                          AppDimens.marginSmall,
                          AppDimens.marginSmall,
                          AppDimens.marginSmall,
                          0,
                        ),
                        icon: const Icon(
                          CupertinoIcons.clear_circled_solid,
                          size: 18,
                        ),
                      ),
                    if (widget.securty)
                      IconButton(
                        constraints: const BoxConstraints.tightForFinite(),
                        padding: const EdgeInsets.fromLTRB(
                          AppDimens.marginSmall,
                          AppDimens.marginSmall,
                          AppDimens.marginSmall,
                          0,
                        ),
                        onPressed: () {
                          setState(() {
                            _hidden = !_hidden;
                          });
                        },
                        icon: Icon(
                          _hidden
                              ? CupertinoIcons.eye_slash_fill
                              : CupertinoIcons.eye_fill,
                          color: _hidden
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primary,
                          size: 18,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
