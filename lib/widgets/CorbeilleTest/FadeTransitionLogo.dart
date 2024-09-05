import 'package:espace_client/Constants.dart';
import 'package:espace_client/widgets/MyContainer/Views/MyContainerView.dart';
import 'package:flutter/material.dart';

class FadeTransitionLogo extends StatefulWidget {
  @override
  _FadeTransitionLogoState createState() => _FadeTransitionLogoState();
}

class _FadeTransitionLogoState extends State<FadeTransitionLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _controller.forward().whenComplete(() {
      final navigator = Navigator.of(context);
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MyConatinerView(),
        ),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultSecondryColor,
      body: Center(
        child: FadeTransition(
            opacity: _animation, child: Image.asset('assets/img/BYSUR.jpg')
            /*   child: Image.network(
              "https://scontent.ftun16-1.fna.fbcdn.net/v/t39.30808-6/271712710_111378994760534_6728790707634796097_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_ohc=JezJ7KB3R24Q7kNvgHCUEa_&_nc_ht=scontent.ftun16-1.fna&oh=00_AYB4ZCsIC06s6Ircznl0lBDlKF31aV1Pi-Eq168rMJpT0A&oe=66A6E954"),
        */
            ),
      ),
    );
  }
}
