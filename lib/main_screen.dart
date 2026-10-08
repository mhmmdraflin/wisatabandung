import 'package:flutter/material.dart';
import 'package:wisata_bandung1/detail_screen.dart';
import 'package:wisata_bandung1/model/tourism_place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // Efek iOS Large Title
          const SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: Color(0xFFF2F2F7), // Warna background sistem
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'Wisata Bandung',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5, // Merapatkan huruf khas tipografi Apple
                ),
              ),
            ),
          ),
          // Jarak dan List Item
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final TourismPlace place = tourismPlaceList[index];
                  return _buildAppleStyleCard(context, place);
                },
                childCount: tourismPlaceList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Bantuan untuk Desain Card yang lebih Clean ---
  Widget _buildAppleStyleCard(BuildContext context, TourismPlace place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(place: place);
        }));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0), // Sudut melengkung halus
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), // Bayangan yang SANGAT tipis
              blurRadius: 20.0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Utama
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
              child: Image.asset(
                place.imageAsset,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Teks Info
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700, // Semi-bold
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        place.location,
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}