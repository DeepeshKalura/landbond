import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 32,
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
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notification screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActionButton(
              icon: Icons.add,
              label: 'List your property',
              onPressed: () {
                // Navigate to property listing screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PropertyListingScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              icon: Icons.add,
              label: 'List your project',
              onPressed: () {
                // Navigate to project listing screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProjectListingScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Your Business Insights',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInsightCard(
                  icon: Icons.message,
                  label: 'New Enquiries',
                  value: '00/00',
                ),
                const SizedBox(width: 16),
                _buildInsightCard(
                  icon: Icons.apartment,
                  label: 'Property For Sale',
                  value: '00/00',
                ),
                const SizedBox(width: 16),
                _buildInsightCard(
                  icon: Icons.home,
                  label: 'Property For Rent',
                  value: '00/00',
                ),
                const SizedBox(width: 16),
                _buildInsightCard(
                  icon: Icons.auto_awesome,
                  label: 'Recommended Leads',
                  value: '00/00',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'My Property Stats',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPropertyStatsCard(
              title: 'Total Property Listing Limit',
              value: '02',
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Active Property Sale',
              value: '02',
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Active Property Rent+PG',
              value: '02',
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Waiting For Approval Property',
              value: '02',
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Deleted Property',
              value: '02',
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Incomplete Property',
              value: '02',
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Refreshed Property',
              value: '02',
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Consumed Property',
              value: '02',
            ),
            const SizedBox(height: 8),
            _buildPropertyStatsCard(
              title: 'Unused Property',
              value: '02',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: 'Properties',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Navigate to corresponding screen based on index
        },
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Notification Screen',
          style: GoogleFonts.montserrat(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class PropertyListingScreen extends StatelessWidget {
  const PropertyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Property Listing',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Property Listing Screen',
          style: GoogleFonts.montserrat(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class ProjectListingScreen extends StatelessWidget {
  const ProjectListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Listing',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Project Listing Screen',
          style: GoogleFonts.montserrat(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
