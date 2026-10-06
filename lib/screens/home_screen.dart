// ============================================================
// home_screen.dart - Stitch Shaadi Discovery Feed (Light Theme)
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/profile_model.dart';
import '../data/dummy_data.dart';
import '../widgets/verification_badge.dart';
import '../widgets/boost_banner.dart';
import '../widgets/app_image.dart';
import 'profile_detail_screen.dart';
import 'horoscope_matching_screen.dart';
import 'search_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentProfileIndex = 0;
  int _currentPhotoIndex = 0;

  ProfileModel get currentProfile {
    if (dummyProfiles.isEmpty) return currentUser;
    return dummyProfiles[_currentProfileIndex % dummyProfiles.length];
  }

  void _nextProfile() {
    setState(() {
      _currentProfileIndex = (_currentProfileIndex + 1) % dummyProfiles.length;
      _currentPhotoIndex = 0;
    });
  }

  void _handlePass() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Passed on ${currentProfile.name}. Showing next match.'),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
      ),
    );
    _nextProfile();
  }

  void _handleShortlist() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.star_rounded, color: AppColors.secondary, size: 20),
            const SizedBox(width: 8),
            Text('${currentProfile.name} shortlisted! ⭐'),
          ],
        ),
        duration: const Duration(milliseconds: 1800),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleSendInterest() {
    final profile = currentProfile;
    setState(() {
      connectWithProfile(profile);
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.trustEmeraldLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.celebration_rounded, color: AppColors.trustEmerald, size: 30),
            ),
            const SizedBox(height: 14),
            Text(
              '🎉 Connected with ${profile.name}!',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Mutual connection established! You can now start 1-on-1 direct messaging and share compatibility thoughts.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _nextProfile();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      side: const BorderSide(color: AppColors.outline),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Next Match'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(selectedProfile: profile),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_rounded, size: 16),
                    label: Text('Chat Now →', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = currentProfile;
    final photos = profile.galleryImages.isNotEmpty ? profile.galleryImages : [profile.imagePath];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'shaadi',
              style: GoogleFonts.playfairDisplay(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        actions: [
          const BoostBanner(compact: true),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: Stack(
              children: [
                const Icon(Icons.tune_rounded, color: AppColors.textPrimary),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('3 new matches and 2 invitations received today!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main Featured Match Card (Tinder / Bumble meets Shaadi)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.outline, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo Carousel Section
                  Stack(
                    children: [
                      // Candidate Hero Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        child: SizedBox(
                          height: 420,
                          width: double.infinity,
                          child: AppImage(
                            imagePath: photos[_currentPhotoIndex % photos.length],
                            fit: BoxFit.cover,
                            alignment: const Alignment(0.0, -0.4),
                          ),
                        ),
                      ),

                      // Dark Gradient Overlay at Bottom of Photo
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            gradient: AppColors.heroOverlayGradient,
                          ),
                        ),
                      ),

                      // Top Row Badges on Photo
                      Positioned(
                        top: 14,
                        left: 14,
                        right: 14,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (profile.isGold) VerificationBadge.goldMember(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: AppColors.trustEmerald,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    profile.lastSeen,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Carousel Dots Indicator
                      if (photos.length > 1)
                        Positioned(
                          top: 50,
                          left: 14,
                          right: 14,
                          child: Row(
                            children: List.generate(
                              photos.length,
                              (index) => Expanded(
                                child: Container(
                                  height: 3,
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    color: _currentPhotoIndex == index
                                        ? Colors.white
                                        : Colors.white.withValues(alpha: 0.35),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Photo Tap Target for Next Photo
                      Positioned.fill(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  if (_currentPhotoIndex > 0) {
                                    setState(() => _currentPhotoIndex--);
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  if (_currentPhotoIndex < photos.length - 1) {
                                    setState(() => _currentPhotoIndex++);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Candidate Name & Profession (Overlaid at bottom of image)
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${profile.name}, ${profile.age}',
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.verified_rounded, color: Color(0xFF60A5FA), size: 20),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${profile.occupation} at ${profile.company} • ${profile.city}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Candidate Details & Badges Body
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Verification Badges Row
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            VerificationBadge.idVerified(),
                            VerificationBadge.photoVerified(),
                            VerificationBadge.horoscopeVerified(
                              text: '${profile.horoscope.totalGunas}/36 Guna Match',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Specs Grid Pills
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildSpecPill(Icons.straighten_rounded, profile.height),
                            _buildSpecPill(Icons.school_outlined, profile.education),
                            _buildSpecPill(Icons.temple_hindu_outlined, '${profile.caste} • ${profile.maritalStatus}'),
                            _buildSpecPill(Icons.currency_rupee_rounded, profile.income),
                            _buildSpecPill(Icons.location_on_outlined, '${profile.city}, ${profile.state}'),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // About Me Bio
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.outline),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.format_quote_rounded, size: 20, color: AppColors.secondary),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  profile.about,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    height: 1.45,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Astrological Kundali Milan Mini-Card
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HoroscopeMatchingScreen(profile: profile),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: AppColors.kundaliGradient,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.secondary.withValues(alpha: 0.15),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Icons.auto_awesome_rounded, color: AppColors.secondary, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '89% Kundali Compatibility (${profile.horoscope.totalGunas}/36 Gunas)',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF78350F),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Nadi: 8/8 • Bhakoot: 7/7 • Both Non-Manglik',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 11,
                                          color: const Color(0xFF92400E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded, size: 13, color: AppColors.secondary),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Mutual Interests Tags
                        Text(
                          'Common Matches & Mutual Interests',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: profile.interests.map((interest) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                interest,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),

                        // View Full Profile Button
                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileDetailScreen(profile: profile),
                                ),
                              );
                            },
                            icon: const Icon(Icons.visibility_outlined, size: 16, color: AppColors.primary),
                            label: Text(
                              'View Complete Matrimony Profile & Family Bio →',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 3. Floating Action Buttons Bar (Pass, Shortlist, Super Chat, Connect)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Pass Button
                  _buildCircleActionButton(
                    icon: Icons.close_rounded,
                    color: const Color(0xFF64748B),
                    backgroundColor: Colors.white,
                    borderColor: const Color(0xFFE2E8F0),
                    size: 52,
                    onTap: _handlePass,
                  ),

                  // Shortlist Button
                  _buildCircleActionButton(
                    icon: Icons.star_rounded,
                    color: AppColors.secondary,
                    backgroundColor: AppColors.secondaryLight,
                    borderColor: AppColors.secondary.withValues(alpha: 0.3),
                    size: 52,
                    onTap: _handleShortlist,
                  ),

                  // 3rd action button: Super Chat (if connected) or Kundali Milan (if not connected)
                  _buildCircleActionButton(
                    icon: isConnectedWithProfile(profile)
                        ? Icons.chat_bubble_rounded
                        : Icons.auto_awesome_rounded,
                    color: isConnectedWithProfile(profile)
                        ? AppColors.trustEmerald
                        : AppColors.astrologyPurple,
                    backgroundColor: isConnectedWithProfile(profile)
                        ? AppColors.trustEmeraldLight
                        : AppColors.astrologyPurpleLight,
                    borderColor: (isConnectedWithProfile(profile)
                            ? AppColors.trustEmerald
                            : AppColors.astrologyPurple)
                        .withValues(alpha: 0.3),
                    size: 52,
                    onTap: () {
                      if (isConnectedWithProfile(profile)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(selectedProfile: profile),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HoroscopeMatchingScreen(profile: profile),
                          ),
                        );
                      }
                    },
                  ),

                  // Send Interest / Chat (Primary Button)
                  ElevatedButton.icon(
                    onPressed: isConnectedWithProfile(profile)
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(selectedProfile: profile),
                              ),
                            );
                          }
                        : _handleSendInterest,
                    icon: Icon(
                      isConnectedWithProfile(profile)
                          ? Icons.chat_rounded
                          : (getConnectionStatus(profile) == 'Pending'
                              ? Icons.hourglass_top_rounded
                              : Icons.favorite_rounded),
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      isConnectedWithProfile(profile)
                          ? 'Chat Now'
                          : (getConnectionStatus(profile) == 'Pending' ? 'Pending' : 'Connect'),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isConnectedWithProfile(profile)
                          ? AppColors.trustEmerald
                          : (getConnectionStatus(profile) == 'Pending'
                              ? AppColors.secondary
                              : AppColors.primary),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      elevation: 4,
                      shadowColor: (isConnectedWithProfile(profile)
                              ? AppColors.trustEmerald
                              : AppColors.primary)
                          .withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 5),
          Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleActionButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    required Color borderColor,
    required double size,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size * 0.48),
      ),
    );
  }
}
