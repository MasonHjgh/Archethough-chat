import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_village/authentication/authentication.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                height: 250,
                color: Colors.teal,
              ),
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Text(
                "Account Settings",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              left: 40,
              top: 0,
              bottom: -15,
              child: CircleAvatar(
                child: Image.asset("assets/images/avatar.png"),
                radius: 60,
              ),
            ),
            Positioned(
              bottom: 120,
              left: 0,
              right: -20,
              child: Text(
                "John Doe",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              bottom: 90,
              left: 0,
              right: -25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Update Status",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 46,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Edit your Profile",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Divider(
          indent: 50,
          endIndent: 50,
          color: Colors.white70,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
                data: Theme.of(context).copyWith(useMaterial3: true),
                child: Switch(
                  value: true,
                  onChanged: (bool val) {},
                  activeColor: Colors.white,
                  activeTrackColor: Colors.teal,
                  inactiveThumbColor: Colors.teal,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Change to Dark Theme",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Divider(
          indent: 50,
          endIndent: 50,
          color: Colors.white70,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_active,
                size: 36,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Manage Notifications",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Divider(
          indent: 50,
          endIndent: 50,
          color: Colors.white70,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                size: 36,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Report an Issue",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Divider(
          indent: 50,
          endIndent: 50,
          color: Colors.white70,
        ),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          return InkWell(
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    size: 36,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
