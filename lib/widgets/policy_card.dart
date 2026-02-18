import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/policy_model.dart';
import '../theme/app_theme.dart';

/// Policy card widget displaying policy information
class PolicyCard extends StatelessWidget {
  final Policy policy;

  const PolicyCard({
    super.key,
    required this.policy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppTheme.cardWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Shield icon and status badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Shield icon
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: AppTheme.primaryBlue,
                  size: 24,
                ),
              ),
              // Status badge
              _StatusBadge(status: policy.status),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          
          // Policy name
          Text(
            policy.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          
          // Policy ID
          Text(
            policy.policyId,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: AppTheme.textGrey,
            ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          
          // Description
          Text(
            policy.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: AppTheme.textGrey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppTheme.spacing8),
          
          // Bottom row: Premium and Sum Insured
          Row(
            children: [
              Expanded(
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
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      _formatCurrency(policy.annualPremium),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
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
                    const SizedBox(height: AppTheme.spacing4),
                    Text(
                      _formatCurrency(policy.sumInsured),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow icon
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppTheme.textGrey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Format currency in Indian format
  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹ ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
}

/// Status badge widget
class _StatusBadge extends StatelessWidget {
  final PolicyStatus status;

  const _StatusBadge({
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status == PolicyStatus.active;
    final color = isActive ? AppTheme.statusActive : AppTheme.statusDue;
    final label = isActive ? 'Active' : 'Due';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing4,
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
          fontSize: 11,
        ),
      ),
    );
  }
}
