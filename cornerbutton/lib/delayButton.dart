import 'package:flutter/material.dart';

class DelayButton extends StatefulWidget {
  const DelayButton({Key? key}) : super(key: key);

  @override
  _DelayButtonState createState() => _DelayButtonState();
}

class _DelayButtonState extends State<DelayButton> with TickerProviderStateMixin {
  bool _showMenu = false;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    _animations = _controllers.map((controller) => CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DelayButton'),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_showMenu) {
              _showMenu = false;
              _disposeControllers();
            } else {
              _showMenu = true;
              _initializeControllers();
              _startAnimations();
            }
          });
        },
        child: _showMenu ? const Icon(Icons.cancel_outlined) : const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _showMenu ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    _buildAnimatedIconButton(Icons.home, _animations[0],),
                    const SizedBox(height: 10,),
                    _buildAnimatedIconButton(Icons.favorite, _animations[1],),
                    const SizedBox(height: 10,),
                    _buildAnimatedIconButton(Icons.person, _animations[2],),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedIconButton(IconData icon, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0.0, 10.0 * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.purple.shade200,
          ),
          child: IconButton(
            icon: Icon(icon),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  void _startAnimations() {
    for (var i = _controllers.length - 1; i >= 0; i--) {
      Future.delayed(Duration(milliseconds: (_controllers.length - 1 - i) * 100), () {
        _controllers[i].forward();
      });
    }
  }



  void _disposeControllers() {
    for (var controller in _controllers) {
      controller.dispose();
    }
  }
}
