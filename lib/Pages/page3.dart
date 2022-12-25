import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:math' as math;

void main(List<String> args) {
  runApp(const page3());
}

class page3 extends StatelessWidget {
  const page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Animation(),
    );
  }
}

class Animation extends StatefulWidget {
  const Animation({super.key});

  @override
  State<Animation> createState() => _AnimationState();
}

class _AnimationState extends State<Animation> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();
  bool _currentState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: FractionalOffset.center,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'asset/img/download.png',
              width: 200,
            ),
            const SizedBox(
              height: 50,
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
                child: const CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('asset/img/P.png'),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 300,
              child: Text(
                "WELLCOME TO PODCAST KITA - Podcast Kita eps.1",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFF393737),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: NeumorphicProgress(
                height: 20,
                percent: 0.3,
                style: ProgressStyle(
                  accent: Colors.purple,
                  depth: 2,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const IconButton(
                  onPressed: null,
                  iconSize: 50,
                  icon: Icon(
                    Icons.fast_rewind,
                    color: Color(0xFF494CA2),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                IconButton(
                  onPressed: () {
                    print(_currentState);
                    setState(() {
                      // Toggle berputar when tapped.
                      _currentState = !_currentState;
                      if (_currentState == true) {
                        _controller.stop();
                      } else {
                        _controller.repeat();
                      }
                    });
                  },
                  iconSize: 70,
                  icon: Icon(
                    _currentState ? Icons.play_arrow : Icons.pause,
                    color: Color(0xFF494CA2),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                const IconButton(
                  onPressed: null,
                  iconSize: 50,
                  icon: Icon(
                    Icons.fast_forward,
                    color: Color(0xFF494CA2),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
