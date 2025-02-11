import 'package:flutter/material.dart';
import 'package:movies/services/casteservice.dart';
import 'package:movies/modals/casteModel.dart';

class getcasts extends StatefulWidget {
  final int movieId;
  final String type;
  const getcasts({super.key, required this.movieId, required this.type});

  @override
  State<getcasts> createState() => _castsState();
}

class _castsState extends State<getcasts> {
  late Future<List<Cast>> getCast = Future.value([]);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final apiService = ApiService();
    getCast = apiService.fetchCast(widget.movieId, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cast>>(
      future: getCast,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No cast data found.');
        }

        final castList = snapshot.data!;
        return SizedBox(
          height: 70, // Constrain height for the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: castList.length,
            itemBuilder: (context, index) {
              final cast = castList[index];
              return Container(
                // color: Colors.amber,
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 29,
                      backgroundImage: cast.profilePath != null
                          ? NetworkImage(
                              'https://image.tmdb.org/t/p/w200${cast.profilePath}')
                          : const AssetImage('images/person.jpg')
                              as ImageProvider,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cast.knownForDepartment,
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            cast.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
