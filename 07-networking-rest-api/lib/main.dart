import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/post.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: PostsPage());
}

Future<List<Post>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'),
  );

  if (response.statusCode == 200) {
    // The body is a JSON array - decode it, then map each element through
    // our typed Post.fromJson factory
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts (status ${response.statusCode})');
  }
}

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});
  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    // Kick off the fetch ONCE in initState, store the Future in state -
    // NEVER call fetchPosts() directly inside build(), or it re-fetches
    // on every single rebuild (a very common and costly beginner mistake).
    _postsFuture = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          // FutureBuilder gives you exactly the 3 states real apps need:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // LOADING
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // ERROR
          }
          final posts = snapshot.data!; // DATA
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
              );
            },
          );
        },
      ),
    );
  }
}
