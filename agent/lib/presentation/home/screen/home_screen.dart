import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/app_url.dart';
import '../../../core/util/pallet.dart';
import '../../auth/screen/widget/list_propteries_widget.dart';
import '../data/model/property.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _propertiesStream;

  // Business metrics
  int totalListingLimit =
      50; // You can adjust this based on your business logic
  Map<String, int> metrics = {
    'activeForSale': 0,
    'activeForRent': 0,
    'pendingApproval': 0,
    'deleted': 0,
    'incomplete': 0,
    'refreshed': 0,
    'consumed': 0,
    'unused': 0,
  };

  @override
  void initState() {
    super.initState();
    final userId = auth.currentUser!.uid;
    _propertiesStream = firestore
        .collection('properties')
        .where('producerId', isEqualTo: userId)
        .snapshots();

    // Initialize business metrics
    _updateMetrics();
  }

  Future<void> _updateMetrics() async {
    final userId = auth.currentUser!.uid;
    final propertiesRef = firestore.collection('properties');

    // Get active properties for sale
    final saleQuery = await propertiesRef
        .where('producerId', isEqualTo: userId)
        .where('dealType', isEqualTo: 'sale')
        .where('isActive', isEqualTo: true)
        .get();
    metrics['activeForSale'] = saleQuery.docs.length;

    // Get active properties for rent
    final rentQuery = await propertiesRef
        .where('producerId', isEqualTo: userId)
        .where('dealType', isEqualTo: 'rent')
        .where('isActive', isEqualTo: true)
        .get();
    metrics['activeForRent'] = rentQuery.docs.length;

    // Get pending approval properties
    final pendingQuery = await propertiesRef
        .where('producerId', isEqualTo: userId)
        .where('verificationStatus', isEqualTo: 'pending')
        .get();
    metrics['pendingApproval'] = pendingQuery.docs.length;

    setState(() {});
  }

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
              // Handle messaging
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
      body: RefreshIndicator(
        onRefresh: _updateMetrics,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Business Insights',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Business Stats Cards
                _buildPropertyStatsCard(
                  title: 'Total Property Listing Limit',
                  value: totalListingLimit.toString(),
                ),
                const SizedBox(height: 8),
                _buildPropertyStatsCard(
                  title: 'Active Property Sale',
                  value: metrics['activeForSale'].toString(),
                ),
                const SizedBox(height: 8),
                _buildPropertyStatsCard(
                  title: 'Active Property Rent+PG',
                  value: metrics['activeForRent'].toString(),
                ),
                const SizedBox(height: 8),
                _buildPropertyStatsCard(
                  title: 'Waiting For Approval',
                  value: metrics['pendingApproval'].toString(),
                ),

                const SizedBox(height: 24),
                Text(
                  'Your Properties',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Properties List
                StreamBuilder<QuerySnapshot>(
                  stream: _propertiesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data?.docs.isEmpty ?? true) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.home_work_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No properties listed yet',
                              style: GoogleFonts.quicksand(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        final property = Property.fromJson(
                            doc.data() as Map<String, dynamic>);
                        return InkWell(
                          onTap: () {
                            context.pushNamed(
                              AppUrl.updateProptertiesScreen,
                              extra: {'proptery': property},
                            );
                          },
                          child: ListPropertyCardWidget(
                            property: property,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallet.primaryColor,
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
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Pallet.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
