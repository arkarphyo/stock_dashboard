import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDialog {
  static void showMessage(context, String title, IconData icon, String message,
      {Color? color = Colors.black38}) {
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5, color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                constraints: const BoxConstraints(
                    maxWidth: 250, minHeight: 200, maxHeight: 300),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  border: Border.all(width: 0.5, color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              color: color,
                              size: 24,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(title,
                                  style: GoogleFonts.abel(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: color)),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close,
                                size: 24, color: Colors.black))
                      ],
                    ),
                    Divider(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        style: GoogleFonts.abel(
                            color: Colors.black87, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showLoading(context) {
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            child: Stack(
              children: [
                SizedBox(
                    width: 52,
                    height: 52,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      color: Colors.lightBlue.withOpacity(0.9),
                    )),
                Image.asset(
                  "assets/images/logo.png",
                  width: 52,
                  height: 52,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
