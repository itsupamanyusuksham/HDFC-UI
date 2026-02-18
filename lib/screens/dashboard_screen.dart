import 'package:flutter/material.dart';
import '../models/policy_model.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/summary_card.dart';
import '../widgets/category_filter.dart';
import '../widgets/policy_card.dart';

/// Main dashboard screen displaying insurance policies and summary
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PolicyCategory _selectedCategory = PolicyCategory.all;
  final List<Policy> _allPolicies = PolicyData.getSamplePolicies();

  /// Get filtered policies based on selected category
  List<Policy> get _filteredPolicies {
    if (_selectedCategory == PolicyCategory.all) {
      return _allPolicies;
    }
    return _allPolicies
        .where((policy) => policy.category == _selectedCategory)
        .toList();
  }

  /// Calculate total annual premium
  double get _totalAnnualPremium {
    return _allPolicies.fold(0, (sum, policy) => sum + policy.annualPremium);
  }

  /// Calculate total coverage
  double get _totalCoverage {
    return _allPolicies.fold(0, (sum, policy) => sum + policy.sumInsured);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final padding = isMobile ? AppTheme.spacing16 : AppTheme.spacing24;

        return Scaffold(
          backgroundColor: AppTheme.backgroundGrey,
          appBar: const CustomAppBar(
            customerName: 'Customer Name',
            customerId: 'HDFC000000',
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // Welcome text
                  Text(
                    'Welcome Back, Customer!',
                    style: isMobile 
                        ? Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
                        : Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // Summary cards
                  _buildSummaryCards(constraints.maxWidth),
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // Category filter buttons
                  CategoryFilter(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // Policy cards grid
                  _buildPolicyGrid(constraints.maxWidth),
                  const SizedBox(height: AppTheme.spacing24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build summary cards based on screen width
  Widget _buildSummaryCards(double maxWidth) {
    final cards = [
      SummaryCard(
        icon: Icons.description_outlined,
        title: 'Total Policies',
        value: '${_allPolicies.length}',
      ),
      SummaryCard(
        icon: Icons.currency_rupee,
        title: 'Annual Premium',
        value: '₹ ${_formatAmount(_totalAnnualPremium)}',
        subtitle: 'Across all Policies',
      ),
      SummaryCard(
        icon: Icons.shield_outlined,
        title: 'Total Coverage',
        value: '₹ ${_formatAmount(_totalCoverage)}',
        subtitle: 'Sum assured amount',
      ),
    ];

    if (maxWidth < 700) {
      // Mobile & Small Tablet: Horizontal scroll
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: cards.map((card) => Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacing16),
            child: SizedBox(width: 260, child: card),
          )).toList(),
        ),
      );
    } else {
      // Tablet & Desktop: Single Row with Expanded cards for even width
      return IntrinsicHeight(
        child: Row(
          children: cards.map((card) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: AppTheme.spacing16),
              child: card,
            ),
          )).toList(),
        ),
      );
    }
  }

  /// Build responsive grid of policy cards
  Widget _buildPolicyGrid(double maxWidth) {
    int crossAxisCount = 1;
    double childAspectRatio = 1.8;

    if (maxWidth > 1100) {
      crossAxisCount = 3;
      childAspectRatio = 1.6;
    } else if (maxWidth > 650) {
      crossAxisCount = 2;
      childAspectRatio = 1.8;
    } else {
      crossAxisCount = 1;
      childAspectRatio = 3.0;
    }
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppTheme.spacing16,
        mainAxisSpacing: AppTheme.spacing16,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: _filteredPolicies.length,
      itemBuilder: (context, index) {
        return PolicyCard(policy: _filteredPolicies[index]);
      },
    );
  }

  /// Format large amounts with commas
  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)} L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(0);
  }
}
