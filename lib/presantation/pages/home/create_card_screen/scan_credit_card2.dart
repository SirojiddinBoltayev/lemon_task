import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ml_card_scanner/ml_card_scanner.dart';

class CameraPage extends StatefulWidget {
  final Function(CardInfo) onScan;
  const CameraPage({Key? key, required this.onScan}) : super(key: key);
  static const routeName = '/camera_screen';
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ScannerWidgetController _controller = ScannerWidgetController();

  @override
  void initState() {
    super.initState();
    _controller
      ..setCardListener(_onListenCard)
      ..setErrorListener(_onError);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScannerWidget(
        controller: _controller,
        overlayOrientation: CardOrientation.landscape,
        cameraResolution: CameraResolution.high,
        oneShotScanning: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller
      ..removeCardListeners(_onListenCard)
      ..removeErrorListener(_onError)
      ..dispose();
    super.dispose();
  }

  void _onListenCard(CardInfo? value) {
    if (value != null) {
      widget.onScan(value);
      // Navigator.of(context).pop(value);
    }
  }

  void _onError(ScannerException exception) {
    if (kDebugMode) {
      print('Error: ${exception.message}');
    }
  }
}