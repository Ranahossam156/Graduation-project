import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/HistoryModel.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import '../../../models/UserModel.dart';
import '../user widgets/menu_icon_list.dart';
import 'HistoryItemUser.dart';

class HistoryUserPage extends StatefulWidget {
  static const String routName="HistoryUser";
  final Result user;
  HistoryUserPage(this.user, {super.key});
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryUserPage> {
  TextEditingController _searchController = TextEditingController();
  List<HistoryModel> _history = [];
  List<HistoryModel> _filteredHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchHistory();
    _searchController.addListener(_filterHistory);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchHistory() async {
    try {
      var result = await ApiManager.getHistory();
      setState(() {
        _history = result;
        _filteredHistory = _history;
      });
    } catch (error) {
      // Handle error
      print('Error fetching history: $error');
    }
  }

  void _filterHistory() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredHistory = _history.where((historyItem) {
        return historyItem.date.toString().toLowerCase().contains(query) ||
            historyItem.roadId.toString().toLowerCase().contains(query) ||
            historyItem.classification.toLowerCase().contains(query) ||
            historyItem.trafficFlow.toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(14, 46, 92, 1),
        actions: const <Widget>[
          MenuIconList(),
        ],
        leading:
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
            child: _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    if (_filteredHistory.isEmpty && _searchController.text.isEmpty) {
      return FutureBuilder<List<HistoryModel>>(
        future: ApiManager.getHistoryUser(widget.user.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            _history = snapshot.data!;
            _filteredHistory = _history;
            return ListView.builder(
              itemCount: _filteredHistory.length,
              itemBuilder: (context, index) {
                final historyData = _filteredHistory[index];
                return HistoryUserItem(historyData);
              },
            );
          } else {
            return Center(child: Text('No history found'));
          }
        },
      );
    } else if (_filteredHistory.isEmpty) {
      return Center(child: Text('No matching history found'));
    } else {
      return ListView.builder(
        itemCount: _filteredHistory.length,
        itemBuilder: (context, index) {
          final historyData = _filteredHistory[index];
          return HistoryUserItem(historyData);
        },
      );
    }
  }
}
