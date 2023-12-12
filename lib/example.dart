import 'package:flutter/material.dart';
import 'package:animated_menu_button/components/animated_,menu_button.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text("Hello world"),
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              children: [
                const SizedBox(
                  width: 60,
                  child: Icon(Icons.ac_unit),
                ),
                const SizedBox(
                  width: 60,
                  child: Icon(Icons.ac_unit),
                ),
                Expanded(
                    child: Center(
                  child: AnimatedMenuButton(
                    radius: 50,
                    homeWidget: item(
                      color: Colors.black,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    actionWidgets: [
                      InkWell(
                        onTap: () {
                          print("add");
                        },
                        child: item(
                          color: Colors.green,
                          child: const Icon(Icons.face),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("image");
                        },
                        child: item(
                          color: Colors.blue,
                          child: const Icon(Icons.image),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("cached_rounded");
                        },
                        child: item(
                          color: Colors.red,
                          child: const Icon(Icons.cached_rounded),
                        ),
                      )
                    ],
                    animatedDuration: const Duration(milliseconds: 1000),
                  ),
                )),
                const SizedBox(
                  width: 60,
                  child: Icon(Icons.ac_unit),
                ),
                const SizedBox(
                  width: 60,
                  child: Icon(Icons.ac_unit),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget item({required Widget child, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: child,
    );
  }
}
