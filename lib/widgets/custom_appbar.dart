import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

/// Custom AppBar for HDFC dashboard
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String customerName;
  final String customerId;

  const CustomAppBar({
    super.key,
    required this.customerName,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          height: preferredSize.height,
          decoration: const BoxDecoration(
            color: AppTheme.primaryBlue,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppTheme.spacing16 : AppTheme.spacing24,
            vertical: AppTheme.spacing12,
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // HDFC Logo
                SvgPicture.asset(
                  'assets/images/hdfc-bank-logo.svg',
                  width: isMobile ? 88 : 132,
                  height: isMobile ? 20 : 26,
                ),
                
                // Right side: Customer info and logout
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          customerName,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontSize: isMobile ? 12 : 14,
                          ),
                        ),
                        if (!isMobile) ...[
                          const SizedBox(height: 2),
                          Text(
                            'Customer ID: $customerId',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    // Avatar with initials and Popup Menu
                    MenuAnchor(
                      style: MenuStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        elevation: WidgetStateProperty.all(10),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          ),
                        ),
                        padding: WidgetStateProperty.all(const EdgeInsets.all(AppTheme.spacing8)),
                        shadowColor: WidgetStateProperty.all(Colors.black.withValues(alpha: 0.2)),
                      ),
                      builder: (context, controller, child) {
                        return GestureDetector(
                          onTap: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          child: CircleAvatar(
                            radius: isMobile ? 16 : 22,
                            backgroundColor: Colors.white,
                            child: Text(
                              'CN',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.primaryBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: isMobile ? 12 : 14,
                              ),
                            ),
                          ),
                        );
                      },
                      menuChildren: [
                        _buildMenuItem(
                          context,
                          icon: Icons.person_outline,
                          title: 'Profile',
                        ),
                        _buildMenuItem(
                          context,
                          icon: Icons.grid_view_outlined,
                          title: 'Dashboard',
                          subtitle: 'coverage insights',
                        ),
                        _buildMenuItem(
                          context,
                          icon: Icons.help_outline,
                          title: 'Get Help',
                        ),
                        _buildMenuItem(
                          context,
                          icon: Icons.support_agent_outlined,
                          title: 'Contact Us',
                        ),
                      ],
                    ),
                    SizedBox(width: isMobile ? 4 : AppTheme.spacing12),
                    // Logout icon
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: isMobile ? 18 : 20,
                      ),
                      onPressed: () {
                        // Logout action
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return MenuItemButton(
      onPressed: () => debugPrint('Menu clicked: $title'),
      style: MenuItemButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Container(
        width: 180,
        height: 64, // Fixed height for even size
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing12),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF2F9),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.6),
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
