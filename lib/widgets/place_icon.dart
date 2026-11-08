import 'package:flutter/material.dart';

class PlaceIcon extends StatelessWidget {
  final String iconType;
  final Color color;
  final double size;

  const PlaceIcon({
    super.key,
    required this.iconType,
    required this.color,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PlaceIconPainter(iconType: iconType, color: color),
    );
  }
}

class _PlaceIconPainter extends CustomPainter {
  final String iconType;
  final Color color;

  _PlaceIconPainter({required this.iconType, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    switch (iconType) {
      case 'laptop':
        _drawLaptop(canvas, w, h, paint, fill);
      case 'charger':
        _drawCharger(canvas, w, h, paint);
      case 'buku':
        _drawBuku(canvas, w, h, paint, fill);
      case 'tumbler':
        _drawTumbler(canvas, w, h, paint, fill);
      case 'dompet':
        _drawDompet(canvas, w, h, paint, fill);
      case 'hp':
        _drawHp(canvas, w, h, paint, fill);
      case 'earphone':
        _drawEarphone(canvas, w, h, paint);
      case 'game':
        _drawGame(canvas, w, h, paint, fill);
      case 'kamera':
        _drawKamera(canvas, w, h, paint, fill);
      default:
        _drawDefault(canvas, w, h, paint, fill);
    }
  }

  void _drawLaptop(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final screen = Rect.fromLTWH(w * 0.15, h * 0.2, w * 0.7, h * 0.45);
    canvas.drawRect(screen, fill);
    canvas.drawRect(screen, stroke);

    final base = Path()
      ..moveTo(w * 0.05, h * 0.8)
      ..lineTo(w * 0.95, h * 0.8)
      ..lineTo(w * 0.85, h * 0.65)
      ..lineTo(w * 0.15, h * 0.65)
      ..close();
    canvas.drawPath(base, fill);
    canvas.drawPath(base, stroke);
  }

  void _drawCharger(Canvas canvas, double w, double h, Paint stroke) {
    final bolt = Path()
      ..moveTo(w * 0.55, h * 0.1)
      ..lineTo(w * 0.3, h * 0.55)
      ..lineTo(w * 0.5, h * 0.55)
      ..lineTo(w * 0.4, h * 0.9)
      ..lineTo(w * 0.7, h * 0.45)
      ..lineTo(w * 0.5, h * 0.45)
      ..close();
    canvas.drawPath(bolt, stroke);
  }

  void _drawBuku(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final left = Path()
      ..moveTo(w * 0.5, h * 0.25)
      ..lineTo(w * 0.15, h * 0.15)
      ..lineTo(w * 0.15, h * 0.8)
      ..lineTo(w * 0.5, h * 0.7)
      ..close();
    canvas.drawPath(left, fill);
    canvas.drawPath(left, stroke);

    final right = Path()
      ..moveTo(w * 0.5, h * 0.25)
      ..lineTo(w * 0.85, h * 0.15)
      ..lineTo(w * 0.85, h * 0.8)
      ..lineTo(w * 0.5, h * 0.7)
      ..close();
    canvas.drawPath(right, stroke);
  }

  void _drawTumbler(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final body = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.3, h * 0.15, w * 0.4, h * 0.7),
      topLeft: Radius.circular(w * 0.08),
      topRight: Radius.circular(w * 0.08),
    );
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    canvas.drawLine(
      Offset(w * 0.3, h * 0.35),
      Offset(w * 0.7, h * 0.35),
      stroke,
    );

    canvas.drawLine(
      Offset(w * 0.4, h * 0.15),
      Offset(w * 0.4, h * 0.05),
      stroke,
    );
  }

  void _drawDompet(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final body = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.3, h * 0.25, w * 0.4, h * 0.55),
      topLeft: Radius.circular(w * 0.08),
      topRight: Radius.circular(w * 0.08),
      bottomLeft: Radius.circular(w * 0.08),
      bottomRight: Radius.circular(w * 0.08),
    );
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    canvas.drawCircle(Offset(w * 0.7, h * 0.52), w * 0.06, stroke);
  }

  void _drawHp(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final body = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.3, h * 0.1, w * 0.4, h * 0.8),
      topLeft: Radius.circular(w * 0.07),
      topRight: Radius.circular(w * 0.07),
      bottomLeft: Radius.circular(w * 0.07),
      bottomRight: Radius.circular(w * 0.07),
    );
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    canvas.drawLine(
      Offset(w * 0.42, h * 0.18),
      Offset(w * 0.58, h * 0.18),
      stroke,
    );
  }

  void _drawEarphone(Canvas canvas, double w, double h, Paint stroke) {
    final arc = Path()
      ..addArc(
        Rect.fromLTWH(w * 0.2, h * 0.2, w * 0.6, h * 0.5),
        3.14159,
        3.14159,
      );
    canvas.drawPath(arc, stroke);

    canvas.drawCircle(Offset(w * 0.2, h * 0.45), w * 0.1, stroke);
    canvas.drawCircle(Offset(w * 0.8, h * 0.45), w * 0.1, stroke);
  }

  void _drawGame(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final body = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.1, h * 0.3, w * 0.8, h * 0.45),
      topLeft: Radius.circular(w * 0.15),
      topRight: Radius.circular(w * 0.15),
      bottomLeft: Radius.circular(w * 0.12),
      bottomRight: Radius.circular(w * 0.12),
    );
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    // D-pad kiri
    canvas.drawLine(
      Offset(w * 0.28, h * 0.45),
      Offset(w * 0.28, h * 0.62),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.2, h * 0.535),
      Offset(w * 0.36, h * 0.535),
      stroke,
    );

    // Tombol kanan
    canvas.drawCircle(Offset(w * 0.68, h * 0.47), w * 0.035, stroke);
    canvas.drawCircle(Offset(w * 0.78, h * 0.57), w * 0.035, stroke);
  }

  void _drawKamera(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final body = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.1, h * 0.25, w * 0.8, h * 0.55),
      topLeft: Radius.circular(w * 0.08),
      topRight: Radius.circular(w * 0.08),
      bottomLeft: Radius.circular(w * 0.08),
      bottomRight: Radius.circular(w * 0.08),
    );
    canvas.drawRRect(body, fill);
    canvas.drawRRect(body, stroke);

    // Lensa
    canvas.drawCircle(Offset(w * 0.5, h * 0.52), w * 0.16, stroke);
    canvas.drawCircle(Offset(w * 0.5, h * 0.52), w * 0.07, stroke);

    // Viewfinder
    canvas.drawRect(
      Rect.fromLTWH(w * 0.35, h * 0.17, w * 0.2, h * 0.1),
      stroke,
    );
  }

  void _drawDefault(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final rect = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.2, h * 0.2, w * 0.6, h * 0.6),
      topLeft: Radius.circular(w * 0.1),
      topRight: Radius.circular(w * 0.1),
      bottomLeft: Radius.circular(w * 0.1),
      bottomRight: Radius.circular(w * 0.1),
    );
    canvas.drawRRect(rect, fill);
    canvas.drawRRect(rect, stroke);
  }

  @override
  bool shouldRepaint(covariant _PlaceIconPainter oldDelegate) =>
      oldDelegate.iconType != iconType || oldDelegate.color != color;
}
