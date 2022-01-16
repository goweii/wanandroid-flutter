import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';

/// 主按钮
///
/// 根据点击事件的执行按钮会在 normal/loading/error 三个状态间切换。
class MainButton extends StatefulWidget {
  const MainButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.disable = false,
    this.transitionDuration = const Duration(milliseconds: 200),
    this.loadingDuration = const Duration(milliseconds: 500),
    this.errorDuration = const Duration(milliseconds: 2000),
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  /// normal 状态中心显示的组件
  final Widget child;

  /// 点击事件回调，这是一个异步方法
  /// 方法开始执行时按钮会切换为 loading 状态，
  /// 方法结束时根据返回值是否为 null 切换到 normal 状态或者 error 状态
  /// 你应该返回一个 String 类型用作错误提示，因为显示错误的是一个 Text 组件
  ///
  /// 例如：
  ///
  /// MainButton(
  ///   child: Text(Strings.of(context).login),
  ///   disable: !btnEnable,
  ///   onPressed: _login,
  /// )
  ///
  /// Future<dynamic> _login() async {
  ///   try {
  ///     await _repo.login(
  ///       username: _account!,
  ///       password: _password!,
  ///     );
  ///   } on ApiException catch (e) {
  ///     return e.msg ?? Strings.of(context).unknown_error;
  ///   } catch (_) {
  ///     return Strings.of(context).unknown_error;
  ///   }
  /// }
  final Future<dynamic> Function() onPressed;

  /// 按钮是否被禁用，禁用将不可点击
  final bool disable;

  /// 状态由 normal -> loading 或者 loading -> normal/error 的动画时长
  /// 为 null 时不执行动画
  final Duration? transitionDuration;

  /// loading 状态最小持续时长
  /// 如果 [onPressed] 执行时间小于这个，将强制保持 loading 状态直到满足这个最小时长
  /// 为 null 时将使用 [transitionDuration]
  final Duration? loadingDuration;

  /// error 状态持续时长
  final Duration errorDuration;

  final Color? borderColor;

  final BorderRadius? borderRadius;

  final double? borderWidth;

  final Color? backgroundColor;

  final Color? foregroundColor;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  /// 控制是否处于 loading 状态
  bool _loading = false;

  /// 控制是否处于 error 状态
  dynamic _reason;

  bool _dispose = false;

  @override
  void initState() {
    _dispose = false;
    super.initState();
  }

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraions) {
      return AnimatedContainer(
        duration: widget.transitionDuration ?? Duration.zero,
        width: widget.transitionDuration != null
            ? _loading
                ? AppDimens.buttonHeight
                : constraions.maxWidth
            : constraions.maxWidth,
        height: AppDimens.buttonHeight,
        child: _loading ? _buildLoading(context) : _buildText(context),
      );
    });
  }

  Widget _buildText(BuildContext context) {
    return TextButton(
      onPressed: !widget.disable && !_loading && _reason == null
          ? () => _onPressed()
          : null,
      child: Center(
        child: _reason == null
            ? widget.child
            : Text(
                _reason!.toString(),
                maxLines: 1,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(widget.borderRadius == null
            ? const StadiumBorder()
            : RoundedRectangleBorder(
                borderRadius: widget.borderRadius!,
              )),
        side: MaterialStateProperty.all(BorderSide(
          color: widget.borderColor ?? Colors.transparent,
          width: widget.borderWidth ?? 0.0,
        )),
        minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, AppDimens.buttonHeight)),
        maximumSize: MaterialStateProperty.all(
            const Size(double.infinity, AppDimens.buttonHeight)),
        textStyle:
            MaterialStateProperty.all(Theme.of(context).textTheme.button),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          Color foregroundColor =
              widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary;
          if (states.contains(MaterialState.disabled)) {
            return foregroundColor.withOpacity(0.6);
          }
          return foregroundColor;
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          Color backgroundColor =
              widget.backgroundColor ?? Theme.of(context).colorScheme.primary;
          if (states.contains(MaterialState.disabled)) {
            return backgroundColor.withOpacity(0.6);
          }
          return backgroundColor;
        }),
        overlayColor: MaterialStateProperty.all(
            (widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary)
                .withAlpha(50)),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
          horizontal: AppDimens.marginNormal,
          vertical: AppDimens.marginSmall,
        )),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    final Color foregroundColor =
        widget.foregroundColor ?? Theme.of(context).colorScheme.onPrimary;
    final Color backgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.primary;
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.6),
          borderRadius: const BorderRadius.all(
              Radius.circular(AppDimens.buttonHeight * 0.5)),
        ),
        child: Center(
          child: CupertinoTheme(
            data: CupertinoThemeData(
              brightness: Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
            ),
            child: SizedBox(
              width: AppDimens.buttonHeight * 0.6,
              height: AppDimens.buttonHeight * 0.6,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [foregroundColor, foregroundColor],
                  ).createShader(bounds);
                },
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.transparent,
                  strokeWidth: AppDimens.circularProgressIndicatorStrokeWidth,
                  valueColor: AlwaysStoppedAnimation(foregroundColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    // 切换到 loading 状态
    setState(() => _loading = true);

    // 执行点击事件，拿到错误提示和 onPressed 消耗的时间
    int time1 = DateTime.now().microsecond;
    dynamic reason = await widget.onPressed();

    if (_dispose) return;

    Duration costDuration = Duration(
      microseconds: DateTime.now().microsecond - time1,
    );

    // 如果不满足 transition 持续最小事件，继续等待
    Duration transitionDuration = widget.transitionDuration ?? Duration.zero;
    if (costDuration < transitionDuration) {
      await Future.delayed(transitionDuration - costDuration);
    }

    if (_dispose) return;

    costDuration = Duration(microseconds: DateTime.now().microsecond - time1);

    // 如果不满足 loading 持续最小事件，继续等待
    Duration loadingDuration = widget.loadingDuration ?? Duration.zero;
    if (costDuration < loadingDuration) {
      await Future.delayed(loadingDuration - costDuration);
    }

    if (_dispose) return;

    // 结束 loading 状态
    setState(() => _loading = false);

    if (reason == null) return;

    // 有错误提示，则切换到 error 暂时错误提示信息
    setState(() => _reason = reason);

    // 继续等待错误提示
    await Future.delayed(widget.errorDuration);

    if (_dispose) return;

    setState(() => _reason = null);
  }
}
