// ============================================================
// membership_screen.dart - Stitch Premium Pricing & Boost
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  void _upgradeTier(String tier, int price) {
    setState(() {
      if (tier == 'Gold') {
        loggedInUserData.isGold = true;
        loggedInUserData.isDiamond = false;
      } else if (tier == 'Diamond') {
        loggedInUserData.isDiamond = true;
        loggedInUserData.isGold = true;
      } else if (tier == 'Boost') {
        loggedInUserData.isBoosted = true;
      }
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.trustEmerald, size: 28),
            const SizedBox(width: 8),
            Text(
              'Payment Successful!',
              style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        content: Text(
          'Congratulations! You are now subscribed to $tier Plan (₹$price). Enjoy unlimited messaging, verified contacts, and VIP matching privileges!',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.4),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Start Connecting'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              'Shaadi Premium',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.workspace_premium_rounded, color: AppColors.secondary, size: 20),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchases restored.')),
              );
            },
            child: Text(
              'Restore',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Your Perfect Life Partner 3x Faster',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF78350F),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Over 500,000+ verified matrimony matches connected this year.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: const Color(0xFF92400E),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _buildTrustPill('🛡️ 100% Verified'),
                      const SizedBox(width: 6),
                      _buildTrustPill('💬 Direct Chat'),
                      const SizedBox(width: 6),
                      _buildTrustPill('🔒 Privacy Shield'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Profile Boost Card (Low Ticket Daily Add-on)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.secondary.withValues(alpha: 0.5), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.rocket_launch_rounded, color: AppColors.secondary, size: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Profile Boost',
                              style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text('₹99 / Day', style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.secondary)),
                            ),
                          ],
                        ),
                        Text(
                          'Get 5x profile views & top search placement for 24 hours!',
                          style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _upgradeTier('Boost', 99),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    child: const Text('Boost ₹99'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tier 1: Gold Membership Card (₹2,499 / 3 months)
            _buildMembershipCard(
              title: 'Gold Membership',
              duration: '3 MONTHS',
              price: '₹2,499',
              pricePerMonth: 'approx ₹833 / month',
              badge: '🌟 MOST POPULAR',
              badgeColor: AppColors.secondary,
              isFeatured: true,
              features: [
                'Unlimited Direct Chat & Messaging',
                'Highlighted Gold Member Profile Badge',
                'View up to 50 Verified Contact Numbers',
                'Full 36 Guna Kundali Milan Reports',
                'Privacy Controls: Photo Blur & Contact Shield',
              ],
              buttonText: 'Upgrade to Gold (₹2,499)',
              buttonColor: AppColors.primary,
              onTap: () => _upgradeTier('Gold', 2499),
            ),
            const SizedBox(height: 16),

            // Tier 2: Diamond Membership Card (₹4,999 / 6 months)
            _buildMembershipCard(
              title: 'Diamond Membership',
              duration: '6 MONTHS',
              price: '₹4,999',
              pricePerMonth: 'approx ₹833 / month',
              badge: '👑 VIP CONCIERGE',
              badgeColor: const Color(0xFF7C3AED),
              isFeatured: false,
              features: [
                'Everything in Gold Membership',
                'Dedicated Relationship Advisor & Priority Concierge',
                'Unlimited Contact Number & Horoscope Access',
                'Profile Highlighted at Top of All Search Results (3 Free Boosts)',
                'See Who Viewed & Shortlisted Your Profile',
                'Read Receipts & Last Seen Status Tracking',
              ],
              buttonText: 'Upgrade to Diamond (₹4,999)',
              buttonColor: const Color(0xFF7C3AED),
              onTap: () => _upgradeTier('Diamond', 4999),
            ),
            const SizedBox(height: 16),

            // Tier 3: Free Plan Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Plan: Free Member', style: GoogleFonts.playfairDisplay(fontSize: 15, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(
                    'Basic browsing & limited interests (up to 5/day). No direct chat or verified phone unlock.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Social Proof Testimonial
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
                  const Row(
                    children: [
                      Icon(Icons.star_rounded, color: AppColors.secondary, size: 18),
                      Icon(Icons.star_rounded, color: AppColors.secondary, size: 18),
                      Icon(Icons.star_rounded, color: AppColors.secondary, size: 18),
                      Icon(Icons.star_rounded, color: AppColors.secondary, size: 18),
                      Icon(Icons.star_rounded, color: AppColors.secondary, size: 18),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '"We found each other through Shaadi Gold in just 2 months! The verified contacts and horoscope matching made family conversations effortless."',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '— Siddharth & Meera Kapoor, Married Feb 2024 (Mumbai)',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Bank Grade Security Footer
            Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock_rounded, size: 14, color: AppColors.trustEmerald),
                      const SizedBox(width: 6),
                      Text(
                        '256-Bit Bank-Grade Secure Payment',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'UPI (GPay, PhonePe, Paytm), Cards, NetBanking, No-Cost EMI',
                    style: GoogleFonts.plusJakartaSans(fontSize: 10.5, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF78350F)),
      ),
    );
  }

  Widget _buildMembershipCard({
    required String title,
    required String duration,
    required String price,
    required String pricePerMonth,
    required String badge,
    required Color badgeColor,
    required bool isFeatured,
    required List<String> features,
    required String buttonText,
    required Color buttonColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isFeatured ? AppColors.primary : AppColors.outline,
          width: isFeatured ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isFeatured ? AppColors.primary.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  badge,
                  style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w800, color: badgeColor),
                ),
                Text(
                  duration,
                  style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700)),
                        Text(pricePerMonth, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                    Text(
                      price,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.outline),
                const SizedBox(height: 10),

                // Features list
                ...features.map((feat) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.trustEmerald),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feat,
                            style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 18),

                // Upgrade Button
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    buttonText,
                    style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
