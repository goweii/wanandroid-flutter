import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wanandroid/entity/article_info.dart';
import 'package:wanandroid/env/route/route_map.dart';
import 'package:wanandroid/env/route/router.dart';
import 'package:wanandroid/module/scan/scan_widget.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  PermissionStatus? _permissionStatus;
  bool _shouldShowRequestRationale = false;
  bool _settingsOpened = false;
  Barcode? _result;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    _checkPermissionState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (_settingsOpened) {
        _settingsOpened = false;
        _checkPermissionAfterSettings();
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          PermissionStatus? status = _permissionStatus;
          if (status == null) {
            return Container();
          }
          if (status.isGranted) {
            return ScanWidget(
              qrViewKey: qrKey,
              onQRViewCreated: _onQRViewCreated,
              barcode: _result,
            );
          }
          if (status.isPermanentlyDenied ||
              status.isRestricted ||
              status.isLimited) {
            return PermissionPermanentlyDeniedWidget(
              onPressed: () => _openSettings(),
            );
          }
          return PermissionDeniedWidget(
            shouldShowRequestRationale: _shouldShowRequestRationale,
            onPressed: () => _requestPermission(),
          );
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(_receivedScanData);
  }

  _receivedScanData(Barcode barcode) {
    if (_result != null) return;
    var data = barcode.code;
    if (data != null && data.isNotEmpty) {
      if (data.startsWith('http://') || data.startsWith('https://')) {
        setState(() {
          _result = barcode;
        });
        Future.delayed(const Duration(milliseconds: 100)).then((value) {
          AppRouter.of(context).pop();
          AppRouter.of(context).pushNamed(
            RouteMap.articlePage,
            arguments: ArticleInfo.fromUrl(data),
          );
        });
      }
    }
  }

  Future<void> _checkPermissionState() async {
    PermissionStatus status = await Permission.camera.status;
    bool shouldShowRequestRationale =
        await Permission.camera.shouldShowRequestRationale;
    setState(() {
      _permissionStatus = status;
      _shouldShowRequestRationale = shouldShowRequestRationale;
    });
  }

  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.camera.request();
    bool shouldShowRequestRationale =
        await Permission.camera.shouldShowRequestRationale;
    setState(() {
      _permissionStatus = status;
      _shouldShowRequestRationale = shouldShowRequestRationale;
    });
  }

  Future<void> _checkPermissionAfterSettings() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      setState(() {
        _permissionStatus = PermissionStatus.granted;
      });
    }
  }

  Future<void> _openSettings() async {
    bool success = await openAppSettings();
    setState(() {
      _settingsOpened = success;
    });
  }
}
