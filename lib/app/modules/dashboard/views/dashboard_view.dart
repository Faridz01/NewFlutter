import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tokoonline/app/data/entertainment_response.dart';
import 'package:tokoonline/app/data/headline_response.dart';
import 'package:tokoonline/app/data/sports_response.dart';
import 'package:tokoonline/app/data/technology_response.dart';
import 'package:tokoonline/app/modules/home/views/home_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();
    final auth = GetStorage();
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'Hallo',
                    textAlign: TextAlign.end,
                  ),
                  subtitle: Text(
                     auth.read('full_name').toString(),
                    textAlign: TextAlign.end,
                  ),
                  trailing: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 50.0,
                    height: 50.0,
                    child: Lottie.network(
                      'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: 'Headdline'),
                      Tab(text: 'Teknologi'),
                      Tab(text: "Olahraga"),
                      Tab(text: "Hiburan"),
                      Tab (text: 'Profile'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              headline(controller, scrollController),
              teknologi(controller, scrollController),
              spotrs(controller, scrollController),
              entertainment(controller, scrollController),
              profile(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await auth.erase();
            Get.offAll(() => HomeView());
          },
  backgroundColor: Colors.redAccent,
  child: const Icon(Icons.logout_rounded),
),
        ),
      ),
    );
  }

  // Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
  FutureBuilder<HeadlineResponse> headline (DashboardController controller, ScrollController scrollController){
    return FutureBuilder<HeadlineResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getHeadline(),
    builder: (context, snapshot) {
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
      // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }
       // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
       return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Container(
            padding: const EdgeInsets.only(
              top: 5,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 110,
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    snapshot.data!.data![index].urlToImage.toString(),
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Text(
                        snapshot.data!.data![index].title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('Author : ${snapshot.data!.data![index].author}'),
                          Text('Sumber :${snapshot.data!.data![index].name}'),
                        ],
                      ),
                    ],
                  ),
                ),
               ],
            ),
          );
        }
       );
      }
    );
  }

      // Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
  FutureBuilder<TechnologyResponse> teknologi(DashboardController controller, ScrollController scrollController){
    return FutureBuilder<TechnologyResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getTechnology(),
    builder: (context, snapshot) {
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
      // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }
       // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
       return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Container(
            padding: const EdgeInsets.only(
              top: 5,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 110,
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    snapshot.data!.data![index].urlToImage.toString(),
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Text(
                        snapshot.data!.data![index].title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('Author : ${snapshot.data!.data![index].author}'),
                          Text('Sumber :${snapshot.data!.data![index].name}'),
                        ],
                      ),
                    ],
                  ),
                ),
               ],
            ),
          );
        }
       );
      }
    );
  }

        // Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
  FutureBuilder<SportsResponse> spotrs(DashboardController controller, ScrollController scrollController){
    return FutureBuilder<SportsResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getSport(),
    builder: (context, snapshot) {
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
      // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }
       // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
       return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Container(
            padding: const EdgeInsets.only(
              top: 5,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 110,
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    snapshot.data!.data![index].urlToImage.toString(),
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Text(
                        snapshot.data!.data![index].title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('Author : ${snapshot.data!.data![index].author}'),
                          Text('Sumber :${snapshot.data!.data![index].name}'),
                        ],
                      ),
                    ],
                  ),
                ),
               ],
            ),
          );
        }
       );
      }
    );
  }
  // Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
  FutureBuilder<EntertainmentResponse> entertainment (DashboardController controller, ScrollController scrollController){
    return FutureBuilder<EntertainmentResponse>(
    // Mendapatkan future data headline dari controller
    future: controller.getEntertainment(),
    builder: (context, snapshot) {
      // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Lottie.network(
            // Menggunakan animasi Lottie untuk tampilan loading
            'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
            repeat: true,
            width: MediaQuery.of(context).size.width / 1,
          ),
        );
      }
      // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
      if (!snapshot.hasData) {
        return const Center(child: Text("Tidak ada data"));
      }
       // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
       return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        controller: scrollController,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return Container(
            padding: const EdgeInsets.only(
              top: 5,
              left: 8,
              right: 8,
              bottom: 5,
            ),
            height: 110,
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    snapshot.data!.data![index].urlToImage.toString(),
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                      Text(
                        snapshot.data!.data![index].title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('Author : ${snapshot.data!.data![index].author}'),
                          Text('Sumber :${snapshot.data!.data![index].name}'),
                        ],
                      ),
                    ],
                  ),
                ),
               ],
            ),
          );
        }
       );
      }
    );
  }
  SingleChildScrollView profile() {
    return SingleChildScrollView(
      child: 
       Column(
        children: [
          Lottie.network(
            'https://assets1.lottiefiles.com/packages/lf20_WaQ8yMJuKt.json',
            height: Get.size.height / 4,
          ),
          Text(
            'Visit Me',
            style: GoogleFonts.pressStart2p(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(FeatherIcons.github),
                  color: Colors.black,
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse('https://github.com/Faridz01'))) {
                      throw Exception('Could not launch');
                    }
                  },
                  iconSize: 40,
                ),
                // IconButton(
                //   icon: const Icon(FeatherIcons.globe),
                //   color: Colors.indigo,
                //   onPressed: () async {
                //     if (!await launchUrl(Uri.parse(''))) {
                //       throw Exception('Could not launch');
                //     }
                //   },
                //   iconSize: 40,
                // ),
                // IconButton(
                //   icon: const Icon(FeatherIcons.),
                //   color: Colors.blueAccent,
                //   onPressed: () async {
                //     if (!await launchUrl(Uri.parse(''))) {
                //       throw Exception('Could not launch');
                //     }
                //   },
                //   iconSize: 40,
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Hello.. My name Faridzhk_. Im a backend & mobile developer near Bandung. Coding has become a perfect union of my two favourite passions and I love seeing the results of my efforts helping the users experience. I’m finding unique solutions to complex problems and I’m doing it all while making the worst puns you’ve never heard before.',
              style: GoogleFonts.pressStart2p(
                fontSize: 12,
                height: 2,
                textStyle: const TextStyle(
                  letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }
}

