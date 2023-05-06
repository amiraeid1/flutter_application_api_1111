import 'user_provider_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: Home()));
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userFromapi = ref.watch(fetchUsersFromApi);
    return MaterialApp(
      home: Scaffold(
        body: userFromapi.when(data: (user) {
          return ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              title: Text("${user!.data![index].firstName}"),
              subtitle: Text("${user.data![index].id}"),
              leading: CircleAvatar(
                child: Image.network("${user.data![index].avatar}"),
              ),
            );
          },itemCount: user!.data!.length,);
        }, error: (Error, StackTrace) {
          return const Text('Oops, there is something unexpcted happened');
        }, loading: () {
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
