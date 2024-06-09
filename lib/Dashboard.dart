
import 'package:flutter/material.dart';

import 'AudienceBuilderPage.dart';
import 'CampaignListingPage.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRM Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile page
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'CRM Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                // Navigate to Dashboard
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Audiences'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> AudienceBuilderPage()));

              },
            ),
            ListTile(
              leading: Icon(Icons.campaign),
              title: Text('Campaigns'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CampaignListingPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SummaryCard(
                  title: 'Total Customers',
                  value: '1,250',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
                SummaryCard(
                  title: 'Total Campaigns',
                  value: '45',
                  icon: Icons.campaign,
                  color: Colors.green,
                ),
                SummaryCard(
                  title: 'Recent Activities',
                  value: '23',
                  icon: Icons.notifications,
                  color: Colors.orange,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: RecentActivities(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Create Campaign Page
              },
              child: Text('Create New Campaign'),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  SummaryCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample recent activities data
    final recentActivities = [
      'Campaign "Summer Sale" sent successfully',
      'Customer "John Doe" registered',
      'Order #12345 placed by Jane Smith',
    ];

    return ListView.builder(
      itemCount: recentActivities.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text(recentActivities[index]),
        );
      },
    );
  }
}
