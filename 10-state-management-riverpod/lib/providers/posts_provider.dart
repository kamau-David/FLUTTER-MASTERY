import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// FutureProvider wraps an async operation and gives your UI AsyncValue,
// which has built-in .when() for loading/error/data - replacing the manual
// FutureBuilder + ConnectionState checks from folder 07.
final postsProvider = FutureProvider<List<dynamic>>((ref) async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to load posts');
  }
  return jsonDecode(response.body) as List<dynamic>;
});
