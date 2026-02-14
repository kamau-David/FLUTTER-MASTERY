import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: AnimationsHome());
}

class AnimationsHome extends StatelessWidget {
  const AnimationsHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animations')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ImplicitAnimationDemo(),
          SizedBox(height: 32),
          _ExplicitAnimationDemo(),
          SizedBox(height: 32),
          _HeroDemoEntry(),
        ],
      ),
    );
  }
}

// IMPLICIT: you just declare the END state, and Flutter automatically
// animates from whatever the current values were to the new ones. No
// AnimationController needed - this covers most simple UI animation needs.
class _ImplicitAnimationDemo extends StatefulWidget {
  const _ImplicitAnimationDemo();
  @override
  State<_ImplicitAnimationDemo> createState() => _ImplicitAnimationDemoState();
}

class _ImplicitAnimationDemoState extends State<_ImplicitAnimationDemo> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Implicit: AnimatedContainer', style: TextStyle(fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _expanded ? 250 : 100,
            height: 100,
            color: _expanded ? Colors.deepPurple : Colors.blue,
            alignment: Alignment.center,
            child: const Text('Tap me', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

// EXPLICIT: full manual control via AnimationController - needed for
// repeating animations, custom curves synced to gestures, or animating
// multiple properties together on one shared clock.
class _ExplicitAnimationDemo extends StatefulWidget {
  const _ExplicitAnimationDemo();
  @override
  State<_ExplicitAnimationDemo> createState() => _ExplicitAnimationDemoState();
}

class _ExplicitAnimationDemoState extends State<_ExplicitAnimationDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    // AnimationController needs a "vsync" (SingleTickerProviderStateMixin
    // provides it) to sync with the screen's refresh rate.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // loop forever

    _rotation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // ALWAYS dispose controllers, same rule as folder 04's Timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Explicit: AnimationController', style: TextStyle(fontWeight: FontWeight.bold)),
        // AnimatedBuilder rebuilds only this small subtree on every tick,
        // instead of rebuilding the whole page 60 times a second.
        AnimatedBuilder(
          animation: _rotation,
          builder: (context, child) => Transform.rotate(
            angle: _rotation.value * 6.28, // radians (2*pi = full circle)
            child: child,
          ),
          child: const Icon(Icons.refresh, size: 60, color: Colors.deepPurple),
        ),
      ],
    );
  }
}

// HERO: shared-element transition - the SAME tag on two screens tells
// Flutter to automatically morph one into the other during navigation.
class _HeroDemoEntry extends StatelessWidget {
  const _HeroDemoEntry();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Hero: shared element transition', style: TextStyle(fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const _HeroDetailPage()),
          ),
          child: Hero(
            tag: 'demo-hero',
            child: Container(width: 80, height: 80, color: Colors.teal),
          ),
        ),
      ],
    );
  }
}

class _HeroDetailPage extends StatelessWidget {
  const _HeroDetailPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // SAME tag as above - Flutter automatically animates the box
        // growing from its small position to this large centered one.
        child: Hero(
          tag: 'demo-hero',
          child: Container(width: 250, height: 250, color: Colors.teal),
        ),
      ),
    );
  }
}
