 dart
▎  class DurianResult { 
▎    final double shapeScore; 
▎    final double colorScore; 
▎    final double textureScore; 
▎   
▎    DurianResult({ 
▎      required this.shapeScore, 
▎      required this.colorScore, 
▎      required this.textureScore, 
▎    }); 
▎   
▎    double get totalScore => shapeScore + colorScore + textureScore; 
▎   
▎    String get grade { 
▎      if (totalScore >= 85) return '极品 👑'; 
▎      if (totalScore >= 70) return '好榴莲 🔥'; 
▎      if (totalScore >= 50) return '还行 👍'; 
▎      return '不推荐 ⭐'; 
▎    } 
▎   
▎    String get advice { 
▎      if (totalScore >= 85) return '非常棒的榴莲！果肉饱满香甜，赶紧买！🍈✨'; 
▎      if (totalScore >= 70) return '品质不错，可以下手！价格合适就别犹豫🔥'; 
▎      if (totalScore >= 50) return '马马虎虎，如果价格便宜可以试试～'; 
▎      return '不太建议买，再挑挑别的吧😅'; 
▎    } 
▎   
▎    String get emoji { 
▎      if (totalScore >= 85) return '👑'; 
▎      if (totalScore >= 70) return '🔥'; 
▎      if (totalScore >= 50) return '👍'; 
▎      return '⭐'; 
▎    } 
▎   
▎    String get detailText { 
▎      return '形状评分：${shapeScore.toStringAsFixed(1)}/35\n' 
▎          '色泽评分：${colorScore.toStringAsFixed(1)}/40\n' 
▎          '纹理评分：${textureScore.toStringAsFixed(1)}/25'; 
▎    } 
▎  } 
