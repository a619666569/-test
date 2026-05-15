dart
▎  import 'dart:io'; 
▎  import 'dart:math'; 
▎  import 'package:image/image.dart' as img; 
▎  import '../models/durian_result.dart'; 
▎   
▎  class DurianAnalyzer { 
▎    static Future<DurianResult> analyze(File imageFile) async { 
▎      final image = img.decodeImage(await imageFile.readAsBytes()); 
▎      if (image == null) { 
▎        throw Exception('无法读取图片，请换一张试试'); 
▎      } 
▎   
▎      final cropped = _cropCenter(image); 
▎      final shapeScore = _analyzeShape(cropped); 
▎      final colorScore = _analyzeColor(cropped); 
▎      final textureScore = _analyzeTexture(cropped); 
▎   
▎      return DurianResult( 
▎        shapeScore: shapeScore, 
▎        colorScore: colorScore, 
▎        textureScore: textureScore, 
▎      ); 
▎    } 
▎   
▎    static img.Image _cropCenter(img.Image image) { 
▎      final size = min(image.width, image.height); 
▎      final startX = (image.width - size) ~/ 2; 
▎      final startY = (image.height - size) ~/ 2; 
▎      final cropSize = (size * 0.7).toInt(); 
▎      final offset = ((1 - 0.7) * size / 2).toInt(); 
▎      return img.copyCrop( 
▎        image, 
▎        x: startX + offset, 
▎        y: startY + offset, 
▎        width: cropSize, 
▎        height: cropSize, 
▎      ); 
▎    } 
▎   
▎    static double _analyzeShape(img.Image image) { 
▎      final edges = img.sobel(image); 
▎      int edgeCount = 0; 
▎      int total = 0; 
▎   
▎      for (int y = 0; y < edges.height; y += 2) { 
▎        for (int x = 0; x < edges.width; x += 2) { 
▎          final p = edges.getPixel(x, y); 
▎          final gray = (p.r + p.g + p.b) / 3; 
▎          if (gray > 100) edgeCount++; 
▎          total++; 
▎        } 
▎      } 
▎   
▎      final edgeRatio = edgeCount / total; 
▎      double score = 35 * (1.0 - edgeRatio * 1.5); 
▎      return score.clamp(5, 35); 
▎    } 
▎   
▎    static double _analyzeColor(img.Image image) { 
▎      double hueSum = 0; 
▎      double satSum = 0; 
▎      int pixelCount = 0; 
▎   
▎      for (int y = 0; y < image.height; y += 4) { 
▎        for (int x = 0; x < image.width; x += 4) { 
▎          final p = image.getPixel(x, y); 
▎          final r = p.r / 255.0; 
▎          final g = p.g / 255.0; 
▎          final b = p.b / 255.0; 
▎   
        final maxC = [r, g, b].reduce(max); 
▎          final minC = [r, g, b].reduce(min); 
▎          final delta = maxC - minC; 
▎   
▎          double hue = 0; 
▎          if (delta > 0.01) { 
▎            if (maxC == r) { 
▎              hue = 60 * (((g - b) / delta) % 6); 
▎            } else if (maxC == g) { 
▎              hue = 60 * (((b - r) / delta) + 2); 
▎            } else { 
▎              hue = 60 * (((r - g) / delta) + 4); 
▎            } 
▎          } 
▎          if (hue < 0) hue += 360; 
▎   
▎          final sat = maxC > 0 ? delta / maxC : 0; 
▎          hueSum += hue; 
▎          satSum += sat; 
▎          pixelCount++; 
▎        } 
▎      } 
▎   
▎      final avgHue = hueSum / pixelCount; 
▎      final avgSat = satSum / pixelCount; 
▎   
▎      if (avgHue >= 30 && avgHue <= 55) { 
▎        if (avgSat > 0.3) return 40; 
▎        return 32; 
▎      } else if (avgHue >= 55 && avgHue <= 80) { 
▎        return 28; 
▎      } else if (avgHue >= 80 && avgHue <= 140) { 
▎        return 15; 
▎      } else if (avgHue >= 15 && avgHue < 30) { 
▎        return 30; 
▎      } else if (avgHue >= 0 && avgHue < 15 || avgHue > 300) { 
▎        return 10; 
▎      } else { 
▎        return 20; 
▎      } 
▎    } 
▎   
▎    static double _analyzeTexture(img.Image image) { 
▎      final gray = img.grayscale(image); 
▎      double totalVar = 0; 
▎      int count = 0; 
▎   
▎      for (int y = 2; y < gray.height - 2; y += 3) { 
▎        for (int x = 2; x < gray.width - 2; x += 3) { 
▎          double sum = 0; 
▎          for (int dy = -2; dy <= 2; dy++) { 
▎            for (int dx = -2; dx <= 2; dx++) { 
▎              sum += gray.getPixel(x + dx, y + dy).r; 
▎            } 
▎          } 
▎          final mean = sum / 25; 
▎          final center = gray.getPixel(x, y).r; 
▎          totalVar += (center - mean).abs(); 
▎          count++; 
   } 
▎      } 
▎   
▎      final avgVar = totalVar / count; 
▎   
▎      if (avgVar > 35) return 25; 
▎      if (avgVar > 25) return 20; 
▎      if (avgVar > 15) return 14; 
▎      if (avgVar > 8) return 8; 
▎      return 4; 
▎    } 
▎  } 
▎
