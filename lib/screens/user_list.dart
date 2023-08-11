import 'package:cpssoft_test/service/endpoint.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  String name = "habib";
  String address = "pekan baru";
  String email = "afifhabib72@gmail.com";
  String phoneNumber = "1234556";
  String city = "pekanbaru";
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
    // Filter the userdata list based on the search query
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
              decoration: InputDecoration(
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

  Widget _senderButtonEnabled() {
    return isLoading
        ? const CircularProgressIndicator()
        : MaterialButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 2.0,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9900),
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Booking Sekarang',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
            ),
            onPressed: () {
              setState(() {
                isLoading = true;
                print(" aaaaa ------- ");
              });
              Endpoint.instance
                  .userpost(
                name,
                address,
                email,
                phoneNumber,
                city,
              )
                  .then((value) {
                setState(() {
                  print("Payment response: $value");
                  if (value == "[]") {
                    // isLoading = false;
                    print("error");
                    // print(globals.serviceId);
                    // failed();
                  } else {
                    // isLoading = false;
                    print("oke");
                    // print(globals.serviceId);
                    // RegisterDialog(context);
                  }
                });
              }).catchError((e) {
                print('Payment Error');
                print(e);
                // print(globals.serviceId);
                // isLoading = false;
                // _showDialogTimeout();
              });
            });
  }
}
