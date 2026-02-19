import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/policy_model.dart';
import '../theme/app_theme.dart';
import '../screens/policy_detail_screen.dart';

class PolicyCard extends StatelessWidget {
  final Policy policy;

  const PolicyCard({
    super.key,
    required this.policy,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PolicyDetailScreen(
              policy: policy,
              customerId: 'HDFC123',
              customerName: 'Hrisheekesh Rabha',
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppTheme.cardWhite,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          boxShadow: AppTheme.softShadow,
        ),
        child: Row(
          children: [

            /// ================= MAIN CONTENT =================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// TOP ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: AppTheme.primaryBlue,
                          size: 18,
                        ),
                      ),
                      _StatusBadge(status: policy.status),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// POLICY NAME
                  Text(
                    policy.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  /// POLICY ID
                  Text(
                    policy.policyId,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: AppTheme.textGrey,
                    ),
                  ),

                  const SizedBox(height: 2),

                  /// DESCRIPTION
                  Text(
                    policy.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: AppTheme.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  /// ================= SAFE PREMIUM SECTION =================
                  LayoutBuilder(
                    builder: (context, constraints) {

                      final isMobile = constraints.maxWidth < 260;

                      return Wrap(
                        spacing: 20,
                        runSpacing: 6,
                        children: [

                          SizedBox(
                            width: isMobile
                                ? constraints.maxWidth
                                : 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Annual Premium',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                    color: AppTheme.textGrey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatCurrency(policy.annualPremium),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: isMobile
                                ? constraints.maxWidth
                                : 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sum Insured',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                    color: AppTheme.textGrey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatCurrency(policy.sumInsured),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            /// ARROW
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppTheme.textGrey,
            ),
          ],
        ),
      ),
    );
  }

  /// FORMAT ₹
  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹ ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
}

class _StatusBadge extends StatelessWidget {
  final PolicyStatus status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status == PolicyStatus.active;
    final isDue = status == PolicyStatus.due;

    final color = isActive
        ? AppTheme.statusActive
        : (isDue ? AppTheme.statusDue : AppTheme.statusExpired);

    final label = isActive
        ? 'Active'
        : (isDue ? 'Due' : 'Expired');

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}
