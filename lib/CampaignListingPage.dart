
import 'dart:convert';

import 'package:crm_application/token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'baseurl.dart';


class Campaign {
  final String title;
  final String details;
  final DateTime startDate;
  final DateTime endDate;

  Campaign({
    required this.title,
    required this.details,
    required this.startDate,
    required this.endDate,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      title: json['title'],
      details: json['details'],
      startDate: DateTime.parse(json['startdate']),
      endDate: DateTime.parse(json['enddate']),
    );
  }
}


class CampaignListingPage extends StatefulWidget {
  @override
  _CampaignListingPageState createState() => _CampaignListingPageState();
}

class _CampaignListingPageState extends State<CampaignListingPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();


  List<Campaign> _campaigns = [
    // Campaign(
    //   title: 'Summer Sale',
    //   details: 'Get up to 50% off on summer collection!',
    //   startDate: DateTime(2024, 6, 1),
    //   endDate: DateTime(2024, 6, 30),
    // ),
    // Campaign(
    //   title: 'Back to School',
    //   details: 'Exclusive discounts for back-to-school essentials!',
    //   startDate: DateTime(2024, 8, 1),
    //   endDate: DateTime(2024, 8, 31),
    // ),
    // Add more campaigns as needed
  ];

  late List<Campaign> _filteredCampaigns;

  @override
  void initState() {
    super.initState();
    fetchCampaigns();
    print(_campaigns);
    _filteredCampaigns = List.from(_campaigns);
  }

  Future<void> fetchCampaigns() async {
    try {

      final response = await http.get(
        Uri.parse('${BaseUrl.baseUrl}/campaigns/getall'),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _campaigns = data.map((json) => Campaign.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load campaigns: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching campaigns: $e');
      // Handle error gracefully, such as showing a snackbar or toast
    }
  }

  Future<void> addCampaign() async {
    try {
      print(titleController.text);
      print(detailsController.text);

      String formattedendDate = DateFormat('yyyy-MM-dd').format(endDate);
      String formattestartDate = DateFormat('yyyy-MM-dd').format(startDate);

      var url = Uri.parse('${BaseUrl.baseUrl}/campaigns/create');
      var body = json.encode({
        "title": titleController.text,
        "details": detailsController.text,
        "startdate": formattestartDate,
        "enddate": formattedendDate,
      });

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
        },
        body: body,
      );

      print('Campaign Response status: ${response.statusCode}');

      if (response.statusCode == 201) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showModalBottomSheet(
            context: context,
            builder: (context) => const SizedBox(
              height: 100,
              child: Center(child: Text("New Campaign Added to database")),
            ),
          );
        });
        print("Campaign added successful");
      }
      else {
        print("campaign addition failed with status: ${response.statusCode}");
      }
      print('Campaign Response body: ${response.body}');
    } catch (e) {
      print('Error during adding campaign: $e');
    }
  }

  Future<void> addCampaignTry() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    await addCampaign();
    Navigator.of(context).pop();
  }


  void _filterCampaigns(String query) {
    setState(() {
      _filteredCampaigns = _campaigns.where((campaign) {
        return campaign.title.toLowerCase().contains(query.toLowerCase()) ||
            campaign.details.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _sortByStartDate() {
    setState(() {
      _filteredCampaigns.sort((a, b) => a.startDate.compareTo(b.startDate));
    });
  }

  Future<void> _showAddCampaignDialog() async {

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Campaign'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: detailsController,
                  decoration: InputDecoration(labelText: 'Details'),
                ),
                SizedBox(height: 20),
                Text('Start Date: ${startDate.toString()}'),
                ElevatedButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        startDate = selectedDate;
                        String formattedstartDate = DateFormat('yyyy-MM-dd').format(startDate);
                      });
                    }
                  },
                  child: Text('Select Start Date'),
                ),
                SizedBox(height: 20),
                Text('End Date: ${endDate.toString()}'),
                ElevatedButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: endDate,
                      firstDate: startDate,
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        endDate = selectedDate;

                      });
                    }
                  },
                  child: Text('Select End Date'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add the new campaign to the list
                final newCampaign = Campaign(
                  title: titleController.text,
                  details: detailsController.text,
                  startDate: startDate,
                  endDate: endDate,
                );
                setState(() {
                  _campaigns.add(newCampaign);
                  _filteredCampaigns.add(newCampaign);

                  addCampaignTry();

                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campaigns'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CampaignSearch(_campaigns, _filterCampaigns));
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _sortByStartDate();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _campaigns.length,
          itemBuilder: (context, index) {
            final campaign = _campaigns[index];
            return Card(
              child: ListTile(
                title: Text(campaign.title),
                subtitle: Text(campaign.details),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Campaign Detail Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CampaignDetailPage(campaign: campaign),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(token);
          _showAddCampaignDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CampaignDetailPage extends StatelessWidget {
  final Campaign campaign;

  CampaignDetailPage({required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(campaign.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(campaign.details),
            SizedBox(height: 20),
            Text(
              'Start Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(campaign.startDate.toString()),
            SizedBox(height: 10),
            Text(
              'End Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(campaign.endDate.toString()),
          ],
        ),
      ),
    );
  }
}

class CampaignSearch extends SearchDelegate<String> {
  final List<Campaign> campaigns;
  final Function(String) onSearch;

  CampaignSearch(this.campaigns, this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: campaigns.length,
      itemBuilder: (context, index) {
        final campaign = campaigns[index];
        return ListTile(
          title: Text(campaign.title),
          subtitle: Text(campaign.details),
          onTap: () {
            close(context, campaign.title);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? campaigns
        : campaigns.where((campaign) {
      return campaign.title.toLowerCase().contains(query.toLowerCase()) ||
          campaign.details.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final campaign = suggestionList[index];
        return ListTile(
          title: Text(campaign.title),
          subtitle: Text(campaign.details),
          onTap: () {
            onSearch(query);
            close(context, campaign.title);
          },
        );
      },
    );
  }
}