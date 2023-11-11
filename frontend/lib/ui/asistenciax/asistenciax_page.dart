import 'package:asistenciaupeu_frontend/apis/actividad_api.dart';
import 'package:asistenciaupeu_frontend/apis/asistenciax_api.dart';
import 'package:asistenciaupeu_frontend/comp/DropDownFormField.dart';
import 'package:asistenciaupeu_frontend/modelo/AsistenciaxModelo.dart';
import 'package:asistenciaupeu_frontend/theme/AppTheme.dart';
import 'package:asistenciaupeu_frontend/ui/asistenciax/movie_model.dart';
import 'package:asistenciaupeu_frontend/util/TokenUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AsistenciaxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ActividadApi>(create: (_) => ActividadApi.create(),),
        Provider<AsistenciaxApi>(create: (_) => AsistenciaxApi.create(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeDataLight,
        darkTheme: AppTheme.themeDataDark,
        home: AsistenciaxHPage(),
      ),
    );
  }
}

class AsistenciaxHPage extends StatefulWidget {
  const AsistenciaxHPage({super.key});

  @override
  State<AsistenciaxHPage> createState() => _HomePageState();
}

class _HomePageState extends State<AsistenciaxHPage> {
  late AsistenciaxApi apiService;
  final _controller = TextEditingController();

  //* main movies
  late List<MovieModel> mainMovie = [];
  late List<MovieModel> secMovie;

  List<Map<String, String>> lista=[];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    setState(() {
      _isLoading = true;
      apiService = AsistenciaxApi.create();
      //var dd=apiService.getAsistenciapa(TokenUtil.TOKEN);
      mainMovie.clear();
      lista.clear();
      lista.add({'value': '0', 'display': 'Seleccione...'});
      Provider.of<ActividadApi>(context, listen: false).getActividad(TokenUtil.TOKEN).then((data) {
        data.forEach((element) {
          mainMovie.add(
              MovieModel(
              movieTitle: element.nombreActividad,
              movieRating: element.id,
              moviePoster:
              "https://m.media-amazon.com/images/M/MV5BMjFmZjYwNGUtYzE1NC00YTllLThmZDctODc3NDExYTY3NTM3XkEyXkFqcGdeQXVyOTk3NTc2MzE@._V1_UX67_CR0,0,67,98_AL_.jpg",
              movieRelease: "2016")
          );
          lista.add({'value': element.id.toString(), 'display': element.nombreActividad});
        });
        print("Holassss");
      });
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      secMovie = List.from(mainMovie);
      _isLoading = false;
    });
  }

  _loadDataAsistencia() async {
    print("Reporte asistencia de:"+_estado);
    setState(() {
      mainMovie.clear();
      Provider.of<AsistenciaxApi>(context, listen: false).getAsistenciapa(TokenUtil.TOKEN).then((data) {
        data.forEach((element) {
          mainMovie.add(
              MovieModel(
                  movieTitle: element.actividadId.nombreActividad,
                  movieRating: element.id,
                  moviePoster:
                  "https://m.media-amazon.com/images/M/MV5BMjFmZjYwNGUtYzE1NC00YTllLThmZDctODc3NDExYTY3NTM3XkEyXkFqcGdeQXVyOTk3NTc2MzE@._V1_UX67_CR0,0,67,98_AL_.jpg",
                  movieRelease: element.cui)
          );
        });
      });
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      secMovie = List.from(mainMovie);
    });
  }

  //* update function
  void updateList(String value) {
    setState(() {
      secMovie = mainMovie
          .where(
            (element) => element.movieTitle.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
  }
  late String _estado="0";


  void capturaEstado(valor){ this._estado=valor;
  print("Holas:"+_estado);
  _loadDataAsistencia();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeDataLight,
      darkTheme: AppTheme.themeDataDark,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Listar Asistencia",
          ),
          centerTitle: true,
        ),

        //* body
        body: _isLoading?Center(child: CircularProgressIndicator(),)
        : Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),

              _buildDatoLista(capturaEstado,_estado, "Actividad:", lista),

              //* search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: TextFormField(
                  onChanged: (value) => updateList(value),
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Search by Movie Title",
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear_sharp,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          _controller.clear();
                        }),
                    //fillColor: const Color.fromARGB(95, 119, 68, 50),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              //* List view
              Expanded(
                child: ListView.builder(
                    itemCount: secMovie.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(
                          secMovie[index].movieTitle,
                          //style: myTextTheme,
                        ),
                        subtitle: Text(
                          secMovie[index].movieRelease,
                          //style: myTextTheme,
                        ),
                        trailing: Text(
                          secMovie[index].movieRating.toString(),
                          //style: myTextTheme,
                        ),
                        leading: Image.network(secMovie[index].moviePoster),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDatoLista(Function obtValor,_dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: _dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }
}
