import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/UserModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import 'UserItem.dart';

class UserListScreen extends StatefulWidget {
  static const String routName = "Users";
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Result> _users = [];
  List<Result> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchUsers() async {
    try {
      var response = await ApiManager.getUsers("user/");
      setState(() {
        _users = response.result ?? [];
        _filteredUsers = _users;
      });
    } catch (error) {
      // Handle error
      print('Error fetching users: $error');
    }
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _users.where((user) {
        return user.name!.toLowerCase().contains(query) ||
            user.email!.toLowerCase().contains(query) ||
            user.address!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHome()),
            );
          },
        ),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
        title: Text('Users'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
            child: _buildUsersList(),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }

  Widget _buildUsersList() {
    return FutureBuilder<List<Result>>(
      future: ApiManager.getUsers("user/").then((response) => response.result ?? []),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.error?.toString() ?? "An error occurred"),
                TextButton(
                  onPressed: () {
                    // Retry logic
                  },
                  child: const Text("Try again"),
                ),
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          final users = snapshot.data!;
          _users = users;
          _filteredUsers = _users.where((user) {
            String query = _searchController.text.toLowerCase();
            return user.name!.toLowerCase().contains(query) ||
                user.email!.toLowerCase().contains(query) ||
                user.address!.toLowerCase().contains(query);
          }).toList();

          return ListView.builder(
            itemCount: _filteredUsers.length,
            itemBuilder: (context, index) {
              if (_filteredUsers[index].isAdmin == false) {
                return UserItem(_filteredUsers[index]);
              } else {
                return SizedBox.shrink(); // Empty container for admins
              }
            },
          );
        } else {
          return Center(child: Text('No users found'));
        }
      },
    );
  }
}
