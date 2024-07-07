import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import '../../../models/SubscribtionsModel.dart';
import '../drawer_screen.dart';
import 'SubscriotionsItem.dart';

class SubscribtionsPage extends StatefulWidget {
  @override
  _SubscriptionsPageState createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscribtionsPage> {
  TextEditingController _searchController = TextEditingController();
  List<SubscriptionModel> _subscriptions = [];
  List<SubscriptionModel> _filteredSubscriptions = [];

  @override
  void initState() {
    super.initState();
    _fetchSubscriptions();
    _searchController.addListener(_filterSubscriptions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchSubscriptions() async {
    try {
      var response = await ApiManager().fetchSubscriptions();
      setState(() {
        _subscriptions = response.subscriptions;
        _filteredSubscriptions = _subscriptions;
      });
    } catch (error) {
      // Handle error
      print('Error fetching subscriptions: $error');
    }
  }

  void _filterSubscriptions() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSubscriptions = _subscriptions.where((subscription) {
        return subscription.userId.toString().toLowerCase().contains(query) ||
            subscription.planId.toString().toLowerCase().contains(query) ||
            subscription.startDate.toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
        title: Text('Subscribers'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: _buildSubscriptionsList(),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }

  Widget _buildSubscriptionsList() {
    if (_filteredSubscriptions.isEmpty && _searchController.text.isEmpty) {
      return FutureBuilder<dynamic>(
        future: ApiManager().fetchSubscriptions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            _subscriptions = snapshot.data!.subscriptions;
            _filteredSubscriptions = _subscriptions;
            return ListView.builder(
              itemCount: _filteredSubscriptions.length,
              itemBuilder: (context, index) {
                final subscription = _filteredSubscriptions[index];
                return SubscribtionsItem(subscription);
              },
            );
          } else {
            return Center(child: Text('No subscriptions found'));
          }
        },
      );
    } else if (_filteredSubscriptions.isEmpty) {
      return Center(child: Text('No matching subscriptions found'));
    } else {
      return ListView.builder(
        itemCount: _filteredSubscriptions.length,
        itemBuilder: (context, index) {
          final subscription = _filteredSubscriptions[index];
          return SubscribtionsItem(subscription);
        },
      );
    }
  }
}
