import 'package:flutter/material.dart';

extension NameFormatter on String {
  String formatName() {
    try {
      final parts = split(' ');
      if (parts.length == 1) {
        return parts[0]; // Retorna o nome único
      } else if (parts.length == 2) {
        return '${parts[0]} ${parts[1][0]}.'; // Abrevia o segundo nome
      } else {
        final firstName = parts[0];
        final secondName = parts[1];
        final abbreviatedRest =
        parts.sublist(2).map((name) => '${name[0]}.').join(' ');
        return '$firstName $secondName $abbreviatedRest';
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Erro ao formatar nome';
    }
  }
}