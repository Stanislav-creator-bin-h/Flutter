import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _logoVisible = false;
  bool _formVisible = false;

  double _buttonScale = 1.0;

  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _logoVisible = true);
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _formVisible = true);
    });
  }

  void _playShakeAnimation() {
    _shakeController.reset();
    _shakeController.forward();
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _playShakeAnimation();
      _showSnackBar('Будь ласка, заповніть усі поля!', Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (email == 'test@test.com' && password == '123456') {
      setState(() => _isSuccess = true);
    } else {
      _playShakeAnimation();
      _showSnackBar('Невірний Email або пароль!', Colors.red);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).clearSnackBars(); 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _isSuccess = false;
      _isLoading = false;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login з анімаціями'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedOpacity(
                opacity: _logoVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                child: const Column(
                  children: [
                    Icon(Icons.lock_outline, size: 80, color: Colors.deepPurple),
                    SizedBox(height: 8),
                    Text(
                      'Вхід у систему',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            bottom: _formVisible ? 120 : -350,
            left: 24,
            right: 24,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildCurrentState(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentState() {
    if (_isSuccess) {
      return Column(
        key: const ValueKey('success_state'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/animation_cheak.json',
            width: 140,
            height: 140,
            repeat: false,
          ),
          const Text(
            'Вітаємо з успішним входом!',
            style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _resetForm,
            child: const Text('Вийти (Скинути форму)'),
          ),
        ],
      );
    }

    if (_isLoading) {
      return const SizedBox(
        key: ValueKey('loading_state'),
        height: 220,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return AnimatedBuilder(
      key: const ValueKey('form_state'),
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Пароль',
              prefixIcon: Icon(Icons.lock_open_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTapDown: (_) => setState(() => _buttonScale = 0.94),
            onTapUp: (_) {
              setState(() => _buttonScale = 1.0);
              _handleLogin();
            },
            onTapCancel: () => setState(() => _buttonScale = 1.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              transform: Matrix4.identity()..scale(_buttonScale),
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  backgroundColor: Colors.deepPurple,
                  disabledBackgroundColor: Colors.deepPurple,
                  disabledForegroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Увійти', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}