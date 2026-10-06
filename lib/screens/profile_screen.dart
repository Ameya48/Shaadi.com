// ============================================================
// profile_screen.dart - Stitch My Profile & Verification Center
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';
import '../widgets/verification_badge.dart';
import '../widgets/boost_banner.dart';
import '../widgets/app_image.dart';
import 'edit_profile_screen.dart';
import 'horoscope_matching_screen.dart';
import 'membership_screen.dart';
import 'privacy_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _openEditProfile({int tabIndex = 0}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(initialTabIndex: tabIndex),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final user = loggedInUserData;
    final completenessInt = user.completenessInt;
    final isFullyComplete = completenessInt >= 100;

    int verifiedCount = 0;
    if (user.isIdVerified) verifiedCount++;
    if (user.isPhotoVerified) verifiedCount++;
    if (user.isPhoneVerified) verifiedCount++;
    if (user.isHoroscopeVerified) verifiedCount++;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Profile & Settings',
          style: GoogleFonts.playfairDisplay(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Edit Profile Details',
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            onPressed: () => _openEditProfile(tabIndex: 0),
          ),
          IconButton(
            tooltip: 'Settings & Privacy',
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacySettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        child: Column(
          children: [
            // User Card Header
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.outline),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // User Avatar with Edit Badge (Tappable)
                      GestureDetector(
                        onTap: () => _openEditProfile(tabIndex: 0),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.goldGradient,
                              ),
                              child: CircleAvatar(
                                radius: 36,
                                backgroundImage: getAppImageProvider(currentUser.imagePath),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.edit_rounded, size: 13, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Name, Occupation, Location
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    user.name,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF3B82F6)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${user.age} yrs • ${user.jobTitle}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '${user.city}, ${user.state}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: AppColors.textMuted,
                              ),
                            ),
                            const SizedBox(height: 6),
                            if (user.isGold || user.isDiamond)
                              user.isDiamond ? VerificationBadge.diamondMember() : VerificationBadge.goldMember(),
                          ],
                        ),
                      ),

                      // Edit Profile Quick Action
                      InkWell(
                        onTap: () => _openEditProfile(tabIndex: 0),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.edit_rounded, size: 12, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(
                                'Edit',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.outline),
                  const SizedBox(height: 8),

                  // Completeness Meter Breakdown
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: isFullyComplete ? 1.0 : user.completenessPercentage,
                              backgroundColor: isFullyComplete ? AppColors.trustEmeraldLight : AppColors.secondaryLight,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isFullyComplete ? AppColors.trustEmerald : AppColors.secondary,
                              ),
                              strokeWidth: 4,
                            ),
                            if (isFullyComplete)
                              const Icon(Icons.check_rounded, size: 18, color: AppColors.trustEmerald)
                            else
                              Text(
                                '$completenessInt%',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.secondary,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Profile Completeness: $completenessInt%',
                                  style: GoogleFonts.plusJakartaSans(fontSize: 12.5, fontWeight: FontWeight.w700),
                                ),
                                if (isFullyComplete) ...[
                                  const SizedBox(width: 4),
                                  const Icon(Icons.stars_rounded, size: 14, color: AppColors.trustEmerald),
                                ],
                              ],
                            ),
                            Text(
                              isFullyComplete
                                  ? 'All details & verifications completed ✨'
                                  : user.completenessSuggestions.first,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: isFullyComplete ? AppColors.trustEmerald : AppColors.textSecondary,
                                fontWeight: isFullyComplete ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isFullyComplete)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.trustEmeraldLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.trustEmerald.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle_rounded, size: 13, color: AppColors.trustEmerald),
                              const SizedBox(width: 4),
                              Text(
                                'Complete',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.trustEmerald,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        TextButton(
                          onPressed: () => _openEditProfile(tabIndex: 0),
                          child: Text(
                            'Improve',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Profile Boost Banner
            const BoostBanner(),
            const SizedBox(height: 14),

            // Verification Badges Hub Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Verification & Trust Badges',
                        style: GoogleFonts.playfairDisplay(fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '$verifiedCount of 4 Verified',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.trustEmerald,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildVerificationRow(
                    icon: Icons.badge_outlined,
                    label: 'Government ID (Aadhaar / Passport)',
                    isVerified: user.isIdVerified,
                  ),
                  const Divider(height: 12, color: AppColors.outline),
                  _buildVerificationRow(
                    icon: Icons.face_rounded,
                    label: 'Selfie & Photo Verification',
                    isVerified: user.isPhotoVerified,
                  ),
                  const Divider(height: 12, color: AppColors.outline),
                  _buildVerificationRow(
                    icon: Icons.phone_android_rounded,
                    label: 'Mobile Number Verification',
                    isVerified: user.isPhoneVerified,
                  ),
                  const Divider(height: 12, color: AppColors.outline),
                  _buildVerificationRow(
                    icon: Icons.auto_awesome_rounded,
                    label: 'Kundali & Horoscope Verification',
                    isVerified: user.isHoroscopeVerified,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Quick Menu Links
            _buildMenuCard(
              icon: Icons.person_outline_rounded,
              title: 'Edit Profile & Bio',
              subtitle: 'Update name, bio, job, education, lifestyle & about me',
              iconColor: AppColors.primary,
              onTap: () => _openEditProfile(tabIndex: 0),
            ),
            const SizedBox(height: 10),

            _buildMenuCard(
              icon: Icons.tune_rounded,
              title: 'Edit Partner Preferences',
              subtitle: 'Update age, height, education & astrological criteria',
              iconColor: AppColors.secondary,
              onTap: () => _openEditProfile(tabIndex: 1),
            ),
            const SizedBox(height: 10),

            _buildMenuCard(
              icon: Icons.auto_awesome_rounded,
              title: 'My Kundali & Horoscope Chart',
              subtitle: 'Vedic planetary chart, Gunas & Ashtakoota details',
              iconColor: AppColors.secondary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HoroscopeMatchingScreen(profile: dummyProfiles[0]),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),

            _buildMenuCard(
              icon: Icons.workspace_premium_rounded,
              title: 'Shaadi Premium & Plans',
              subtitle: 'Gold (₹2,499/3m), Diamond (₹4,999/6m), Boost (₹99)',
              iconColor: AppColors.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MembershipScreen()),
                ).then((_) => setState(() {}));
              },
            ),
            const SizedBox(height: 10),

            _buildMenuCard(
              icon: Icons.security_rounded,
              title: 'Privacy & Safety Controls',
              subtitle: 'Photo blur, contact number masking, last seen visibility',
              iconColor: AppColors.trustEmerald,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivacySettingsScreen()),
                ).then((_) => setState(() {}));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationRow({
    required IconData icon,
    required String label,
    required bool isVerified,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: isVerified ? AppColors.trustEmerald : AppColors.textMuted),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: isVerified ? AppColors.trustEmeraldLight : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                isVerified ? Icons.check_circle_rounded : Icons.pending_outlined,
                size: 12,
                color: isVerified ? AppColors.trustEmerald : AppColors.textMuted,
              ),
              const SizedBox(width: 4),
              Text(
                isVerified ? 'Verified' : 'Pending',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isVerified ? AppColors.trustEmerald : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = AppColors.primary,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.outline),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
