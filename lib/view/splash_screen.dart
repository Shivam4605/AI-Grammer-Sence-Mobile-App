import 'package:ai_grammer_app/view/chat_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _slideUp;
  late Animation<double> _iconScale;
  late Animation<double> _glowPulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _iconScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
    );

    _slideUp = Tween<double>(begin: 24, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _glowPulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          Positioned(
            top: -120,
            left: -80,
            child: _AmbientOrb(
              color: const Color(0xFF6A53E7).withOpacity(0.18),
              size: 360,
            ),
          ),

          Positioned(
            bottom: -100,
            right: -60,
            child: _AmbientOrb(
              color: const Color(0xFF5B3FD3).withOpacity(0.12),
              size: 300,
            ),
          ),

          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _iconScale.value,
                        child: Opacity(
                          opacity: _iconScale.value.clamp(0.0, 1.0),
                          child: child,
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedBuilder(
                          animation: _glowPulse,
                          builder: (context, _) => Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(
                                    0xFF6A53E7,
                                  ).withOpacity(0.35 * _glowPulse.value),
                                  const Color(0xFF6A53E7).withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          height: 108,
                          width: 108,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF7B63F0), Color(0xFF5B3FD3)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6A53E7).withOpacity(0.5),
                                blurRadius: 32,
                                spreadRadius: 4,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            "assets/Icon.png",
                            fit: BoxFit.none,
                          ),
                        ),

                        Positioned(
                          right: 16,
                          top: 16,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF0A0A0F).withAlpha(250),
                            ),
                            child: Image.asset("assets/Union.png"),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeIn.value,
                        child: Transform.translate(
                          offset: Offset(0, _slideUp.value),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _DividerLine(),
                            const SizedBox(width: 12),
                            Text(
                              "WELCOME TO",
                              style: TextStyle(
                                color: const Color(0xFF7D7C82),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 3.0,
                              ),
                            ),
                            const SizedBox(width: 12),
                            _DividerLine(),
                          ],
                        ),

                        const SizedBox(height: 14),

                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFC4B8FF),
                              Color(0xFF9D87FF),
                              Color(0xFF6A53E7),
                            ],
                          ).createShader(bounds),
                          child: const Text(
                            "AI GrammarSense",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                              height: 1.1,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Check grammar in every word & sentence",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFF7D7C82),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),

                  const Spacer(flex: 3),

                  AnimatedBuilder(
                    animation: _fadeIn,
                    builder: (context, child) =>
                        Opacity(opacity: _fadeIn.value, child: child),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ChatScreen();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 54,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF8B72FF),
                                    Color(0xFF6A53E7),
                                    Color(0xFF4E35C2),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF6A53E7,
                                    ).withOpacity(0.45),
                                    blurRadius: 24,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Get Started",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _AmbientOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFF7D7C82).withOpacity(0.5),
          ],
        ),
      ),
    );
  }
}
