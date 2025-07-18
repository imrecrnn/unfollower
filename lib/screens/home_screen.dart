import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';
import '../models/user_model.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserModel>? _nonFollowers;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNonFollowers();
  }

  Future<void> _loadNonFollowers() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final nonFollowers = await context.read<AuthProvider>().getNonFollowers();
      if (!mounted) return;
      
      setState(() {
        _nonFollowers = nonFollowers;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    try {
      await context.read<AuthProvider>().logout();
      if (!mounted) return;
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Çıkış yapılırken hata: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Takip Etmeyenler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadNonFollowers,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hata oluştu:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadNonFollowers,
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      );
    }

    if (_nonFollowers == null || _nonFollowers!.isEmpty) {
      return Center(
        child: Text(
          'Seni takip etmeyen kimse yok!',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNonFollowers,
      child: ListView.builder(
        itemCount: _nonFollowers!.length,
        itemBuilder: (context, index) {
          final user = _nonFollowers![index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicUrl),
            ),
            title: Text(user.username),
            subtitle: user.fullName != null ? Text(user.fullName!) : null,
            trailing: IconButton(
              icon: const Icon(Icons.open_in_new),
              onPressed: () {
                // Instagram profilini aç
                final instagramService = context.read<AuthProvider>().instagramService;
                instagramService.openProfileInInstagram(user.username);
              },
            ),
          );
        },
      ),
    );
  }
} 