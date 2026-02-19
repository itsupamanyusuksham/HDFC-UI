import 'package:flutter/material.dart';
import '../widgets/donut_chart.dart';
import '../widgets/info_card.dart';
import '../widgets/custom_appbar.dart';
import 'dashboard_screen.dart';

class AnalyticsDashboard extends StatelessWidget {
  final String customerName;
  final String customerId;

  const AnalyticsDashboard({
    super.key,
    required this.customerName,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF3),

      /// SAME APPBAR AS WELCOME PAGE
      appBar: CustomAppBar(
        customerName: customerName,
        customerId: customerId,
        onLogoTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>
                  DashboardScreen(customerId: customerId),
            ),
            (route) => false,
          );
        },
      ),

      /// ================= BODY =================
      body: LayoutBuilder(
        builder: (context, constraints) {

          final width = constraints.maxWidth;
          final isMobile = width < 600;

          double donutSpacing;

          if (width > 1300) {
            donutSpacing = 80;
          } else if (width > 900) {
            donutSpacing = 60;
          } else {
            donutSpacing = 30;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 40,
              vertical: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// HEADER
                const Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                /// ================= DONUT SECTION =================
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: isMobile ? 10 : 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(isMobile ? 12 : 20),
                    boxShadow: isMobile
                        ? []
                        : const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            )
                          ],
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: donutSpacing,
                    runSpacing: 40,
                    children: const [
                      DonutChart(
                        title: "Life Insurance",
                        percent: 25,
                        label: "Secure",
                      ),
                      DonutChart(
                        title: "Health Insurance",
                        percent: 66,
                        label: "Covered",
                      ),
                      DonutChart(
                        title: "Vehicle Insurance",
                        percent: 75,
                        label: "Protected",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                /// ================= INFO CARDS (OVERFLOW PROOF) =================
                LayoutBuilder(
                  builder: (context, constraints) {

                    final width = constraints.maxWidth;
                    double cardWidth;

                    if (width > 1300) {
                      cardWidth = (width / 4) - 24;
                    }
                    else if (width > 900) {
                      cardWidth = (width / 2) - 20;
                    }
                    else {
                      cardWidth = width;
                    }

                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: [

                        SizedBox(
                          width: cardWidth,
                          child: const InfoCard(
                            icon: Icons.description_outlined,
                            color: Color(0xFF2E49B8),
                            title: "Policies Linked",
                            value: "5",
                            subtitle: "1 expiring soon",
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,
                          child: const InfoCard(
                            icon: Icons.shield_outlined,
                            color: Color(0xFF2E49B8),
                            title: "Total Protection",
                            value: "₹ x,xx,xx,xxx",
                            subtitle: "sum of all insurance",
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,
                          child: const InfoCard(
                            icon: Icons.warning_amber_outlined,
                            color: Color(0xFF2E49B8),
                            title: "Coverage Gap",
                            value: "₹ xx,xx,xxx",
                            subtitle:
                                "to reach recommended levels",
                          ),
                        ),

                        SizedBox(
                          width: cardWidth,
                          child: const InfoCard(
                            icon: Icons.bar_chart,
                            color: Color(0xFF2E49B8),
                            title: "Risk Status",
                            value: "MODERATE",
                            subtitle: "see insights",
                          ),
                        ),
                      ],
                    );
                  },
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
