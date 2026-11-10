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
      case 'sekolah':
        _drawSekolah(canvas, w, h, paint, fill);
      case 'cafe':
        _drawCafe(canvas, w, h, paint, fill);
      case 'mall':
        _drawMall(canvas, w, h, paint, fill);
      case 'rumah':
        _drawRumah(canvas, w, h, paint, fill);
      case 'kantor':
        _drawKantor(canvas, w, h, paint, fill);
      case 'les':
        _drawLes(canvas, w, h, paint, fill);
      case 'kampus':
        _drawKampus(canvas, w, h, paint, fill);
      case 'gym':
        _drawGym(canvas, w, h, paint, fill);
      case 'lainnya':
        _drawLainnya(canvas, w, h, paint, fill);
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

  void _drawSekolah(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final building = Rect.fromLTWH(w * 0.22, h * 0.42, w * 0.56, h * 0.43);
    canvas.drawRect(building, fill);
    canvas.drawRect(building, stroke);

    final roof = Path()
      ..moveTo(w * 0.14, h * 0.44)
      ..lineTo(w * 0.5, h * 0.18)
      ..lineTo(w * 0.86, h * 0.44);
    canvas.drawPath(roof, stroke);

    canvas.drawRect(
      Rect.fromLTWH(w * 0.44, h * 0.65, w * 0.12, h * 0.2),
      stroke,
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.29, h * 0.52, w * 0.08, h * 0.08),
      stroke,
    );
    canvas.drawRect(
      Rect.fromLTWH(w * 0.63, h * 0.52, w * 0.08, h * 0.08),
      stroke,
    );

    canvas.drawLine(
      Offset(w * 0.5, h * 0.18),
      Offset(w * 0.5, h * 0.08),
      stroke,
    );
  }

  void _drawCafe(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final cup = Path()
      ..moveTo(w * 0.26, h * 0.42)
      ..lineTo(w * 0.74, h * 0.42)
      ..lineTo(w * 0.66, h * 0.78)
      ..lineTo(w * 0.34, h * 0.78)
      ..close();
    canvas.drawPath(cup, fill);
    canvas.drawPath(cup, stroke);

    canvas.drawArc(
      Rect.fromLTWH(w * 0.7, h * 0.45, w * 0.16, h * 0.16),
      -1.5708,
      3.14159,
      false,
      stroke,
    );

    canvas.drawLine(
      Offset(w * 0.22, h * 0.86),
      Offset(w * 0.78, h * 0.86),
      stroke,
    );

    final steam1 = Path()
      ..moveTo(w * 0.4, h * 0.3)
      ..quadraticBezierTo(w * 0.34, h * 0.24, w * 0.42, h * 0.17);
    canvas.drawPath(steam1, stroke);

    final steam2 = Path()
      ..moveTo(w * 0.56, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.24, w * 0.58, h * 0.17);
    canvas.drawPath(steam2, stroke);
  }

  void _drawMall(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final bag = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.24, h * 0.4, w * 0.52, h * 0.45),
      bottomLeft: Radius.circular(w * 0.04),
      bottomRight: Radius.circular(w * 0.04),
    );
    canvas.drawRRect(bag, fill);
    canvas.drawRRect(bag, stroke);

    canvas.drawArc(
      Rect.fromLTWH(w * 0.36, h * 0.24, w * 0.28, h * 0.28),
      3.14159,
      3.14159,
      false,
      stroke,
    );

    canvas.drawLine(
      Offset(w * 0.5, h * 0.42),
      Offset(w * 0.5, h * 0.48),
      stroke,
    );
  }

  void _drawRumah(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final roof = Path()
      ..moveTo(w * 0.5, h * 0.16)
      ..lineTo(w * 0.14, h * 0.48)
      ..lineTo(w * 0.86, h * 0.48)
      ..close();
    canvas.drawPath(roof, fill);
    canvas.drawPath(roof, stroke);

    final body = Rect.fromLTWH(w * 0.24, h * 0.48, w * 0.52, h * 0.37);
    canvas.drawRect(body, fill);
    canvas.drawRect(body, stroke);

    canvas.drawRect(
      Rect.fromLTWH(w * 0.44, h * 0.64, w * 0.12, h * 0.21),
      stroke,
    );
  }

  void _drawKantor(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final tower = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.28, h * 0.14, w * 0.44, h * 0.71),
      topLeft: Radius.circular(w * 0.04),
      topRight: Radius.circular(w * 0.04),
    );
    canvas.drawRRect(tower, fill);
    canvas.drawRRect(tower, stroke);

    for (var i = 0; i < 3; i++) {
      final y = h * (0.26 + i * 0.16);
      canvas.drawRect(
        Rect.fromLTWH(w * 0.35, y, w * 0.1, h * 0.08),
        stroke,
      );
      canvas.drawRect(
        Rect.fromLTWH(w * 0.55, y, w * 0.1, h * 0.08),
        stroke,
      );
    }

    canvas.drawRect(
      Rect.fromLTWH(w * 0.44, h * 0.74, w * 0.12, h * 0.11),
      stroke,
    );
  }

  void _drawLes(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final board = RRect.fromRectAndCorners(
      Rect.fromLTWH(w * 0.14, h * 0.2, w * 0.72, h * 0.46),
      topLeft: Radius.circular(w * 0.04),
      topRight: Radius.circular(w * 0.04),
      bottomLeft: Radius.circular(w * 0.04),
      bottomRight: Radius.circular(w * 0.04),
    );
    canvas.drawRRect(board, fill);
    canvas.drawRRect(board, stroke);

    canvas.drawLine(
      Offset(w * 0.26, h * 0.34),
      Offset(w * 0.6, h * 0.34),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.26, h * 0.46),
      Offset(w * 0.5, h * 0.46),
      stroke,
    );

    canvas.drawLine(
      Offset(w * 0.5, h * 0.8),
      Offset(w * 0.72, h * 0.62),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.5, h * 0.8),
      Offset(w * 0.46, h * 0.84),
      stroke,
    );
  }

  void _drawKampus(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final cap = Path()
      ..moveTo(w * 0.5, h * 0.18)
      ..lineTo(w * 0.88, h * 0.36)
      ..lineTo(w * 0.5, h * 0.54)
      ..lineTo(w * 0.12, h * 0.36)
      ..close();
    canvas.drawPath(cap, fill);
    canvas.drawPath(cap, stroke);

    canvas.drawLine(
      Offset(w * 0.3, h * 0.46),
      Offset(w * 0.3, h * 0.7),
      stroke,
    );
    canvas.drawLine(
      Offset(w * 0.7, h * 0.46),
      Offset(w * 0.7, h * 0.7),
      stroke,
    );
    final base = Path()
      ..moveTo(w * 0.3, h * 0.7)
      ..quadraticBezierTo(w * 0.5, h * 0.82, w * 0.7, h * 0.7);
    canvas.drawPath(base, stroke);

    canvas.drawLine(
      Offset(w * 0.88, h * 0.36),
      Offset(w * 0.88, h * 0.66),
      stroke,
    );
    canvas.drawCircle(Offset(w * 0.88, h * 0.7), w * 0.05, stroke);
  }

  void _drawGym(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    canvas.drawLine(
      Offset(w * 0.26, h * 0.5),
      Offset(w * 0.74, h * 0.5),
      stroke,
    );

    final left = Rect.fromLTWH(w * 0.14, h * 0.32, w * 0.08, h * 0.36);
    canvas.drawRect(left, fill);
    canvas.drawRect(left, stroke);
    final leftInner = Rect.fromLTWH(w * 0.24, h * 0.4, w * 0.06, h * 0.2);
    canvas.drawRect(leftInner, stroke);

    final right = Rect.fromLTWH(w * 0.78, h * 0.32, w * 0.08, h * 0.36);
    canvas.drawRect(right, fill);
    canvas.drawRect(right, stroke);
    final rightInner = Rect.fromLTWH(w * 0.7, h * 0.4, w * 0.06, h * 0.2);
    canvas.drawRect(rightInner, stroke);
  }

  void _drawLainnya(Canvas canvas, double w, double h, Paint stroke, Paint fill) {
    final pin = Path()
      ..addOval(Rect.fromCircle(center: Offset(w * 0.5, h * 0.38), radius: w * 0.24))
      ..moveTo(w * 0.34, h * 0.55)
      ..lineTo(w * 0.5, h * 0.86)
      ..lineTo(w * 0.66, h * 0.55)
      ..close();
    canvas.drawPath(pin, fill);
    canvas.drawPath(pin, stroke);
    canvas.drawCircle(Offset(w * 0.5, h * 0.38), w * 0.09, stroke);
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
