import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<String> _menuTitles = [
    'Analiz',
    'Profil',
    'Ayarlar',
    'Yardım',
  ];

  static const List<IconData> _menuIcons = [
    Icons.analytics,
    Icons.person,
    Icons.settings,
    Icons.help_outline,
  ];

  Widget _buildAnalysisPage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF58529),
            Color(0xFFDD2A7B),
            Color(0xFF8134AF),
            Color(0xFF515BD4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 16),
          Center(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFFF58529),
                    Color(0xFFDD2A7B),
                    Color(0xFF8134AF),
                    Color(0xFF515BD4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Text(
                'UnFollower Analiz',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAnalysisButton(
                icon: Icons.person_remove,
                label: 'Geri Takip Etmeyenler',
                color: Colors.redAccent,
                onTap: () {},
              ),
              _buildAnalysisButton(
                icon: Icons.person_off,
                label: 'Kaybedilen Takipçiler',
                color: Colors.deepPurple,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildStatCard(
            title: 'Toplam Takipçi',
            value: '1.234',
            icon: Icons.group,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            title: 'Son 7 Günde Kaybedilen',
            value: '12',
            icon: Icons.trending_down,
            color: Colors.pink,
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            title: 'Geri Takip Etmeyenler',
            value: '56',
            icon: Icons.person_remove,
            color: Colors.deepPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisButton({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 6,
      ),
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UnFollower'),
        backgroundColor: const Color(0xFFDD2A7B),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildAnalysisPage(),
          _buildPlaceholder('Profil'),
          _buildPlaceholder('Ayarlar'),
          _buildPlaceholder('Yardım'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(_menuTitles.length, (i) => BottomNavigationBarItem(
          icon: Icon(_menuIcons[i]),
          label: _menuTitles[i],
        )),
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFDD2A7B),
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
} 