import 'package:dev/core/constants/app_colors.dart';
import 'package:dev/features/home/domain/entities/store_name_selector.dart';
import 'package:flutter/material.dart';

class SheetSelectorMenu extends StatelessWidget {
  final List<String> sheets;
  final String selectedSheet;
  final void Function(String) onSheetSelected;

  const SheetSelectorMenu({
    super.key,
    required this.sheets,
    required this.selectedSheet,
    required this.onSheetSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagem de fundo
        Positioned.fill(
          child: Image.asset(
            'lib/assets/high_sea_bg.webp',
            fit: BoxFit.cover,
          ),
        ),
        // Conteúdo principal
        Container(

          color: Colors.transparent,
          // color: AppColors.beigeLight.withValues(alpha: 0.8), // Transparência
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: sheets.map((sheet) {
                final tabTitle = StoreNameSelector.find(sheet);
                final isSelected = sheet == selectedSheet;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(
                      tabTitle,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.beigeLight
                            : AppColors.beigeDark,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) => onSheetSelected(sheet),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.primaryLight,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
