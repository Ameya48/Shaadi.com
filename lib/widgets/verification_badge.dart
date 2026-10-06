// ============================================================
// verification_badge.dart - Reusable Trust & Status Badges
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class VerificationBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const VerificationBadge({
    super.key,
    required this.label,
    required this.icon,
    this.backgroundColor = AppColors.trustEmeraldLight,
    this.borderColor = AppColors.trustEmerald,
    this.textColor = AppColors.trustEmerald,
  });

  factory VerificationBadge.idVerified() {
    return const VerificationBadge(
      label: 'ID Verified',
      icon: Icons.verified_user_rounded,
      backgroundColor: AppColors.trustEmeraldLight,
      borderColor: AppColors.trustEmerald,
      textColor: AppColors.trustEmerald,
    );
  }

  factory VerificationBadge.photoVerified() {
    return const VerificationBadge(
      label: 'Photo Verified',
      icon: Icons.camera_alt_rounded,
      backgroundColor: Color(0xFFEFF6FF),
      borderColor: Color(0xFF3B82F6),
      textColor: Color(0xFF2563EB),
    );
  }

  factory VerificationBadge.horoscopeVerified({String text = '32/36 Guna Match'}) {
    return VerificationBadge(
      label: text,
      icon: Icons.auto_awesome_rounded,
      backgroundColor: const Color(0xFFF5F3FF),
      borderColor: AppColors.astrologyPurple,
      textColor: AppColors.astrologyPurple,
    );
  }

  factory VerificationBadge.goldMember() {
    return const VerificationBadge(
      label: 'GOLD MEMBER',
      icon: Icons.workspace_premium_rounded,
      backgroundColor: AppColors.secondaryLight,
      borderColor: AppColors.secondary,
      textColor: AppColors.secondary,
    );
  }

  factory VerificationBadge.diamondMember() {
    return const VerificationBadge(
      label: 'DIAMOND VIP',
      icon: Icons.diamond_rounded,
      backgroundColor: Color(0xFFEDE9FE),
      borderColor: Color(0xFF7C3AED),
      textColor: Color(0xFF6D28D9),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
