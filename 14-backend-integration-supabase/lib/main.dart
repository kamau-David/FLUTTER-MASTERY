import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize ONCE at app startup - this sets up the global Supabase.instance.client
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );

  runApp(const MyApp());
}

// A shortcut so you don't type Supabase.instance.client everywhere
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: AuthGate());
}

// AuthGate: listens to auth state and shows the right screen automatically -
// no manual navigation needed when login state changes.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        return session != null ? const ProductsScreen() : const LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  Future<void> _signIn() async {
    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // No manual navigation needed - AuthGate's StreamBuilder reacts
      // automatically to the auth state change and swaps the screen.
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> _signUp() async {
    try {
      await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            if (_error != null) Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(_error!, style: const TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _signIn, child: const Text('Sign In')),
            TextButton(onPressed: _signUp, child: const Text('Create an account')),
          ],
        ),
      ),
    );
  }
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => supabase.auth.signOut()),
        ],
      ),
      // StreamBuilder + .stream() gives REALTIME updates - if another
      // device inserts/updates/deletes a row in this table, this UI
      // updates automatically with zero extra code.
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: supabase.from('products').stream(primaryKey: ['id']).order('created_at'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product['name'] ?? ''),
                subtitle: Text('KES ${product['price']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // Direct Postgres query - Supabase auto-generates a REST
                    // API over your tables, respecting Row Level Security
                    // policies you've set up in the dashboard.
                    await supabase.from('products').delete().eq('id', product['id']);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await supabase.from('products').insert({
            'name': 'New Product',
            'price': 100,
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
