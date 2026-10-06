// ============================================================
// profile_completeness_card.dart - Profile Completeness Banner
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';
import '../screens/edit_profile_screen.dart';

class ProfileCompletenessCard extends StatelessWidget {
  final VoidCallback? onCompleteTap;

  const ProfileCompletenessCard({super.key, this.onCompleteTap});

  @override
  Widget build(BuildContext context) {
    final completeness = loggedInUserData.completenessPercentage;
    final completenessInt = loggedInUserData.completenessInt;
    final suggestions = loggedInUserData.completenessSuggestions;

    final isFullyComplete = completenessInt >= 100;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isFullyComplete ? AppColors.trustEmerald.withValues(alpha: 0.3) : AppColors.secondary.withValues(alpha: 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isFullyComplete ? AppColors.trustEmerald : AppColors.secondary).withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular Progress Indicator
          SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: isFullyComplete ? 1.0 : completeness,
                  backgroundColor: isFullyComplete ? AppColors.trustEmeraldLight : AppColors.secondaryLight,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isFullyComplete ? AppColors.trustEmerald : AppColors.secondary,
                  ),
                  strokeWidth: 4.5,
                  strokeCap: StrokeCap.round,
                ),
                if (isFullyComplete)
                  const Icon(Icons.check_rounded, size: 20, color: AppColors.trustEmerald)
                else
                  Text(
                    '$completenessInt%',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Information & CTA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Your Profile is $completenessInt% Complete',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      isFullyComplete ? Icons.stars_rounded : Icons.auto_awesome_rounded,
                      size: 15,
                      color: isFullyComplete ? AppColors.trustEmerald : AppColors.secondary,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  isFullyComplete
                      ? 'Great job! Your profile has maximum visibility.'
                      : (suggestions.isNotEmpty ? '${suggestions.first} to get 3x more interests!' : 'Profile complete!'),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: isFullyComplete ? AppColors.trustEmerald : AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Action Link
          InkWell(
            onTap: onCompleteTap ??
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(initialTabIndex: 0),
                    ),
                  );
                },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                children: [
                  Text(
                    isFullyComplete ? 'Edit' : 'Complete',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isFullyComplete ? AppColors.trustEmerald : AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 10,
                    color: isFullyComplete ? AppColors.trustEmerald : AppColors.primary,
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
