import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: CountryGrid(),
    );
  }
}

class CountryGrid extends StatelessWidget {
  final List<Map<String, String>> countries = [
    {
      'flag': 'https://flagcdn.com/w320/bd.png',
      'title': 'Bangladesh is a beautiful country.\nIt has many rivers.\nIt’s full of greenery.',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/us.png',
      'title': 'USA is a developed country.\nIt’s known for technology.\nAlso famous for freedom.',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/gb.png',
      'title': 'UK is a historic country.\nHas royal traditions.\nAnd iconic landmarks.',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/in.png',
      'title': 'India is a diverse country.\nMany cultures exist.\nUnity in diversity.',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/ca.png',
      'title': 'Canada is a peaceful country.\nKnown for maple leaves.\nAnd cold winters.',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/de.png',
      'title': 'Germany is a tech hub.\nFamous for cars.\nStrong economy.',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/fr.png',
      'title': 'France is romantic.\nCity of love – Paris.\nAlso rich in culture.',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/jp.png',
      'title': 'Japan is innovative.\nTechnology and tradition.\nLand of the rising sun.',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/au.png',
      'title': 'Australia is sunny.\nFamous for beaches.\nAnd kangaroos!',
      'info': '👥 Population 🗺️ Places',
    },
    {
      'flag': 'https://flagcdn.com/w320/nz.png',
      'title': 'New Zealand is scenic.\nMountains and lakes.\nGreat for hiking.',
      'info': '👥 Population 🗺️ Places',
    },
  ];

  int getCrossAxisCount(double width) {
    if (width < 600) return 2;        // Mobile
    if (width < 1024) return 3;       // Tablet
    return 4;                         // Web/Desktop
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Country Info Grid")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = getCrossAxisCount(constraints.maxWidth);

          return Center(
            child: Container(
              padding: EdgeInsets.all(12),
              constraints: BoxConstraints(maxWidth: 1100), // web e limit kore রাখলাম
              child: Scrollbar(
                thumbVisibility: true,
                child: GridView.builder(
                  itemCount: countries.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    return CountryCard(country: countries[index]);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final Map<String, String> country;

  const CountryCard({required this.country});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double titleFont = width < 600 ? 13 : 15;
    double infoFont = width < 600 ? 11 : 13;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              country['flag']!,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country['info']!,
                        style: TextStyle(fontSize: infoFont),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        country['title']!,
                        style: TextStyle(
                          fontSize: titleFont,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Details'),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
