import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wanandroid/env/dimen/app_dimens.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';
import 'package:wanandroid/widget/opacity_button.dart';

class ScanWidget extends StatefulWidget {
  const ScanWidget({
    Key? key,
    required this.qrViewKey,
    required this.onQRViewCreated,
    this.barcode,
  }) : super(key: key);

  final GlobalKey qrViewKey;
  final ValueChanged<QRViewController> onQRViewCreated;
  final Barcode? barcode;

  @override
  State<ScanWidget> createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> {
  double _alignment = -0.6;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        _alignment = -_alignment;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        fit: StackFit.expand,
        children: [
          QRView(
            key: widget.qrViewKey,
            onQRViewCreated: widget.onQRViewCreated,
          ),
          if (widget.barcode == null)
            AnimatedAlign(
              duration: const Duration(milliseconds: 5000),
              alignment: Alignment(0, _alignment),
              onEnd: () => setState(() {
                _alignment = -_alignment;
              }),
              child: ClipRect(
                child: Align(
                  heightFactor: 0.5,
                  alignment: _alignment > 0
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.diagonal3Values(5, 1, 1.0),
                    child: Container(
                      width: double.infinity,
                      height: constraints.maxWidth * 0.2,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: const Alignment(0, 0),
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      );
    });
  }
}

class PermissionDeniedWidget extends StatelessWidget {
  const PermissionDeniedWidget({
    Key? key,
    required this.shouldShowRequestRationale,
    required this.onPressed,
  }) : super(key: key);

  final bool shouldShowRequestRationale;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.marginLarge),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.of(context).sacn_page_camera_permission_title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: AppDimens.marginNormal),
              Text(
                Strings.of(context).sacn_page_camera_permission_request,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.white54,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PermissionPermanentlyDeniedWidget extends StatelessWidget {
  const PermissionPermanentlyDeniedWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OpacityButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.marginLarge),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.of(context).sacn_page_camera_permission_title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: AppDimens.marginNormal),
              Text(
                Strings.of(context).sacn_page_camera_permission_go_settings,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.white54,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
