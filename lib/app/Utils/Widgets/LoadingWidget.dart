import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                  width: 52,
                  height: 52,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: Colors.orangeAccent.withOpacity(0.9),
                    strokeWidth: 1,
                  )),
            ),
            Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: 32,
                height: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
