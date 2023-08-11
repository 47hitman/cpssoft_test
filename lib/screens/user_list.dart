import 'package:cpssoft_test/service/endpoint.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  bool isLoading = false;
  String searchQuery = ''; // Store the search query

  @override
  void initState() {
    super.initState();
    _fetchAdditionalData();
  }

  Future<void> _fetchAdditionalData() async {
    await Endpoint.instance.userget().then((value) {
      setState(() {
        print(value);
        userdata = value;
      });
    });
  }

  var userdata = [];

  List get filteredUserdata {
    return userdata.where((userData) {
      final name = userData['name']?.toLowerCase() ?? '';
      final address = userData['address']?.toLowerCase() ?? '';
      final email = userData['email']?.toLowerCase() ?? '';
      final phoneNumber = userData['phoneNumber']?.toLowerCase() ?? '';
      final query = searchQuery.toLowerCase();
      return name.contains(query) ||
          address.contains(query) ||
          email.contains(query) ||
          phoneNumber.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Fetching Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUserdata.length,
              itemBuilder: (context, index) {
                final userData = filteredUserdata[index];
                final user =
                    userData['name'] != null && userData['name'].isNotEmpty;

                if (!user) {
                  return const SizedBox.shrink();
                }

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(userData['name']),
                      Text(userData['address']),
                      Text(userData['email']),
                      Text(userData['phoneNumber']),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
