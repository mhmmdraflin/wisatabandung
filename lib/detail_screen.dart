import 'package:flutter/material.dart';
import 'dart:ui'; // Wajib di-import untuk efek BackdropFilter (Frosted Glass)
import 'package:wisata_bandung1/model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Edge-to-Edge & Tombol Navigasi Melayang
            Stack(
              children: [
                Image.asset(
                  place.imageAsset,
                  width: double.infinity,
                  height: 380,
                  fit: BoxFit.cover, // Gambar proporsional memenuhi ruang
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol Back dengan efek Frosted Glass
                        _buildFrostedButton(
                          icon: Icons.arrow_back_ios_new, // Icon panah khas iOS
                          onTap: () => Navigator.pop(context),
                        ),
                        // Tombol Favorite
                        const FavoriteButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 2. Area Konten
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5, // Merapatkan spasi antar huruf
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Lokasi
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey, size: 20),
                      const SizedBox(width: 4.0),
                      Text(
                        place.location,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),

                  // Container Info (Buka, Jam, Tiket) ala Apple
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F7), // Warna System Gray 6 khas iOS
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoItem(Icons.calendar_today, place.openDays),
                        _buildInfoItem(Icons.access_time, place.openTime),
                        _buildInfoItem(Icons.monetization_on, place.ticketPrice),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),

                  // Deskripsi
                  const Text(
                    'Tentang',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    place.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.6, // Jarak antar baris diperlebar agar nyaman dibaca
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30.0),

                  // Galeri
                  const Text(
                    'Galeri',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: place.imageUrls.map((url) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              url,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 50.0), // Spasi kosong di paling bawah
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN ---

  // Fungsi untuk membuat tombol melayang dengan efek kaca buram (Frosted Glass)
  Widget _buildFrostedButton({required IconData icon, required VoidCallback onTap}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Sudut membulat
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Intensitas blur
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25), // Transparansi latar hitam
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menyusun item info (ikon & teks) agar seragam
  Widget _buildInfoItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.black87, size: 24),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

// --- KELAS: FavoriteButton ---
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // Kita juga menerapkan Frosted Glass pada tombol favorit
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: InkWell(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              // Jika favorit, warna merah cerah, jika tidak, putih biasa
              color: isFavorite ? Colors.redAccent : Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}