import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

class ConnectivityChecker extends StatefulWidget {
  const ConnectivityChecker({Key? key}) : super(key: key);

  @override
  _ConnectivityCheckerState createState() => _ConnectivityCheckerState();
}
class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  bool _isConnected = false;
  bool _hasCheckedInitially = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    checkInitialConnectivity();
    InternetConnectionChecker().onStatusChange.listen(
      (status) {
        final isConnected = status == InternetConnectionStatus.connected;

        if (_hasCheckedInitially && _isConnected != isConnected) {
          setState(
            () {
              _isConnected = isConnected;
            },
          );

          _showOverlay(
            isConnected ? 'Internet is Connected' : 'No Internet Connection',
            isConnected
                ? 'assets/images/con1.json'
                : 'assets/images/connection1.json',
          );
        }
      },
    );
  }

  Future<void> checkInitialConnectivity() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    setState(
      () {
        _isConnected = isConnected;
        _hasCheckedInitially = true;
      },
    );
  }

  void _showOverlay(String message, String animationPath) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 16.0,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
             color: Color.fromARGB(200, 100, 200, 200),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 0.1,
                  spreadRadius: 0.2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10,),
                Lottie.asset(
                  animationPath,
                  height: 50,
                  width: 50,
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
    Future.delayed(Duration(seconds: 5), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
