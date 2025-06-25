import 'package:flutter/material.dart';

class EmptyStateExchange extends StatelessWidget {
  final String mode;
  const EmptyStateExchange({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Container dengan Gradient berdasarkan mode
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getGradientColors(),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _getShadowColor(),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              _getIcon(),
              size: 70,
              color: _getIconColor(),
            ),
          ),

          const SizedBox(height: 32),

          // Judul dengan style berdasarkan mode
          Text(
            _getTitle(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Deskripsi dengan konten berbeda untuk setiap mode
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _getDescription(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Tombol dengan action berbeda untuk setiap mode
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _getButtonGradientColors(),
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: _getButtonShadowColor(),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                _handleButtonPress(context);
              },
              icon: Icon(_getButtonIcon(), color: Colors.white),
              label: Text(
                _getButtonText(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods untuk customization berdasarkan mode
  List<Color> _getGradientColors() {
    switch (mode) {
      case 'Offers Made':
        return [Colors.orange.shade100, Colors.red.shade100];
      case 'Offers Received':
        return [Colors.green.shade100, Colors.teal.shade100];
      case 'Offers Completed':
        return [Colors.purple.shade100, Colors.indigo.shade100];
      default:
        return [Colors.blue.shade100, Colors.purple.shade100];
    }
  }

  Color _getShadowColor() {
    switch (mode) {
      case 'Offers Made':
        return Colors.orange.withOpacity(0.2);
      case 'Offers Received':
        return Colors.green.withOpacity(0.2);
      case 'Offers Completed':
        return Colors.purple.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  IconData _getIcon() {
    switch (mode) {
      case 'Offers Made':
        return Icons.send_rounded;
      case 'Offers Received':
        return Icons.inbox_rounded;
      case 'Offers Completed':
        return Icons.check_circle_rounded;
      default:
        return Icons.swap_horiz_rounded;
    }
  }

  Color _getIconColor() {
    switch (mode) {
      case 'Offers Made':
        return Colors.orange.shade400;
      case 'Offers Received':
        return Colors.green.shade400;
      case 'Offers Completed':
        return Colors.purple.shade400;
      default:
        return Colors.blue.shade400;
    }
  }

  String _getTitle() {
    switch (mode) {
      case 'Offers Made':
        return 'Belum Ada Tawaran Dibuat';
      case 'Offers Received':
        return 'Belum Ada Tawaran Masuk';
      case 'Offers Completed':
        return 'Belum Ada Tawaran Selesai';
      default:
        return 'Belum Ada Tawaran';
    }
  }

  String _getDescription() {
    switch (mode) {
      case 'Offers Made':
        return 'Anda belum membuat tawaran apapun.\nMulai jelajahi barang menarik dan buat tawaran pertama Anda!';
      case 'Offers Received':
        return 'Belum ada yang tertarik dengan barang Anda.\nPastikan foto dan deskripsi barang menarik untuk mendapat tawaran!';
      case 'Offers Completed':
        return 'Belum ada transaksi yang diselesaikan.\nSelesaikan tawaran yang sedang berjalan untuk melihat riwayat di sini!';
      default:
        return 'Mulai petualangan tukar-menukar Anda!\nJelajahi barang menarik dan buat tawaran pertama.';
    }
  }

  List<Color> _getButtonGradientColors() {
    switch (mode) {
      case 'Offers Made':
        return [Colors.orange.shade400, Colors.red.shade400];
      case 'Offers Received':
        return [Colors.green.shade400, Colors.teal.shade400];
      case 'Offers Completed':
        return [Colors.purple.shade400, Colors.indigo.shade400];
      default:
        return [Colors.blue.shade400, Colors.purple.shade400];
    }
  }

  Color _getButtonShadowColor() {
    switch (mode) {
      case 'Offers Made':
        return Colors.orange.withOpacity(0.3);
      case 'Offers Received':
        return Colors.green.withOpacity(0.3);
      case 'Offers Completed':
        return Colors.purple.withOpacity(0.3);
      default:
        return Colors.blue.withOpacity(0.3);
    }
  }

  IconData _getButtonIcon() {
    switch (mode) {
      case 'Offers Made':
        return Icons.explore_rounded;
      case 'Offers Received':
        return Icons.add_circle_rounded;
      case 'Offers Completed':
        return Icons.history_rounded;
      default:
        return Icons.explore_rounded;
    }
  }

  String _getButtonText() {
    switch (mode) {
      case 'Offers Made':
        return 'Mulai Jelajahi';
      case 'Offers Received':
        return 'Tambah Barang';
      case 'Offers Completed':
        return 'Lihat Aktif';
      default:
        return 'Mulai Jelajahi';
    }
  }

  void _handleButtonPress(BuildContext context) {
    switch (mode) {
      case 'Offers Made':
        // Navigasi ke halaman explore/jelajahi
        // Navigator.pushNamed(context, '/explore');
        // atau menggunakan tab controller
        // DefaultTabController.of(context)?.animateTo(0);
        print('Navigate to Explore page');
        break;
        
      case 'Offers Received':
        // Navigasi ke halaman tambah barang
        // Navigator.pushNamed(context, '/add-item');
        print('Navigate to Add Item page');
        break;
        
      case 'Offers Completed':
        // Navigasi ke halaman tawaran aktif
        // Navigator.pushNamed(context, '/active-offers');
        // atau pindah ke tab tawaran aktif
        print('Navigate to Active Offers');
        break;
        
      default:
        print('Default action');
        break;
    }
  }
}