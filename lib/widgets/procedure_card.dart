import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../config/app_constants.dart';

class ProcedureCard extends StatelessWidget {
  final List<String> procedure;

  const ProcedureCard({
    super.key,
    required this.procedure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.marginMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.procedureHeader,
            style: AppTheme.headingMedium,
          ),
          const SizedBox(height: AppTheme.paddingSmall),
          ...List.generate(
            procedure.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.paddingSmall),
                  Expanded(
                    child: Text(
                      procedure[index],
                      style: AppTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}