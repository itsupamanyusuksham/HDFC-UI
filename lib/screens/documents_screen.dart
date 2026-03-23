import 'package:flutter/material.dart';
import '../models/policy_model.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../screens/policy_detail_screen.dart';

class DocumentsScreen extends StatelessWidget {
  final String customerName;
  final String customerId;

  const DocumentsScreen({
    super.key,
    required this.customerName,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    // Fetch all sample policies for the user
    final List<Policy> policies = PolicyData.getSamplePolicies();

    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: CustomAppBar(
        customerName: customerName,
        customerId: customerId,
        showBackButton: true,
        onLogoTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Documents & Certificates',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: AppTheme.textDark,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing8),
                Text(
                  'Download your policy documents and certificates below.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textGrey,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: AppTheme.spacing32),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: policies.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppTheme.spacing16),
                  itemBuilder: (context, index) {
                    final policy = policies[index];
                    return _DocumentCard(
                      policy: policy,
                      customerName: customerName,
                      customerId: customerId,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final Policy policy;
  final String customerName;
  final String customerId;

  const _DocumentCard({
    required this.policy,
    required this.customerName,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: AppTheme.cardShadow,
        border: Border.all(color: AppTheme.borderBlue),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: AppTheme.primaryBlue,
              size: 32,
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  policy.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Policy ID: ${policy.policyId}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textGrey,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Category: ${policy.category.name.toUpperCase()}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          ElevatedButton.icon(
            onPressed: () {
              // Simulate downloading by opening the detail screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PolicyDetailScreen(
                    policy: policy,
                    customerName: customerName,
                    customerId: customerId,
                  ),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Downloading document for ${policy.name}...'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.download, size: 20),
            label: const Text('Download Policy'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing20,
                vertical: AppTheme.spacing12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
