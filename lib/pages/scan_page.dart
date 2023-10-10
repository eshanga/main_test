import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ussd_service/ussd_service.dart';

class ScanScreen extends StatefulWidget {
  final double appBarHeightSize;

  const ScanScreen({Key? key, required this.appBarHeightSize})
      : super(key: key);
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Connect',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Comfortaa_bold',
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
            top: widget.appBarHeightSize,
            child: buildControlButtons(),
          ),
          Positioned(
            bottom: 10,
            child: buildResult(),
          ),
        ],
      ),
    );
  }

  Widget buildControlButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
            icon: SvgPicture.asset(
              'assets/icons/plus.1.svg',
              color: Theme.of(context).iconTheme.color!,
            ),
          ),
          IconButton(
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
            icon: SvgPicture.asset(
              'assets/icons/camera.1.svg',
              color: Theme.of(context).iconTheme.color!,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white54, borderRadius: BorderRadius.circular(8)),
        child: Text(
          barcode != null ? 'Result : ${barcode!.code}' : 'Scan to connect',
          maxLines: 3,
        ),
      );

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).iconTheme.color!,
        borderRadius: 20,
        borderLength: 40,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
        makeMyRequest(barcode);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: ((context) => ChatSpace(
        //           conversationInfo: ConversationInfo(
        //             image: 'assets/images/1.png',
        //             username: '${barcode.code}',
        //             message: [],
        //             badge: '02',
        //           ),message: [],
        //           appBarHeightSize: widget.appBarHeightSize,
        //         )),
        //   ),
        // );
      });
    });
  }

  makeMyRequest(Barcode barcode) async {
    int simCardSubscriptionId = 1;
    // String requestCode = "#150*212*${barcode.code}#";
    String requestCode = "#123#";

    final callPhonePermissionStatus = await Permission.phone.status;
    final callPhoneServicesPermissionStatus =
        await Permission.phone.serviceStatus;
    if (callPhonePermissionStatus.isGranted) {
      try {
        String ussdResponseMessage =
            await UssdService.makeRequest(simCardSubscriptionId, requestCode);
        print(ussdResponseMessage);
      } catch (e) {
        print(e);
      }
    } else {
      print("c'est le ndem");
    }
  }
}
