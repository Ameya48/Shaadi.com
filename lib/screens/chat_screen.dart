// ============================================================
// chat_screen.dart - Stitch Matrimony Chat & Privacy Controls
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/profile_model.dart';
import '../data/dummy_data.dart';
import '../widgets/app_image.dart';
import 'horoscope_matching_screen.dart';
import 'privacy_settings_screen.dart';
import 'profile_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  final ProfileModel? selectedProfile;

  const ChatScreen({super.key, this.selectedProfile});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ProfileModel? _activeChatProfile;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final List<ChatMessageItem> _chatMessages = [];
  bool _isViewingInbox = false;
  String _searchQuery = '';

  final List<String> _icebreakers = [
    '🏡 Tell me about your family',
    '☕ What\'s your ideal Sunday look like?',
    '📜 Share Kundali with parents',
    '📞 Schedule a 10-min intro call',
    '✈️ Favorite travel destination',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.selectedProfile != null) {
      _activeChatProfile = widget.selectedProfile;
      _isViewingInbox = false;
    } else {
      // Find the first connected profile if available, else show inbox
      final connectedConvs = dummyConversations.where((c) => isConnectedWithProfile(c.profile)).toList();
      if (connectedConvs.isNotEmpty) {
        _activeChatProfile = connectedConvs.first.profile;
        _isViewingInbox = false;
      } else {
        _activeChatProfile = dummyProfiles[2];
        _isViewingInbox = true;
      }
    }

    _loadMessages();
  }

  void _loadMessages() {
    _chatMessages.clear();
    if (_activeChatProfile == null) return;
    final conv = dummyConversations.firstWhere(
      (c) => c.profile.id == _activeChatProfile!.id,
      orElse: () => dummyConversations[0],
    );
    _chatMessages.addAll(conv.messages);
  }

  void _openConversation(ProfileModel profile) {
    setState(() {
      _activeChatProfile = profile;
      _isViewingInbox = false;
      _loadMessages();
    });
  }

  void _sendMessage([String? customText]) {
    final text = customText ?? _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _chatMessages.add(
        ChatMessageItem(
          text: text,
          isUser: true,
          time: 'Just now',
        ),
      );
      if (customText == null) {
        _textController.clear();
      }
    });

    // Auto simulated response after 1.5s
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _chatMessages.add(
            ChatMessageItem(
              text: 'Thanks for connecting! We value open communication and strong cultural traditions. Let me know if you would like to connect on an audio call!',
              isUser: false,
              time: 'Just now',
            ),
          );
        });
      }
    });
  }

  String _contactRequestStatus = 'none'; // 'none', 'pending', 'granted'
  String _selectedReason = '👨‍👩‍👧‍👦 Family wants to connect directly';

  void _showUnlockContactModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  color: AppColors.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Shield Icon with Emerald Badge
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.trustEmerald.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shield_rounded, color: AppColors.trustEmerald, size: 36),
              ),
              const SizedBox(height: 14),

              // Title
              Text(
                'Request Contact Permission',
                style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),

              // Subtitle
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.trustEmerald.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_rounded, size: 12, color: AppColors.trustEmerald),
                    const SizedBox(width: 4),
                    Text(
                      '100% Privacy Protected • Mutual Consent Required',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.trustEmerald,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Explanation of privacy rule
              Text(
                'To protect member privacy, contact numbers are strictly confidential and NEVER sold or unlocked for money.\n\n${_activeChatProfile!.name}\'s phone number (+91 98•••• ••21) will be shared only when she personally reviews and approves your request.',
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5,
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),

              // Reason Selector Header
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Request Purpose:',
                  style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 8),

              // Reasons
              ...[
                '👨‍👩‍👧‍👦 Family wants to connect directly',
                '📜 Sharing official horoscope / Kundali',
                '📞 Planning a phone conversation',
              ].map((reason) {
                final isSelected = _selectedReason == reason;
                return InkWell(
                  onTap: () {
                    setModalState(() {
                      _selectedReason = reason;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF3B82F6) : AppColors.outline,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                          size: 18,
                          color: isSelected ? const Color(0xFF3B82F6) : AppColors.textMuted,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            reason,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? const Color(0xFF1E40AF) : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(modalContext),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.outline),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _contactRequestStatus = 'pending';
                        });
                        Navigator.pop(modalContext);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Contact request sent to ${_activeChatProfile!.name} for approval!',
                                    style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: AppColors.trustEmerald,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );

                        final messenger = ScaffoldMessenger.of(context);
                        // Auto simulate candidate granting consent after 3 seconds for demonstration
                        Future.delayed(const Duration(seconds: 3), () {
                          if (mounted) {
                            setState(() {
                              _contactRequestStatus = 'granted';
                            });
                            messenger.showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        '🎉 ${_activeChatProfile!.name} approved your contact request! Direct number unlocked.',
                                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                backgroundColor: AppColors.trustEmerald,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                duration: const Duration(seconds: 4),
                              ),
                            );
                          }
                        });
                      },
                      icon: const Icon(Icons.send_rounded, size: 16),
                      label: Text(
                        'Send Request',
                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 13.5),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isViewingInbox || _activeChatProfile == null) {
      return _buildInboxView();
    }

    final isConnected = isConnectedWithProfile(_activeChatProfile!);
    if (!isConnected) {
      return _buildLockedChatView(_activeChatProfile!);
    }

    return _buildActiveChatView();
  }

  // ============================================================
  // 1. INBOX LIST VIEW
  // ============================================================
  Widget _buildInboxView() {
    final filteredConversations = dummyConversations.where((c) {
      if (_searchQuery.isEmpty) return true;
      return c.profile.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.profile.city.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Messages',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.trustEmerald.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.trustEmerald.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shield_rounded, size: 14, color: AppColors.trustEmerald),
                const SizedBox(width: 4),
                Text(
                  'Privacy Shield Active',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.trustEmerald,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Trust & Policy Notice
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user_rounded, color: AppColors.trustEmerald, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '🔒 Chatting is enabled with mutually connected profiles for safety & verified intent.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        color: const Color(0xFF166534),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              color: Colors.white,
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search conversations by name or city...',
                  hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textMuted),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          // Active Matches Horizontal Story Bar
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Matches',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dummyProfiles.length,
                      itemBuilder: (context, index) {
                        final p = dummyProfiles[index];
                        final isConnected = isConnectedWithProfile(p);

                        return GestureDetector(
                          onTap: () => _openConversation(p),
                          child: Container(
                            margin: const EdgeInsets.only(right: 14),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(2.5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isConnected
                                              ? AppColors.trustEmerald
                                              : (p.isPremium ? AppColors.primary : AppColors.outline),
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 24,
                                        backgroundImage: getAppImageProvider(p.imagePath),
                                      ),
                                    ),
                                    Positioned(
                                      right: 2,
                                      bottom: 2,
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: isConnected ? AppColors.trustEmerald : AppColors.secondary,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        child: Icon(
                                          isConnected ? Icons.check : Icons.lock,
                                          size: 7,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  width: 58,
                                  child: Text(
                                    p.name.split(' ')[0],
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          // Conversations List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final conv = filteredConversations[index];
                final p = conv.profile;
                final isConnected = isConnectedWithProfile(p);

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isConnected
                          ? AppColors.outline.withValues(alpha: 0.6)
                          : AppColors.secondary.withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    onTap: () => _openConversation(p),
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: getAppImageProvider(p.imagePath),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: isConnected ? AppColors.trustEmerald : AppColors.secondary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                            child: Icon(
                              isConnected ? Icons.chat_bubble_rounded : Icons.lock_rounded,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Row(
                      children: [
                        Flexible(
                          child: Text(
                            p.name,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (p.isVerified)
                          const Icon(Icons.verified_rounded, size: 14, color: Color(0xFF3B82F6)),
                        const Spacer(),
                        if (isConnected)
                          Text(
                            conv.time,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: conv.unreadCount > 0 ? AppColors.primary : AppColors.textMuted,
                              fontWeight: conv.unreadCount > 0 ? FontWeight.w700 : FontWeight.w500,
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Connect to Chat',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF92400E),
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryLight,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${p.horoscope.totalGunas}/36 Milan',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF92400E),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${p.age} yrs • ${p.city}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                isConnected
                                    ? conv.lastMessage
                                    : '🔒 Mutual connection required to start messaging.',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: isConnected
                                      ? (conv.unreadCount > 0 ? AppColors.textPrimary : AppColors.textSecondary)
                                      : AppColors.textMuted,
                                  fontWeight: conv.unreadCount > 0 ? FontWeight.w700 : FontWeight.w400,
                                  fontStyle: isConnected ? FontStyle.normal : FontStyle.italic,
                                ),
                              ),
                            ),
                            if (isConnected && conv.unreadCount > 0)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${conv.unreadCount}',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: filteredConversations.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  // ============================================================
  // 2. LOCKED CHAT & CONNECTION REQUIREMENT VIEW
  // ============================================================
  Widget _buildLockedChatView(ProfileModel profile) {
    final connStatus = getConnectionStatus(profile);
    final isPending = connStatus == 'Pending';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              setState(() {
                _isViewingInbox = true;
              });
            }
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: getAppImageProvider(profile.imagePath),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          profile.name,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified_rounded, size: 14, color: Color(0xFF3B82F6)),
                    ],
                  ),
                  Text(
                    '🔒 Connection Required',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, color: AppColors.textSecondary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileDetailScreen(profile: profile)),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Profile Avatar with Locked Badge
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.goldGradient,
                  ),
                  child: CircleAvatar(
                    radius: 54,
                    backgroundImage: getAppImageProvider(profile.imagePath),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isPending ? AppColors.secondary : AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                    child: Icon(
                      isPending ? Icons.hourglass_top_rounded : Icons.lock_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title & Subtitle
            Text(
              'Connect with ${profile.name} to Chat',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              '${profile.age} yrs • ${profile.occupation} • ${profile.city}',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 14),

            // Horoscope Match Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondaryLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_awesome_rounded, size: 15, color: AppColors.secondary),
                  const SizedBox(width: 6),
                  Text(
                    '✨ ${profile.horoscope.totalGunas}/36 Kundali Milan (${profile.horoscope.gunaVerdict})',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF78350F),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Matrimony Privacy Guarantee Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.outline),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.trustEmeraldLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.shield_rounded, color: AppColors.trustEmerald, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Mutual Connection Policy',
                          style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'To protect member privacy, prevent spam, and foster genuine matrimony relationships, direct 1-on-1 chatting unlocks once both candidates accept connection.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      color: AppColors.textSecondary,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Current Status Box & Dynamic CTAs
            if (isPending) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.hourglass_top_rounded, color: Color(0xFFD97706), size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Connection Request Sent (Pending)',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF92400E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'You have expressed interest in ${profile.name}. Chatting will unlock automatically as soon as she accepts!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFF78350F),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Instant Connect Simulation Button (Demo)
              ElevatedButton.icon(
                onPressed: () {
                  connectWithProfile(profile);
                  setState(() {
                    _loadMessages();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.celebration_rounded, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text('🎉 Connected with ${profile.name}! Chat unlocked.'),
                        ],
                      ),
                      backgroundColor: AppColors.trustEmerald,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.bolt_rounded, size: 18),
                label: const Text('Accept Connection & Unlock Chat Now ⚡'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.trustEmerald,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  minimumSize: const Size.fromHeight(50),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 13.5, fontWeight: FontWeight.w700),
                ),
              ),
            ] else ...[
              // Not connected yet: Send interest CTA
              ElevatedButton.icon(
                onPressed: () {
                  sendInterestToProfile(profile);
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('💌 Connection Invitation Sent to ${profile.name}!'),
                      backgroundColor: AppColors.primary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.favorite_rounded, size: 18),
                label: const Text('Send Free Connection Request 💌'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  minimumSize: const Size.fromHeight(50),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),

              // Instant Demo Connect Shortcut
              ElevatedButton.icon(
                onPressed: () {
                  connectWithProfile(profile);
                  setState(() {
                    _loadMessages();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.celebration_rounded, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text('🎉 Mutually Connected with ${profile.name}! Chat is open.'),
                        ],
                      ),
                      backgroundColor: AppColors.trustEmerald,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.flash_on_rounded, size: 16),
                label: const Text('Instant Connect & Chat (Demo) ⚡'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  minimumSize: const Size.fromHeight(48),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  textStyle: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // View Profile Alternative Action
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileDetailScreen(profile: profile)),
                );
              },
              icon: const Icon(Icons.person_search_rounded, size: 16, color: AppColors.textPrimary),
              label: const Text('View Full Matrimony Profile'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(46),
                side: const BorderSide(color: AppColors.outline),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                textStyle: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 3. ACTIVE CONVERSATION CHAT VIEW (CONNECTED)
  // ============================================================
  Widget _buildActiveChatView() {
    final profile = _activeChatProfile!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              setState(() {
                _isViewingInbox = true;
              });
            }
          },
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileDetailScreen(profile: profile)),
            );
          },
          child: Row(
            children: [
              // Candidate Avatar with Online Dot
              Stack(
                children: [
                  CircleAvatar(
                    radius: 19,
                    backgroundImage: getAppImageProvider(profile.imagePath),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 9.5,
                      height: 9.5,
                      decoration: BoxDecoration(
                        color: AppColors.trustEmerald,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),

              // Name & Status Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            profile.name,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified_rounded, size: 14, color: Color(0xFF3B82F6)),
                      ],
                    ),
                    Text(
                      'Connected • Active now • Privacy Shield',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.5,
                        color: AppColors.trustEmerald,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined, color: AppColors.textPrimary, size: 21),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Audio call initiation sent.')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: AppColors.textPrimary, size: 23),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Video call invitation sent.')),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.textPrimary),
            onSelected: (val) {
              if (val == 'horoscope') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HoroscopeMatchingScreen(profile: profile)),
                );
              } else if (val == 'privacy') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivacySettingsScreen()),
                );
              } else if (val == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileDetailScreen(profile: profile)),
                );
              } else if (val == 'inbox') {
                setState(() {
                  _isViewingInbox = true;
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'inbox',
                child: Row(
                  children: [
                    Icon(Icons.mark_chat_unread_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('All Conversations'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person_outline, size: 18),
                    SizedBox(width: 8),
                    Text('View Candidate Profile'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'horoscope',
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 18, color: AppColors.secondary),
                    SizedBox(width: 8),
                    Text('Kundali Milan (Horoscope)'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'privacy',
                child: Row(
                  children: [
                    Icon(Icons.security, size: 18, color: AppColors.trustEmerald),
                    SizedBox(width: 8),
                    Text('Privacy & Photo Shield'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Horoscope Compatibility Mini-Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              gradient: AppColors.kundaliGradient,
              border: Border(bottom: BorderSide(color: AppColors.outlineGold)),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, size: 16, color: AppColors.secondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '✨ ${profile.horoscope.totalGunas}/36 Kundali Match (89%) • Both Non-Manglik • Highly Auspicious',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF78350F),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HoroscopeMatchingScreen(profile: profile),
                      ),
                    );
                  },
                  child: Text(
                    'View →',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Chat Feed Area
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Privacy Shield Security Card (Pinned)
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.trustEmerald.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.trustEmerald.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shield_rounded, color: AppColors.trustEmerald, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Shaadi Privacy Shield Active',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.trustEmerald,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '• Photos protected until mutual access is accepted\n• Direct contact numbers masked for privacy\n• Both profiles are 100% Government ID & Selfie Verified',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                // Date Divider
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Today',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

                // Message bubbles
                ..._chatMessages.map((msg) => _buildMessageBubble(msg)),
              ],
            ),
          ),

          // 3. Quick Icebreaker Suggestions Tray
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: _icebreakers.map((prompt) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(prompt),
                    onPressed: () => _sendMessage(prompt),
                    backgroundColor: AppColors.background,
                    labelStyle: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    side: const BorderSide(color: AppColors.outline),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                );
              }).toList(),
            ),
          ),

          // 4. Contact Privacy Banner (Mutual Consent State)
          Container(
            color: _contactRequestStatus == 'granted'
                ? const Color(0xFFECFDF5)
                : _contactRequestStatus == 'pending'
                    ? const Color(0xFFEFF6FF)
                    : const Color(0xFFFFFBEB),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(
                  _contactRequestStatus == 'granted'
                      ? Icons.verified_user_rounded
                      : _contactRequestStatus == 'pending'
                          ? Icons.hourglass_top_rounded
                          : Icons.lock_outline_rounded,
                  size: 15,
                  color: _contactRequestStatus == 'granted'
                      ? AppColors.trustEmerald
                      : _contactRequestStatus == 'pending'
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF92400E),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _contactRequestStatus == 'granted'
                        ? 'Contact Unlocked: +91 98201 45821'
                        : _contactRequestStatus == 'pending'
                            ? 'Contact Request Sent • Awaiting Approval'
                            : 'Phone Masked: +91 98•••• ••21',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _contactRequestStatus == 'granted'
                          ? const Color(0xFF065F46)
                          : _contactRequestStatus == 'pending'
                              ? const Color(0xFF1E40AF)
                              : const Color(0xFF78350F),
                    ),
                  ),
                ),
                if (_contactRequestStatus == 'none')
                  InkWell(
                    onTap: _showUnlockContactModal,
                    child: Text(
                      'Request Contact',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                else if (_contactRequestStatus == 'pending')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Pending Approval',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E40AF),
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Contact ${_activeChatProfile!.name}', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700)),
                          content: Text(
                            'Verified Direct Number: +91 98201 45821\nFamily Guardian: +91 98201 45820\n\nMutual permission granted on ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}.',
                            style: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.4),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Close'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Dialing +91 98201 45821...')),
                                );
                              },
                              icon: const Icon(Icons.phone, size: 16),
                              label: const Text('Call Now'),
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.trustEmerald, foregroundColor: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'View / Call',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.trustEmerald,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // 5. Message Input Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.outline)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.textSecondary),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Attachment: Share Kundali PDF, Photo Request')),
                      );
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type a respectful message...',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                      onPressed: () => _sendMessage(),
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

  Widget _buildMessageBubble(ChatMessageItem msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: msg.isUser ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
            bottomRight: Radius.circular(msg.isUser ? 4 : 16),
          ),
          border: msg.isUser ? null : Border.all(color: AppColors.outline),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: msg.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (msg.isAstrologyBadge && msg.badgeText != null)
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  msg.badgeText!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF92400E),
                  ),
                ),
              ),
            Text(
              msg.text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: msg.isUser ? Colors.white : AppColors.textPrimary,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg.time,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9.5,
                    color: msg.isUser ? Colors.white.withValues(alpha: 0.8) : AppColors.textMuted,
                  ),
                ),
                if (msg.isUser) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all_rounded, size: 12, color: Colors.white),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
