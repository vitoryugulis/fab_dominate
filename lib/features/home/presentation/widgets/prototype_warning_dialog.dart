import 'package:dev/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PrototypeWarningDialog extends StatelessWidget {
  const PrototypeWarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400, // Largura máxima fixa
          maxHeight: 300, // Altura máxima fixa
        ),
        decoration: BoxDecoration(
          color: AppColors.beigeDark, // Cor de fundo adicionada
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Aviso',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
              const SizedBox(height: 16),
              Text(
                'Este site é um protótipo e está em construção. Algumas funcionalidades podem não estar completas.',
                textAlign: TextAlign.left,
                style: TextStyle(color: AppColors.primary),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, // Cor de fundo do botão
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Entendido',
                    style: TextStyle(color: AppColors.beigeLight), // Cor do texto
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
