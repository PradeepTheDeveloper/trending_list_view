import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modal/user_view_modal.dart';
import 'view/widgets/Card_view.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.fetchUsers();
    print("test01 init");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, userViewModel, child) {
          if (userViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (userViewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(userViewModel.errorMessage));
          } else {
            return ListView.builder(
              itemCount: userViewModel.users.length,
              itemBuilder: (context, index) {
                return CardView(
                  title: userViewModel.users[index].name,
                  desc: userViewModel.users[index].email,
                );
                // ListTile(
                //   title: Text(userViewModel.users[index].name),
                //   subtitle: Text(userViewModel.users[index].email),
                // );
              },
            );
          }
        },
      ),
    );
  }
}
