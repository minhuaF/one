import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.home,
              color: Colors.black12,
            ),
          ),
          // const SizedBox(),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.ac_unit_outlined,
              color: Colors.black12,
            ),
          ),
          IconButton(
            onPressed: () => {
              Navigator.pushNamed(context, '/me')
            },
            icon: const Icon(
              Icons.access_alarm_rounded,
              color: Colors.black12,
            ),
          )
        ],
      ),
    );
  }
}
