import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';
import 'package:service_manager/view/adminside/addproduct/add_product.dart';
import '../../../controller/provider/login/login_page_provider.dart';
import '../../login/sign_in.dart';

class ScreenAdminHome extends StatelessWidget {
  const ScreenAdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User View',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.brown)),
                  InkWell(
                    child: const CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 25,
                      backgroundImage: AssetImage('asset/user.jpeg') ,),
                    onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => AlertDialog(
                        title: Text('Warning'),
                        content: Text(
                            'Are you sure you want to log out? You will be redirected to the login page.'),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Sign out',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                                Provider.of<SignInNotifier>(context,listen: false).validationError=['','',''];
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              await _auth.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenSignIn(),
                                  ),
                                  (route) => false);
                            },
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 250, top: 30),
                child: Column(
                  children: [
                    InkWell(
                        child: Image.asset(
                          'asset/add.png',
                          height: 70,
                        ),
                        onTap: () {
                      Provider.of<AdminAddProductNotifier>(context,listen: false).validationError=['','','','','','',''];
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenAdminAddProduct(),
                            ),);}),
                    const Text(
                      'Add Product',
                      style: TextStyle(fontSize: 19),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.brown[300],
                      child: const ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('asset/user.jpeg'),
                        ),
                        title: Text('Name'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TotalWorks',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '2567',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )
                          ],
                        ),
                        trailing: Text(
                          'Total Amount : 7851',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                  itemCount: 4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
