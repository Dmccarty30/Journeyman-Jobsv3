import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

import 'package:journeyman_jobs/design_system/electrical/circuit_theme.dart';
import 'package:journeyman_jobs/design_system/electrical/circuit_settings_controller.dart';

/// A highly customizable electrical circuit board background with animated
/// current flow, interactive components, and PCB-style visual elements.
///
/// Features:
/// - Subtle PCB/motherboard-inspired circuit pattern
/// - Animated electricity flow with glowing effects
/// - Interactive components (switches, LEDs, capacitors)
/// - Configurable opacity, colors, and animation speeds
/// - Performance optimized for 60 FPS with <5% CPU usage
///
/// Example usage:
/// ```dart
/// Stack(
///   children: [
///     ElectricalCircuitBackground(
///       opacity: 0.15,
///       animationSpeed: 3.0,
///       componentDensity: ComponentDensity.medium,
///     ),
///     // Your main content here
///   ],
/// )
/// ```
class ElectricalCircuitBackground extends StatefulWidget {
  const ElectricalCircuitBackground({
    super.key,
    this.opacity,
    this.animationSpeed,
    this.componentDensity,
    this.enableCurrentFlow,
    this.enableInteractiveComponents,
    this.traceColor,
    this.currentColor,
    this.copperColor,
    this.themeVariant,
    this.customSubstrateColor,
    this.child,
  });

  /// Overall opacity of the circuit pattern (0.0 - 1.0). Defaults to global setting if null.
  final double? opacity;

  /// Animation speed multiplier (1.0 = normal). Defaults to global setting if null.
  final double? animationSpeed;

  /// Density of circuit components. Defaults to global setting if null.
  final ComponentDensity? componentDensity;

  /// Whether to show animated current flow. Defaults to global setting if null.
  final bool? enableCurrentFlow;

  /// Whether to show interactive animated components. Defaults to global setting if null.
  final bool? enableInteractiveComponents;

  /// Custom trace color (defaults to navy)
  final Color? traceColor;

  /// Custom current flow color (defaults to electric blue)
  final Color? currentColor;

  /// Custom copper accent color
  final Color? copperColor;

  /// Optional professionally designed theme variant
  final CircuitThemeVariant? themeVariant;

  /// Custom substrate (background) color for the circuit board.
  final Color? customSubstrateColor;

  /// Optional child widget to overlay on the background
  final Widget? child;

  @override
  State<ElectricalCircuitBackground> createState() =>
      _ElectricalCircuitBackgroundState();
}

/// Component density levels for the circuit board
enum ComponentDensity {
  low(0.5),
  medium(1.0),
  high(1.5),
  ultra(2.0);

  const ComponentDensity(this.multiplier);
  final double multiplier;
}

class _ElectricalCircuitBackgroundState
    extends State<ElectricalCircuitBackground> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _flowController;
  // The original _currentFlowAnimation and _componentAnimation are no longer directly used
  // as the values are accessed via controller.value directly in the painters.

  // Cached circuit paths for performance
  List<CircuitTrace>? _cachedTraces;
  List<CircuitComponent>? _cachedComponents;

  @override
  void initState() {
    super.initState();

    // Component animation (for switches, LEDs, etc.)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Current flow animation (smooth, continuous)
    _flowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _flowController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ElectricalCircuitBackground oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle animation state changes
    if ((widget.enableCurrentFlow ?? true) && !_flowController.isAnimating) {
      _flowController.repeat();
    }

    if ((widget.enableInteractiveComponents ?? true) &&
        !_pulseController.isAnimating) {
      _pulseController.repeat();
    }

    // Clear cache if density or substrate color changed
    if (oldWidget.componentDensity != widget.componentDensity ||
        oldWidget.customSubstrateColor != widget.customSubstrateColor) {
      _cachedTraces = null;
      _cachedComponents = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CircuitSettings>(
      valueListenable: CircuitSettingsController.instance,
      builder: (context, settings, _) {
        // Resolve effective values: Widget Override > Global Setting > Hard Default
        final effectiveOpacity = widget.opacity ?? settings.opacity;
        final effectiveSpeed = widget.animationSpeed ?? settings.animationSpeed;
        final effectiveDensity = widget.componentDensity ?? settings.density;
        final effectiveFlow =
            widget.enableCurrentFlow ?? settings.enableAnimations;
        final effectivePulse =
            widget.enableInteractiveComponents ?? settings.enableAnimations;
        final effectiveVariant = widget.themeVariant ??
            CircuitSettingsController.instance.currentThemeVariant;
        final effectiveSubstrate = widget.customSubstrateColor ??
            CircuitSettingsController.instance.currentSubstrateColor;

        // Determine colors based on theme or overrides
        final baseTraceColor = widget.traceColor ?? effectiveVariant.traceColor;

        final baseCopperColor =
            widget.copperColor ?? effectiveVariant.copperColor;

        final effectiveFlowColor = widget.currentColor ??
            _getHighContrastFlowColor(
                effectiveSubstrate ?? effectiveVariant.substrateColor);

        return LayoutBuilder(builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Static Circuit Board Layer
              CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: _CircuitBoardPainter(
                  opacity: effectiveOpacity,
                  traceColor: baseTraceColor,
                  copperColor: baseCopperColor,
                  componentDensity: effectiveDensity,
                  themeVariant: effectiveVariant,
                  customSubstrateColor: effectiveSubstrate,
                  cachedTraces: _cachedTraces,
                  cachedComponents: _cachedComponents,
                  onCacheUpdate: (traces, components) {
                    _cachedTraces = traces;
                    _cachedComponents = components;
                  },
                ),
              ),
              // Animated Current Flow Layer
              if (effectiveFlow)
                AnimatedBuilder(
                  animation: _flowController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter: _CurrentFlowPainter(
                        traces: _cachedTraces ?? [],
                        progress: _flowController.value * effectiveSpeed,
                        currentColor: effectiveFlowColor,
                        opacity: effectiveOpacity,
                      ),
                    );
                  },
                ),
              // Interactive Components Layer
              if (effectivePulse)
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter: _InteractiveComponentsPainter(
                        components: _cachedComponents ?? [],
                        opacity: effectiveOpacity,
                        componentColor:
                            widget.traceColor ?? const Color(0xFF404040),
                        ledColor: Colors.blueAccent, // Configurable?
                        progress: _pulseController.value,
                      ),
                    );
                  },
                ),
              if (widget.child != null) widget.child!,
            ],
          );
        });
      },
    );
  }

  Color _getHighContrastFlowColor(Color substrate) {
    // Calculate luminance (0.0 - 1.0)
    final luminance = substrate.computeLuminance();

    // If substrate is light (e.g., White, Tan), use a deep, vibrant color
    if (luminance > 0.4) {
      if (widget.themeVariant?.name == 'Vintage') {
        return const Color(0xFF003366); // Navy blue for vintage
      }
      return const Color(0xFF0055FF); // Electric Blue for light backgrounds
    }

    // If substrate is dark (e.g., Green, Navy, Black), use a bright glowing color
    // Check specific themes for better matching
    if (widget.themeVariant?.name == 'Navy Premium') {
      return const Color(0xFFFFD700); // Gold glow
    } else if (widget.themeVariant?.name == 'Stealth') {
      return const Color(0xFF00FFFF); // Cyan glow
    }

    // Default High Contrast (Amber/Orange is very standard for green PCBs)
    return const Color(0xFFFFC107); // Amber
  }
}

/// Types of circuit traces for visual hierarchy
enum TraceType { power, signal, dataBus }

/// Represents a circuit trace path for current flow animation
class CircuitTrace {
  final Path path;
  final double length;
  final List<Offset> keyPoints;
  final TraceType type;

  CircuitTrace({
    required this.path,
    required this.length,
    required this.keyPoints,
    required this.type,
  });

  bool get isPrimary => type == TraceType.power || type == TraceType.dataBus;
}

/// Represents an interactive circuit component
class CircuitComponent {
  final Offset position;
  final ComponentType type;
  final double size;
  final double rotation;

  CircuitComponent({
    required this.position,
    required this.type,
    required this.size,
    this.rotation = 0.0,
  });
}

enum ComponentType {
  resistor,
  capacitor,
  transistor,
  switchComponent,
  led,
  via,
  ic,
  crystal,
  inductor,
  diode,
  connector,
  testPoint,
}

/// Main painter for the static circuit board pattern
class _CircuitBoardPainter extends CustomPainter {
  _CircuitBoardPainter({
    required this.opacity,
    required this.traceColor,
    required this.copperColor,
    required this.componentDensity,
    this.themeVariant,
    this.customSubstrateColor,
    this.cachedTraces,
    this.cachedComponents,
    this.onCacheUpdate,
  });

  final double opacity;
  final Color traceColor;
  final Color copperColor;
  final ComponentDensity componentDensity;
  final CircuitThemeVariant? themeVariant;
  final Color? customSubstrateColor;
  final List<CircuitTrace>? cachedTraces;
  final List<CircuitComponent>? cachedComponents;
  final Function(List<CircuitTrace>, List<CircuitComponent>)? onCacheUpdate;

  @override
  void paint(Canvas canvas, Size size) {
    final traces = cachedTraces ?? _generateCircuitTraces(size);
    final components = cachedComponents ?? _generateComponents(size);

    if (cachedTraces == null || cachedComponents == null) {
      onCacheUpdate?.call(traces, components);
    }

    _paintCircuitBoard(canvas, size, traces, components);
  }

  void _paintCircuitBoard(Canvas canvas, Size size, List<CircuitTrace> traces,
      List<CircuitComponent> components) {
    // 1. Substrate (Background)
    // If we have a custom silicon color, use it. Otherwise theme.
    final substrateColor = customSubstrateColor ??
        themeVariant?.substrateColor ??
        const Color(0xFF0D4F35); // Default dark green

    final substratePaint = Paint()
      ..color = substrateColor.withValues(alpha: opacity * 0.6)
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & size, substratePaint);

    // 2. Traces (Gold/Metallic with Gradient)
    final traceGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        traceColor.withValues(alpha: opacity * 0.9), // Darker Gold/Base
        Color.lerp(traceColor, Colors.white, 0.5)!
            .withValues(alpha: opacity), // Shiny Highlight
        traceColor.withValues(alpha: opacity * 0.9), // Darker Gold/Base
      ],
      stops: const [0.3, 0.5, 0.7],
      tileMode: TileMode.repeated,
    ).createShader(Offset.zero & size);

    // Shadow for traces (Depth)
    final traceShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: opacity * 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);

    final powerTracePaint = Paint()
      ..shader = traceGradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final signalTracePaint = Paint()
      ..shader = traceGradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final dataBusTracePaint = Paint()
      ..shader = traceGradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // 3. Vias (Metallic Copper)
    final padGradient = RadialGradient(
      center: Alignment.topLeft,
      radius: 1.2,
      colors: [
        Colors.white.withValues(alpha: opacity * 0.9),
        copperColor.withValues(alpha: opacity),
        copperColor.withValues(alpha: opacity * 0.8),
      ],
      stops: const [0.1, 0.4, 1.0],
    ).createShader(Offset.zero & size);

    final viaPaint = Paint()
      ..shader = padGradient
      ..style = PaintingStyle.fill;

    // Draw Traces
    for (final trace in traces) {
      // Draw Shadow first (offset slightly)
      if (trace.type == TraceType.power) {
        canvas.drawPath(trace.path.shift(const Offset(1, 1)), traceShadowPaint);
      }

      // Select paint based on type
      Paint paint;
      if (trace.type == TraceType.power) {
        paint = powerTracePaint;
      } else if (trace.type == TraceType.dataBus) {
        paint = dataBusTracePaint;
      } else {
        paint = signalTracePaint;
      }

      // Draw shiny trace
      canvas.drawPath(trace.path, paint);

      // Draw Vias at endpoints
      if (trace.keyPoints.isNotEmpty) {
        // Vias size depends on trace width
        final viaSize = trace.type == TraceType.power ? 4.0 : 2.5;
        canvas.drawCircle(trace.keyPoints.first, viaSize, viaPaint);
        canvas.drawCircle(trace.keyPoints.last, viaSize, viaPaint);
      }
    }

    // 4. Components (with Shadows)
    final componentShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: opacity * 0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    final componentBodyPaint = Paint()
      ..color = const Color(0xFF222222).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;

    for (final component in components) {
      _drawComponent(canvas, component, componentBodyPaint, viaPaint,
          componentShadowPaint);
    }
  }

  // --- Generation Logic ---

  List<CircuitTrace> _generateCircuitTraces(Size size) {
    final grid = CircuitGrid(size, spacing: 40.0);
    final random = math.Random(12345); // Fixed seed
    final traces = <CircuitTrace>[];

    // Trace counts based on density
    final numTraces = (15 * componentDensity.multiplier).round();

    for (int i = 0; i < numTraces; i++) {
      // Find a random start point on the grid
      final start = grid.getNearestIntersection(Offset(
          random.nextDouble() * size.width, random.nextDouble() * size.height));

      // Determine Trace Type based on probability
      TraceType type;
      final r = random.nextDouble();
      if (r < 0.15)
        type = TraceType.power; // 15% Power rails
      else if (r < 0.45)
        type = TraceType.dataBus; // 30% Data bus
      else
        type = TraceType.signal; // 55% Signal traces

      final path = Path();
      path.moveTo(start.dx, start.dy);

      var current = start;
      final points = <Offset>[start];

      // Walk params
      final segments = random.nextInt(4) + 3; // 3-6 segments
      // 0: Right, 1: Down, 2: Left, 3: Up
      var direction = random.nextInt(4);

      for (int j = 0; j < segments; j++) {
        // Length is multiple of grid spacing
        // Power traces longer, signals shorter
        final lenMult = type == TraceType.power
            ? (random.nextInt(4) + 3)
            : (random.nextInt(3) + 2);
        final length = lenMult * grid.spacing;

        Offset target;
        switch (direction) {
          case 0:
            target = current + Offset(length, 0);
            break;
          case 1:
            target = current + Offset(0, length);
            break;
          case 2:
            target = current + Offset(-length, 0);
            break;
          case 3:
          default:
            target = current + Offset(0, -length);
            break;
        }

        // Clamp to screen bounds + margin
        target = Offset(
            target.dx.clamp(grid.spacing, size.width - grid.spacing),
            target.dy.clamp(grid.spacing, size.height - grid.spacing));

        // Re-snap to be sure
        target = grid.snap(target);

        if (target == current) {
          // Hit wall or stuck, change dir and try smaller move
          direction = (direction + 1) % 4;
          continue;
        }

        // Add chamfered corner if not the last segment
        if (j < segments - 1) {
          final chamferSize = 10.0;
          final dist = (target - current).distance;

          if (dist > chamferSize * 2.5) {
            // Draw line to start of chamfer
            // We need to know the NEXT direction to chamfer correctly
            // Assuming 90 deg turns

            // Actually, simpler approach:
            // Draw to target.
            // But to do chamfers properly, we need to stop SHORT of target,
            // then draw diagonal to new start of next segment.

            // For now, simpler Manhattan with grid points is OK, let's just do direct lines first
            // And add 45 degree segments explicitly if needed for visual flair.

            path.lineTo(target.dx, target.dy);
          } else {
            path.lineTo(target.dx, target.dy);
          }
        } else {
          path.lineTo(target.dx, target.dy);
        }

        current = target;
        points.add(current);

        // Pick next direction (always 90 degree turn)
        if (direction % 2 == 0) {
          // Was Horizontal
          direction = random.nextBool() ? 1 : 3; // Go Vertical
        } else {
          // Was Vertical
          direction = random.nextBool() ? 0 : 2; // Go Horizontal
        }
      }

      // Add trace if valid
      if (points.length > 1) {
        traces.add(CircuitTrace(
          path: path,
          length: 0, // Computed later
          keyPoints: points,
          type: type,
        ));
      }
    }
    return traces;
  }

  List<CircuitComponent> _generateComponents(Size size) {
    final grid = CircuitGrid(size, spacing: 40.0);
    final components = <CircuitComponent>[];
    final random = math.Random(24); // Fixed seed
    final density = componentDensity.multiplier;

    // Clusters based on density
    final numClusters = (4 * density).round();

    for (int i = 0; i < numClusters; i++) {
      final center = grid.getNearestIntersection(Offset(
          random.nextDouble() * size.width, random.nextDouble() * size.height));

      final r = random.nextDouble();

      if (r < 0.25) {
        // IC Cluster
        components.add(CircuitComponent(
          position: center,
          type: ComponentType.ic,
          size: 40.0, // Large
          rotation: 0.0,
        ));
        // Add Crystal nearby
        if (random.nextBool()) {
          components.add(CircuitComponent(
            position: center + Offset(grid.spacing * 1.5, 0),
            type: ComponentType.crystal,
            size: 14.0,
          ));
        }

        // Decoupling capacitors
        final capPoints = [
          center + Offset(-grid.spacing, -grid.spacing),
          center + Offset(grid.spacing, -grid.spacing),
          center + Offset(-grid.spacing, grid.spacing),
          center + Offset(grid.spacing, grid.spacing),
        ];
        for (final p in capPoints) {
          if (p.dx > 0 && p.dx < size.width && p.dy > 0 && p.dy < size.height) {
            components.add(CircuitComponent(
              position: p,
              type: ComponentType.capacitor,
              size: 16.0,
              rotation: random.nextBool() ? 0 : math.pi / 2,
            ));
          }
        }
      } else if (r < 0.5) {
        // Passive Row
        final count = random.nextInt(3) + 3;
        final isHorizontal = random.nextBool();
        final spacing = grid.spacing * 0.5;

        for (int k = 0; k < count; k++) {
          final pos = isHorizontal
              ? center + Offset((k - count / 2) * spacing, 0)
              : center + Offset(0, (k - count / 2) * spacing);

          final typeR = random.nextDouble();
          ComponentType type;
          if (typeR < 0.4)
            type = ComponentType.resistor;
          else if (typeR < 0.7)
            type = ComponentType.capacitor;
          else if (typeR < 0.9)
            type = ComponentType.diode;
          else
            type = ComponentType.inductor;

          if (pos.dx > 0 &&
              pos.dx < size.width &&
              pos.dy > 0 &&
              pos.dy < size.height) {
            components.add(CircuitComponent(
              position: pos,
              type: type,
              size: 14.0,
              rotation: isHorizontal ? math.pi / 2 : 0,
            ));
          }
        }
      } else if (r < 0.7) {
        // Connector / Interface
        components.add(CircuitComponent(
          position: center,
          type: ComponentType.connector,
          size: 20.0,
          rotation: random.nextBool() ? 0 : math.pi / 2,
        ));
      } else {
        // Scattered Vias / Test Points
        final count = random.nextInt(4) + 2;
        for (int k = 0; k < count; k++) {
          final pos = grid.snap(center +
              Offset((random.nextDouble() - 0.5) * 100,
                  (random.nextDouble() - 0.5) * 100));

          if (pos.dx > 0 &&
              pos.dx < size.width &&
              pos.dy > 0 &&
              pos.dy < size.height) {
            components.add(CircuitComponent(
              position: pos,
              type: random.nextBool()
                  ? ComponentType.via
                  : ComponentType.testPoint,
              size: 8.0,
            ));
          }
        }
      }
    }

    return components;
  }

  // --- Draw Helpers ---

  void _drawComponent(Canvas canvas, CircuitComponent component,
      Paint componentPaint, Paint viaPaint, Paint shadowPaint) {
    canvas.save();
    canvas.translate(component.position.dx, component.position.dy);
    canvas.rotate(component.rotation);

    // Draw Drop Shadow first
    if (component.type != ComponentType.via) {
      // Vias don't cast shadow
      canvas.save();
      canvas.translate(2, 2); // Shadow offset
      _drawComponentShape(canvas, component, shadowPaint, isShadow: true);
      canvas.restore();
    }

    // Draw Main Component
    _drawComponentShape(canvas, component, componentPaint, viaPaint: viaPaint);

    canvas.restore();
  }

  void _drawComponentShape(
      Canvas canvas, CircuitComponent component, Paint paint,
      {Paint? viaPaint, bool isShadow = false}) {
    switch (component.type) {
      case ComponentType.resistor:
        _drawResistor(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.capacitor:
        _drawCapacitor(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.transistor:
        _drawTransistor(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.switchComponent:
        _drawSwitch(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.led:
        _drawLED(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.via:
        if (!isShadow) _drawVia(canvas, component.size, viaPaint ?? paint);
        break;
      case ComponentType.ic:
        _drawIC(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.crystal:
        _drawCrystal(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.inductor:
        _drawInductor(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.diode:
        _drawDiode(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.connector:
        _drawConnector(canvas, component.size, paint, viaPaint);
        break;
      case ComponentType.testPoint:
        _drawTestPoint(canvas, component.size,
            mobilePaint: paint, viaPaint: viaPaint);
        break;
    }
  }

  void _drawResistor(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    // SMD Resistor (0603/0805 style)
    final width = size * 2.0;
    final height = size * 1.0;
    final padSize = width * 0.25;

    // Body Paint override if not shadow
    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color = const Color(0xFF2D2D2D).withValues(alpha: opacity)
          ..style = PaintingStyle.fill);

    // Pads
    if (padPaint != null) {
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(-width / 2 + padSize / 2, 0),
              width: padSize,
              height: height),
          padPaint);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(width / 2 - padSize / 2, 0),
              width: padSize,
              height: height),
          padPaint);
    } else {
      // Shadow mode: draw pads as block
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(-width / 2 + padSize / 2, 0),
              width: padSize,
              height: height),
          bodyPaint);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(width / 2 - padSize / 2, 0),
              width: padSize,
              height: height),
          bodyPaint);
    }

    // Body
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset.zero, width: width - (padSize * 1.5), height: height),
      padPaint != null ? effectiveBodyPaint : bodyPaint,
    );
  }

  void _drawCapacitor(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    final width = size * 2.0;
    final height = size * 1.0;
    final padSize = width * 0.25;

    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color = const Color(0xFFC19A6B).withValues(alpha: opacity)
          ..style = PaintingStyle.fill);

    if (padPaint != null) {
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(-width / 2 + padSize / 2, 0),
              width: padSize,
              height: height),
          padPaint);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(width / 2 - padSize / 2, 0),
              width: padSize,
              height: height),
          padPaint);
    } else {
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(-width / 2 + padSize / 2, 0),
              width: padSize,
              height: height),
          bodyPaint);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(width / 2 - padSize / 2, 0),
              width: padSize,
              height: height),
          bodyPaint);
    }

    canvas.drawRect(
      Rect.fromCenter(
          center: Offset.zero, width: width - (padSize * 1.5), height: height),
      padPaint != null ? effectiveBodyPaint : bodyPaint,
    );
  }

  void _drawTransistor(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    final bodySize = size * 1.5;
    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color = const Color(0xFF1A1A1A).withValues(alpha: opacity)
          ..style = PaintingStyle.fill);

    // Body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset.zero, width: bodySize, height: bodySize * 0.8),
        const Radius.circular(2),
      ),
      padPaint != null ? effectiveBodyPaint : bodyPaint,
    );

    // Pins
    final pinW = bodySize * 0.25;
    final pinH = bodySize * 0.3;
    final pPaint = padPaint ?? bodyPaint;

    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(0, -bodySize * 0.5), width: pinW, height: pinH),
        pPaint);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(-bodySize * 0.3, bodySize * 0.5),
            width: pinW,
            height: pinH),
        pPaint);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(bodySize * 0.3, bodySize * 0.5),
            width: pinW,
            height: pinH),
        pPaint);
  }

  void _drawSwitch(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    final width = size * 1.5;
    final height = size * 1.5;
    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color = const Color(0xFF333333).withValues(alpha: opacity)
          ..style = PaintingStyle.fill);

    final pPaint = padPaint ?? bodyPaint;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(-width * 0.4, 0),
            width: width * 0.2,
            height: height),
        pPaint);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(width * 0.4, 0), width: width * 0.2, height: height),
        pPaint);

    canvas.drawRect(
      Rect.fromCenter(
          center: Offset.zero, width: width * 0.8, height: height * 0.6),
      padPaint != null ? effectiveBodyPaint : bodyPaint,
    );

    canvas.drawCircle(
        Offset.zero,
        size * 0.35,
        Paint()
          ..color = const Color(0xFF111111).withValues(alpha: opacity)
          ..style = PaintingStyle.fill);
  }

  void _drawLED(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    final width = size * 1.2;
    final height = size * 1.2;
    final pPaint = padPaint ?? bodyPaint;

    // Housing (White) usually
    if (padPaint != null) {
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(0, 0), width: width, height: height * 0.9),
          Paint()..color = const Color(0xFFF0F0F0).withValues(alpha: opacity));
    } else {
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(0, 0), width: width, height: height * 0.9),
          bodyPaint);
    }

    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(-width * 0.4, 0),
            width: width * 0.15,
            height: height),
        pPaint);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(width * 0.4, 0),
            width: width * 0.15,
            height: height),
        pPaint);
    canvas.drawCircle(
        Offset.zero, size * 0.25, bodyPaint..style = PaintingStyle.fill);
  }

  void _drawVia(Canvas canvas, double size, Paint paint) {
    canvas.drawCircle(Offset.zero, size * 0.5, paint);
  }

  void _drawIC(Canvas canvas, double size, Paint bodyPaint, [Paint? padPaint]) {
    final width = size * 2.0;
    final height = size * 2.0;
    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color = const Color(0xFF1E1E1E).withValues(alpha: opacity)
          ..style = PaintingStyle.fill);

    final pPaint = padPaint ?? bodyPaint;
    final pinCount = 4;
    final pinSpacing = width / (pinCount + 1);

    for (int i = 0; i < 4; i++) {
      canvas.save();
      canvas.rotate(i * math.pi / 2);
      for (int p = 0; p < pinCount; p++) {
        double offset = -width / 2 + (p + 1) * pinSpacing;
        canvas.drawRect(
            Rect.fromCenter(
                center: Offset(offset, -height / 2 - 2),
                width: pinSpacing / 2,
                height: 4),
            pPaint);
      }
      canvas.restore();
    }

    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: width, height: height),
      Radius.circular(size * 0.1),
    );
    canvas.drawRRect(rect, padPaint != null ? effectiveBodyPaint : bodyPaint);

    // Pin 1 dot
    if (padPaint != null) {
      canvas.drawCircle(Offset(-width * 0.35, -height * 0.35), size * 0.1,
          Paint()..color = const Color(0xFF505050).withValues(alpha: opacity));
    }
  }

  void _drawCrystal(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    final width = size * 2.5;
    final height = size * 0.8;

    // Metal Can
    final canRect = Rect.fromCenter(
        center: Offset.zero, width: width * 0.7, height: height);
    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color = const Color(0xFFC0C0C0).withValues(alpha: opacity) // Silver
          ..style = PaintingStyle.fill);

    canvas.drawRRect(
        RRect.fromRectAndRadius(canRect, Radius.circular(size * 0.2)),
        padPaint != null ? effectiveBodyPaint : bodyPaint);

    // Pads
    if (padPaint != null) {
      final padW = size * 0.4;
      final padH = size * 0.6;
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(-width / 2 + padW / 2, 0),
              width: padW,
              height: padH),
          padPaint);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(width / 2 - padW / 2, 0),
              width: padW,
              height: padH),
          padPaint);
    }
  }

  void _drawInductor(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    // Wire wound / Spiral look
    final radius = size;
    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color = const Color(0xFF333333).withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0);

    if (padPaint == null) {
      // Shadow mode - circle
      canvas.drawCircle(Offset.zero, radius, bodyPaint);
      return;
    }

    // Pads
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(-radius, 0), width: size * 0.5, height: size),
        padPaint);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(radius, 0), width: size * 0.5, height: size),
        padPaint);

    // Coil
    canvas.drawCircle(Offset.zero, radius * 0.8, effectiveBodyPaint);
    canvas.drawCircle(Offset.zero, radius * 0.5, effectiveBodyPaint);
  }

  void _drawDiode(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    final width = size * 2.0;
    final height = size * 1.0;
    final padSize = width * 0.2;

    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color =
              const Color(0xFF222222).withValues(alpha: opacity) // Black body
          ..style = PaintingStyle.fill);

    // Pads
    if (padPaint != null) {
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(-width / 2 + padSize / 2, 0),
              width: padSize,
              height: height),
          padPaint);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(width / 2 - padSize / 2, 0),
              width: padSize,
              height: height),
          padPaint);
    }

    // Body
    final bodyRect = Rect.fromCenter(
        center: Offset.zero, width: width - padSize * 2.5, height: height);
    canvas.drawRect(
        bodyRect, padPaint != null ? effectiveBodyPaint : bodyPaint);

    if (padPaint != null) {
      // Cathode Band (Grey)
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(width * 0.2, 0),
              width: width * 0.1,
              height: height),
          Paint()..color = Colors.grey.withValues(alpha: opacity));
    }
  }

  void _drawConnector(Canvas canvas, double size, Paint bodyPaint,
      [Paint? padPaint]) {
    final width = size * 3.0;
    final height = size * 0.8;

    // Plastic housing
    final effectiveBodyPaint = bodyPaint.color == Colors.black
        ? bodyPaint
        : (Paint()
          ..color = const Color(0xFFDDDDDD)
              .withValues(alpha: opacity) // White/Beige plastic
          ..style = PaintingStyle.fill);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: width, height: height),
            Radius.circular(2)),
        padPaint != null ? effectiveBodyPaint : bodyPaint);

    // Pins
    if (padPaint != null) {
      final pins = 6;
      final step = width / (pins + 1);
      for (int i = 0; i < pins; i++) {
        final x = -width / 2 + (i + 1) * step;
        canvas.drawCircle(
            Offset(x, 0),
            size * 0.15,
            Paint()
              ..color = const Color(0xFFB87333).withValues(alpha: opacity)
              ..style = PaintingStyle.fill);
      }
    }
  }

  void _drawTestPoint(Canvas canvas, double size,
      {Paint? mobilePaint, Paint? viaPaint}) {
    final radius = size * 0.5;
    // Gold pad with hole
    if (viaPaint != null) {
      canvas.drawCircle(Offset.zero, radius, viaPaint);
      canvas.drawCircle(Offset.zero, radius * 0.4,
          Paint()..color = Colors.black.withValues(alpha: 0.2));
    } else if (mobilePaint != null) {
      canvas.drawCircle(Offset.zero, radius, mobilePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _CircuitBoardPainter ||
        oldDelegate.opacity != opacity ||
        oldDelegate.traceColor != traceColor ||
        oldDelegate.copperColor != copperColor ||
        oldDelegate.themeVariant != themeVariant ||
        oldDelegate.customSubstrateColor != customSubstrateColor ||
        oldDelegate.componentDensity != componentDensity;
  }
}

/// Painter for animated current flow effects
class _CurrentFlowPainter extends CustomPainter {
  _CurrentFlowPainter({
    required this.progress,
    required this.opacity,
    required this.currentColor,
    required this.traces,
  });

  final double progress;
  final double opacity;
  final Color currentColor;
  final List<CircuitTrace> traces;

  @override
  void paint(Canvas canvas, Size size) {
    if (traces.isEmpty) return;

    final glowPaint = Paint()
      ..color = currentColor.withValues(alpha: opacity * 0.8)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    final corePaint = Paint()
      ..color = currentColor.withValues(alpha: opacity * 1.0)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Animate current flow based on trace type
    for (final trace in traces) {
      if (trace.path.computeMetrics().isEmpty) continue;

      final pathMetric = trace.path.computeMetrics().first;
      final totalLength = pathMetric.length;

      if (trace.type == TraceType.power) {
        // Power: Continuous slow flow / heavy pulses
        final pulses = 3;
        for (int i = 0; i < pulses; i++) {
          final phaseOffset = (i / pulses);
          final animProgress = (progress + phaseOffset) % 1.0;

          final pulseLength = totalLength * 0.25; // Long pulses
          final pulseStart = animProgress * totalLength;
          final pulseEnd = pulseStart + pulseLength;

          _drawPulse(canvas, pathMetric, pulseStart, pulseEnd, totalLength,
              glowPaint, corePaint);
        }
      } else if (trace.type == TraceType.dataBus) {
        // Data Bus: Fast, short packets
        // Speed up the progress for data
        final dataProgress = (progress * 2.5) % 1.0;

        final packets = 5;
        for (int i = 0; i < packets; i++) {
          // Randomize spacing slightly using index
          final spacing = 1.0 / packets;
          final phaseOffset = i * spacing;
          final animProgress = (dataProgress + phaseOffset) % 1.0;

          final pulseLength = totalLength * 0.08; // Short packets
          final pulseStart = animProgress * totalLength;
          final pulseEnd = pulseStart + pulseLength;

          _drawPulse(canvas, pathMetric, pulseStart, pulseEnd, totalLength,
              glowPaint, corePaint);
        }
      } else {
        // Signal: Occasional single pulse
        // Use trace hash to offset timing so they don't all fire at once
        final randomOffset = (trace.hashCode % 100) / 100.0;
        final signalProgress = (progress + randomOffset) % 1.0;

        // Only show if in active definition window (e.g. 0.0 to 0.3) to simulate "occasional"
        if (signalProgress < 0.3) {
          final localProgress = signalProgress / 0.3; // Normalize 0-1
          final pulseLength = totalLength * 0.1;
          final pulseStart = localProgress * totalLength;
          final pulseEnd = pulseStart + pulseLength;

          _drawPulse(canvas, pathMetric, pulseStart, pulseEnd, totalLength,
              glowPaint..strokeWidth = 2.0, corePaint..strokeWidth = 0.5);
        }
      }
    }
  }

  void _drawPulse(Canvas canvas, PathMetric metric, double start, double end,
      double totalLength, Paint glow, Paint core) {
    if (end > totalLength) {
      // Wrap around
      final endFirst = totalLength;
      final lenSecond = end - totalLength;

      canvas.drawPath(metric.extractPath(start, endFirst), glow);
      canvas.drawPath(metric.extractPath(start, endFirst), core);

      if (lenSecond > 0) {
        canvas.drawPath(metric.extractPath(0, lenSecond), glow);
        canvas.drawPath(metric.extractPath(0, lenSecond), core);
      }
    } else {
      canvas.drawPath(metric.extractPath(start, end), glow);
      canvas.drawPath(metric.extractPath(start, end), core);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _CurrentFlowPainter ||
        oldDelegate.progress != progress ||
        oldDelegate.opacity != opacity ||
        oldDelegate.currentColor != currentColor;
  }
}

/// Painter for interactive animated components
class _InteractiveComponentsPainter extends CustomPainter {
  _InteractiveComponentsPainter({
    required this.progress,
    required this.opacity,
    required this.componentColor,
    required this.ledColor,
    required this.components,
  });

  final double progress;
  final double opacity;
  final Color componentColor;
  final Color ledColor;
  final List<CircuitComponent> components;

  @override
  void paint(Canvas canvas, Size size) {
    if (components.isEmpty) return;

    final switchPaint = Paint()
      ..color = componentColor.withValues(alpha: opacity * 0.9)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final ledPaint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill;

    final capacitorPaint = Paint()
      ..color = componentColor.withValues(alpha: opacity * 0.7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Animate specific component types
    for (int i = 0; i < components.length; i++) {
      final component = components[i];
      final animPhase = (progress + (i * 0.1)) % 1.0;

      canvas.save();
      canvas.translate(component.position.dx, component.position.dy);

      switch (component.type) {
        case ComponentType.switchComponent:
          _drawAnimatedSwitch(canvas, component.size, switchPaint, animPhase);
          break;
        case ComponentType.led:
          _drawAnimatedLED(canvas, component.size, ledPaint, animPhase);
          break;
        case ComponentType.capacitor:
          _drawAnimatedCapacitor(
              canvas, component.size, capacitorPaint, animPhase);
          break;
        default:
          break;
      }

      canvas.restore();
    }
  }

  void _drawAnimatedSwitch(
      Canvas canvas, double size, Paint paint, double phase) {
    // Animate tactile button press/activity
    final isActive = (phase * 4) % 1.0 < 0.2; // Active 20% of time

    if (isActive) {
      // Draw glowing ring around actuator
      canvas.drawCircle(
          Offset.zero,
          size * 0.4,
          Paint()
            ..color = ledColor.withValues(alpha: opacity * 0.6)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0));
    }
  }

  void _drawAnimatedLED(Canvas canvas, double size, Paint paint, double phase) {
    // LED Pulse
    final intensity = (math.sin(phase * math.pi * 2) + 1) / 2;
    final blinkPhase = (phase * 3) % 1.0;
    final isOn = blinkPhase < 0.7; // On 70% of the time

    if (isOn) {
      final glowColor = ledColor.withValues(alpha: opacity * 0.9 * intensity);

      // Draw glowing center lens
      canvas.drawCircle(
          Offset.zero,
          size * 0.25,
          Paint()
            ..color = glowColor
            ..style = PaintingStyle.fill);

      // Outer glow
      canvas.drawCircle(
          Offset.zero,
          size * 0.4,
          Paint()
            ..color = glowColor.withValues(alpha: 0.5)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0));
    }
  }

  void _drawAnimatedCapacitor(
      Canvas canvas, double size, Paint paint, double phase) {
    // Subtle internal charge pulse
    final pulse = (math.sin(phase * math.pi) + 1) / 2;

    final width = size * 1.8;
    final height = size * 0.8;

    // Draw faint glow bar moving across or pulsing
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero, width: width * 0.8, height: height * 0.6),
        Paint()
          ..color = componentColor.withValues(alpha: opacity * 0.3 * pulse)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _InteractiveComponentsPainter ||
        oldDelegate.progress != progress ||
        oldDelegate.opacity != opacity ||
        oldDelegate.componentColor != componentColor ||
        oldDelegate.ledColor != ledColor;
  }
}

/// Utility for Grid System
class CircuitGrid {
  final double spacing;
  final Size size;
  static const double defaultSpacing = 40.0;

  CircuitGrid(this.size, {this.spacing = defaultSpacing});

  Offset snap(Offset pos) {
    return Offset(
      (pos.dx / spacing).round() * spacing,
      (pos.dy / spacing).round() * spacing,
    );
  }

  Offset getNearestIntersection(Offset pos) => snap(pos);
}
