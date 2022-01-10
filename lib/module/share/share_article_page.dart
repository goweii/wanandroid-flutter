import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/wan/wan_toast.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/http/api.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/share/share_article_info.dart';
import 'package:wanandroid/module/share/share_article_view_model.dart';
import 'package:wanandroid/widget/main_button.dart';

class ShareArticlePage extends StatefulWidget {
  const ShareArticlePage({
    Key? key,
    this.shareArticleInfo,
  }) : super(key: key);

  final ShareArticleInfo? shareArticleInfo;

  @override
  _ShareArticlePageState createState() => _ShareArticlePageState();
}

class _ShareArticlePageState extends State<ShareArticlePage> {
  final ShareArticleViewModel _viewModel = ShareArticleViewModel();

  late TextEditingController _titleController;
  late FocusNode _titleFocusNode = FocusNode();

  late TextEditingController _linkController;
  late FocusNode _linkFocusNode;

  @override
  void initState() {
    _titleController =
        TextEditingController(text: widget.shareArticleInfo?.title)
          ..addListener(() {
            setState(() {});
          });
    _titleFocusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    _linkController = TextEditingController(text: widget.shareArticleInfo?.link)
      ..addListener(() {
        setState(() {});
      });
    _linkFocusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocusNode.dispose();
    _linkController.dispose();
    _linkFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).share_article),
      ),
      backgroundColor: themeData.colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(
          left: AppDimens.marginNormal,
          right: AppDimens.marginNormal,
          top: AppDimens.marginNormal,
          bottom: AppDimens.marginNormal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.title_rounded,
                  size: 18.0,
                  color: themeData.colorScheme.primary,
                ),
                const SizedBox(width: AppDimens.marginHalf),
                Text(
                  Strings.of(context).share_article_title_label,
                  style: themeData.textTheme.subtitle2,
                ),
              ],
            ),
            TextField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.bodyText1,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: Strings.of(context).share_article_title_hint,
                hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.color
                        ?.withAlpha(80)),
                constraints: const BoxConstraints(
                    maxWidth: double.infinity,
                    minWidth: double.infinity,
                    minHeight: AppDimens.buttonHeight,
                    maxHeight: double.infinity),
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: AppDimens.buttonHeight,
                  minHeight: 0,
                ),
                suffixIcon:
                    _titleFocusNode.hasFocus && _titleController.text.isNotEmpty
                        ? IconButton(
                            constraints: const BoxConstraints.tightForFinite(),
                            onPressed: () {
                              setState(() {
                                _titleController.clear();
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
                          )
                        : null,
              ),
            ),
            const SizedBox(height: AppDimens.marginNormal),
            Row(
              children: [
                Icon(
                  Icons.link_rounded,
                  size: 18.0,
                  color: themeData.colorScheme.primary,
                ),
                const SizedBox(width: AppDimens.marginHalf),
                Text(
                  Strings.of(context).share_article_link_label,
                  style: themeData.textTheme.subtitle2,
                ),
              ],
            ),
            TextField(
              controller: _linkController,
              focusNode: _linkFocusNode,
              obscuringCharacter: '･',
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context).textTheme.bodyText1,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: Strings.of(context).share_article_link_hint,
                hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.color
                        ?.withAlpha(80)),
                constraints: const BoxConstraints(
                    maxWidth: double.infinity,
                    minWidth: double.infinity,
                    minHeight: AppDimens.buttonHeight,
                    maxHeight: double.infinity),
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: AppDimens.buttonHeight,
                  minHeight: 0,
                ),
                suffixIcon:
                    _linkFocusNode.hasFocus && _linkController.text.isNotEmpty
                        ? IconButton(
                            constraints: const BoxConstraints.tightForFinite(),
                            onPressed: () {
                              setState(() {
                                _linkController.clear();
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
                          )
                        : null,
              ),
            ),
            const SizedBox(height: AppDimens.marginLarge),
            Center(
              child: MainButton(
                onPressed: _share,
                child: Text(Strings.of(context).share_article),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _share() async {
    try {
      await _viewModel.shareArticle(
        title: _titleController.text,
        link: _linkController.text,
      );
      _titleController.clear();
      _linkController.clear();
      WanToast(
        context,
        msg: Strings.of(context).share_article_successfully,
        type: WanToastType.success,
      ).show();
      AppRouter.of(context).pop();
    } on ApiException catch (e) {
      return e.msg ?? Strings.of(context).unknown_error;
    } catch (_) {
      return Strings.of(context).unknown_error;
    }
  }
}
