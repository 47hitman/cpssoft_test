import 'package:cpssoft_test/service/endpoint.dart';
import 'package:flutter/material.dart';

class UserAdd extends StatefulWidget {
  const UserAdd({super.key});

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String address = "";
  String email = "";
  String phoneNumber = "";
  String city = "";
  bool isLoading = false;
  String searchQuery = ''; // Store the search query

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City'),
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _senderButtonEnabled(),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
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
              if (_formKey.currentState!.validate()) {
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
                      isLoading = false;
                      print("error");
                      // print(globals.serviceId);
                      // failed();
                    } else {
                      isLoading = false;
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
              }
            });
  }
}
