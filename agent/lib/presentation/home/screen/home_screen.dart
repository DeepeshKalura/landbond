import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/app_url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/home/app_logo.png',
              height: 32,
              color: Colors.black,
            ),
            const SizedBox(width: 8),
            Text(
              'RealEstateIndia',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // context.pushNamed(AppUrl.notificationScreen);
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              context.pushNamed(AppUrl.notificationScreen);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              'Your Business Insights',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildPropertyStatsCard(
              title: 'Total Property Listing Limit',
              value: '02',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Active Property Sale',
              value: '02',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Active Property Rent+PG',
              value: '02',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Waiting For Approval Property',
              value: '02',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Deleted Property',
              value: '02',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Incomplete Property',
              value: '02',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Refreshed Property',
              value: '02',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Consumed Property',
              value: '02',
              onPressed: () {},
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Unused Property',
              value: '02',
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          context.pushNamed(
            AppUrl.propertyEntryFormScreen,
            extra: {'propertyId': auth.currentUser!.uid},
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyStatsCard({
    required String title,
    required String value,
    required void Function()? onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
