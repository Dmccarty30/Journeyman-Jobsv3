import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:journeyman_jobs/design_system/app_theme.dart';
import 'package:journeyman_jobs/design_system/electrical/circuit_settings_controller.dart';

/// Ultra-modern reactive background with flowing energy lines,
/// gradient mesh, and reactive particles. A fresh alternative to
/// the circuit board pattern.
///
/// Features:
/// - Animated gradient mesh backdrop with theme colors
/// - Flowing energy lines with copper/gold glow
/// - Floating reactive particles with parallax motion
/// - Pulsing glow nodes for depth and visual interest
/// - Performance optimized for 60 FPS
class UltraModernBackground extends StatefulWidget {
  const UltraModernBackground({
    super.key,
    this.opacity,
    this.animationSpeed,
    this.enableAnimations,
    this.child,
  });

  /// Overall opacity (0.0 - 1.0). Defaults to global setting.
  final double? opacity;

  /// Animation speed multiplier. Defaults to global setting.
  final double? animationSpeed;

  /// Whether animations are enabled. Defaults to global setting.
  final bool? enableAnimations;

  /// Optional child widget to overlay
  final Widget? child;

  @override
  State<UltraModernBackground> createState() => _UltraModernBackgroundState();
}

class _UltraModernBackgroundState extends State<UltraModernBackground>
    with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late AnimationController _flowController;
  late AnimationController _particleController;
  late AnimationController _glowController;

  // Cached data for performance
  List<_EnergyLine>? _cachedLines;
  List<_Particle>? _cachedParticles;
  List<_GlowNode>? _cachedNodes;
  Size? _cachedSize;

  @override
  void initState() {
    super.initState();

    // Subtle gradient shift (slow, continuous)
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);

    // Energy line flow animation
    _flowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Particle floating motion
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    // Glow node pulsing
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _flowController.dispose();
    _particleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CircuitSettings>(
      valueListenable: CircuitSettingsController.instance,
      builder: (context, settings, _) {
        final effectiveOpacity = widget.opacity ?? settings.opacity;
        final effectiveSpeed = widget.animationSpeed ?? settings.animationSpeed;
        final effectiveAnimations =
            widget.enableAnimations ?? settings.enableAnimations;

        return LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);

            // Regenerate cached data if size changed
            if (_cachedSize != size) {
              _cachedSize = size;
              _cachedLines = _generateEnergyLines(size);
              _cachedParticles = _generateParticles(size);
              _cachedNodes = _generateGlowNodes(size);
            }

            return RepaintBoundary(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Layer 1: Animated Gradient Mesh
                  AnimatedBuilder(
                    animation: _gradientController,
                    builder: (context, _) {
                      return CustomPaint(
                        size: size,
                        painter: _GradientMeshPainter(
                          progress: _gradientController.value,
                          opacity: effectiveOpacity,
                        ),
                      );
                    },
                  ),

                  // Layer 2: Flowing Energy Lines
                  if (effectiveAnimations)
                    AnimatedBuilder(
                      animation: _flowController,
                      builder: (context, _) {
                        return CustomPaint(
                          size: size,
                          painter: _EnergyLinesPainter(
                            lines: _cachedLines ?? [],
                            progress: _flowController.value * effectiveSpeed,
                            opacity: effectiveOpacity,
                          ),
                        );
                      },
                    ),

                  // Layer 3: Floating Particles
                  if (effectiveAnimations)
                    AnimatedBuilder(
                      animation: _particleController,
                      builder: (context, _) {
                        return CustomPaint(
                          size: size,
                          painter: _ParticlesPainter(
                            particles: _cachedParticles ?? [],
                            progress: _particleController.value,
                            opacity: effectiveOpacity,
                          ),
                        );
                      },
                    ),

                  // Layer 4: Pulsing Glow Nodes
                  if (effectiveAnimations)
                    AnimatedBuilder(
                      animation: _glowController,
                      builder: (context, _) {
                        return CustomPaint(
                          size: size,
                          painter: _GlowNodesPainter(
                            nodes: _cachedNodes ?? [],
                            pulseProgress: _glowController.value,
                            opacity: effectiveOpacity,
                          ),
                        );
                      },
                    ),

                  // Child content
                  if (widget.child != null) widget.child!,
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<_EnergyLine> _generateEnergyLines(Size size) {
    final random = math.Random(42);
    final lines = <_EnergyLine>[];
    final lineCount = 8;

    for (int i = 0; i < lineCount; i++) {
      final path = Path();

      // Start from edges or corners
      double startX, startY;
      final startEdge = random.nextInt(4);
      switch (startEdge) {
        case 0: // Left
          startX = 0;
          startY = random.nextDouble() * size.height;
          break;
        case 1: // Right
          startX = size.width;
          startY = random.nextDouble() * size.height;
          break;
        case 2: // Top
          startX = random.nextDouble() * size.width;
          startY = 0;
          break;
        default: // Bottom
          startX = random.nextDouble() * size.width;
          startY = size.height;
      }

      path.moveTo(startX, startY);

      // Create smooth curved path using quadratic beziers
      double currentX = startX;
      double currentY = startY;
      final segments = 3 + random.nextInt(3);

      for (int j = 0; j < segments; j++) {
        final endX = random.nextDouble() * size.width;
        final endY = random.nextDouble() * size.height;
        final controlX =
            (currentX + endX) / 2 + (random.nextDouble() - 0.5) * 200;
        final controlY =
            (currentY + endY) / 2 + (random.nextDouble() - 0.5) * 200;

        path.quadraticBezierTo(controlX, controlY, endX, endY);
        currentX = endX;
        currentY = endY;
      }

      lines.add(_EnergyLine(
        path: path,
        width: 1.5 + random.nextDouble() * 1.5,
        glowIntensity: 0.3 + random.nextDouble() * 0.4,
      ));
    }

    return lines;
  }

  List<_Particle> _generateParticles(Size size) {
    final random = math.Random(123);
    final particles = <_Particle>[];
    final count = (size.width * size.height / 25000).clamp(15, 40).toInt();

    for (int i = 0; i < count; i++) {
      particles.add(_Particle(
        basePosition: Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        radius: 2.0 + random.nextDouble() * 4.0,
        floatAmplitudeX: 10 + random.nextDouble() * 30,
        floatAmplitudeY: 10 + random.nextDouble() * 30,
        phaseOffset: random.nextDouble() * math.pi * 2,
        opacity: 0.2 + random.nextDouble() * 0.4,
      ));
    }

    return particles;
  }

  List<_GlowNode> _generateGlowNodes(Size size) {
    final random = math.Random(456);
    final nodes = <_GlowNode>[];
    final count = (size.width * size.height / 80000).clamp(4, 12).toInt();

    for (int i = 0; i < count; i++) {
      nodes.add(_GlowNode(
        position: Offset(
          50 + random.nextDouble() * (size.width - 100),
          50 + random.nextDouble() * (size.height - 100),
        ),
        radius: 30 + random.nextDouble() * 50,
        phaseOffset: random.nextDouble() * math.pi * 2,
        color: random.nextBool()
            ? AppTheme.accentCopper
            : AppTheme.secondaryCopper,
      ));
    }

    return nodes;
  }
}

// =================== DATA CLASSES ===================

class _EnergyLine {
  final Path path;
  final double width;
  final double glowIntensity;

  _EnergyLine({
    required this.path,
    required this.width,
    required this.glowIntensity,
  });
}

class _Particle {
  final Offset basePosition;
  final double radius;
  final double floatAmplitudeX;
  final double floatAmplitudeY;
  final double phaseOffset;
  final double opacity;

  _Particle({
    required this.basePosition,
    required this.radius,
    required this.floatAmplitudeX,
    required this.floatAmplitudeY,
    required this.phaseOffset,
    required this.opacity,
  });
}

class _GlowNode {
  final Offset position;
  final double radius;
  final double phaseOffset;
  final Color color;

  _GlowNode({
    required this.position,
    required this.radius,
    required this.phaseOffset,
    required this.color,
  });
}

// =================== PAINTERS ===================

/// Animated gradient mesh backdrop
class _GradientMeshPainter extends CustomPainter {
  final double progress;
  final double opacity;

  _GradientMeshPainter({
    required this.progress,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Animate gradient angle based on progress
    final angle = progress * math.pi * 0.3; // Subtle rotation

    // Color stops that shift subtly
    final colors = [
      AppTheme.primaryNavy.withValues(alpha: opacity * 0.9),
      Color.lerp(
        AppTheme.secondaryNavy,
        AppTheme.primaryNavy,
        0.5 + math.sin(progress * math.pi) * 0.2,
      )!
          .withValues(alpha: opacity * 0.85),
      Color.lerp(
        AppTheme.secondaryNavy,
        AppTheme.accentCopper,
        0.1 + progress * 0.05,
      )!
          .withValues(alpha: opacity * 0.7),
    ];

    final gradient = LinearGradient(
      begin:
          Alignment(-1.0 + math.cos(angle) * 0.3, -1.0 + math.sin(angle) * 0.3),
      end: Alignment(1.0 - math.cos(angle) * 0.3, 1.0 - math.sin(angle) * 0.3),
      colors: colors,
      stops: const [0.0, 0.5, 1.0],
    );

    final paint = Paint()..shader = gradient.createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, paint);

    // Add subtle radial overlay for depth
    final radialGradient = RadialGradient(
      center: Alignment(
        -0.3 + math.sin(progress * math.pi * 2) * 0.2,
        -0.3 + math.cos(progress * math.pi * 2) * 0.2,
      ),
      radius: 1.5,
      colors: [
        AppTheme.secondaryNavy.withValues(alpha: opacity * 0.3),
        Colors.transparent,
      ],
    );

    final radialPaint = Paint()
      ..shader = radialGradient.createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, radialPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientMeshPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.opacity != opacity;
  }
}

/// Flowing energy lines with copper glow
class _EnergyLinesPainter extends CustomPainter {
  final List<_EnergyLine> lines;
  final double progress;
  final double opacity;

  _EnergyLinesPainter({
    required this.lines,
    required this.progress,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final line in lines) {
      // Base line (subtle)
      final basePaint = Paint()
        ..color = AppTheme.accentCopper.withValues(alpha: opacity * 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = line.width
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(line.path, basePaint);

      // Animated glow segment
      final pathMetrics = line.path.computeMetrics();
      for (final metric in pathMetrics) {
        final length = metric.length;
        final dashLength = length * 0.15;
        final offset = (progress * length * 2) % (length + dashLength);

        final start = (offset - dashLength).clamp(0.0, length);
        final end = offset.clamp(0.0, length);

        if (end > start) {
          final extractPath = metric.extractPath(start, end);

          // Glow effect
          final glowPaint = Paint()
            ..color = AppTheme.accentCopper
                .withValues(alpha: opacity * line.glowIntensity)
            ..style = PaintingStyle.stroke
            ..strokeWidth = line.width * 3
            ..strokeCap = StrokeCap.round
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

          canvas.drawPath(extractPath, glowPaint);

          // Core bright line
          final corePaint = Paint()
            ..color = AppTheme.secondaryCopper.withValues(alpha: opacity * 0.9)
            ..style = PaintingStyle.stroke
            ..strokeWidth = line.width
            ..strokeCap = StrokeCap.round;

          canvas.drawPath(extractPath, corePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _EnergyLinesPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.opacity != opacity;
  }
}

/// Floating reactive particles
class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final double opacity;

  _ParticlesPainter({
    required this.particles,
    required this.progress,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      // Calculate floating position
      final phase = progress * math.pi * 2 + particle.phaseOffset;
      final currentPos = Offset(
        particle.basePosition.dx + math.sin(phase) * particle.floatAmplitudeX,
        particle.basePosition.dy +
            math.cos(phase * 0.7) * particle.floatAmplitudeY,
      );

      // Subtle pulsing size
      final pulseScale = 1.0 + math.sin(phase * 2) * 0.2;
      final currentRadius = particle.radius * pulseScale;

      // Draw soft glow
      final glowPaint = Paint()
        ..color = AppTheme.secondaryCopper
            .withValues(alpha: opacity * particle.opacity * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      canvas.drawCircle(currentPos, currentRadius * 2, glowPaint);

      // Draw core
      final corePaint = Paint()
        ..color =
            AppTheme.accentCopper.withValues(alpha: opacity * particle.opacity);

      canvas.drawCircle(currentPos, currentRadius, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.opacity != opacity;
  }
}

/// Pulsing glow nodes for accent
class _GlowNodesPainter extends CustomPainter {
  final List<_GlowNode> nodes;
  final double pulseProgress;
  final double opacity;

  _GlowNodesPainter({
    required this.nodes,
    required this.pulseProgress,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final node in nodes) {
      // Calculate pulse phase (staggered per node)
      final phase = pulseProgress * math.pi * 2 + node.phaseOffset;
      final pulseScale = 0.7 + math.sin(phase) * 0.3;
      final currentRadius = node.radius * pulseScale;
      final currentOpacity = opacity * (0.15 + math.sin(phase) * 0.1);

      // Radial gradient glow
      final gradient = RadialGradient(
        colors: [
          node.color.withValues(alpha: currentOpacity),
          node.color.withValues(alpha: currentOpacity * 0.5),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      );

      final paint = Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(center: node.position, radius: currentRadius),
        );

      canvas.drawCircle(node.position, currentRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GlowNodesPainter oldDelegate) {
    return oldDelegate.pulseProgress != pulseProgress ||
        oldDelegate.opacity != opacity;
  }
}
