import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/backend/globals.dart';
import 'package:weather/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/home/widgets/locations_list.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/settings/settings_page.dart';
import 'package:weather/theme/app_theme.dart';
import 'package:weather/theme/theme_provider.dart';
import 'package:weather/widgets/error_card.dart';
import 'package:weather/widgets/loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => const HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        context.read<Backend>().weatherRepository,
      ),
      child: HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  List<int> homeList = List.empty();
  late AnimationController animationController;
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final nameController = TextEditingController();
  final formKeyLat = GlobalKey<FormState>();
  final formKeyLong = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context, listen: true).theme;
    return Scaffold(
      key: myGlobals.scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Weather',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.push(
            context,
            SettingsPage.route(),
          ),
        ),
      ),
      backgroundColor: theme.backgroundColor,
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: BlocProvider.of<HomeBloc>(context),
        builder: (context, state) {
          if (state is Error)
            return ErrorCard(
              errorMessage: '',
            );
          else if (state is LocationsCollected)
            return _buildPage(
              context,
              state.locations,
              theme,
            );
          else if (state is Loading) {
            return Loader();
          } else
            return _buildPage(
              context,
              null,
              theme,
            );
        },
      ),
    );
  }

  Widget _buildPage(
      BuildContext context, List<Location>? locations, AppTheme theme) {
    final node = FocusScope.of(context);
    final focus = FocusNode();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Card(
            color: theme.backgroundSecondaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Search location by name',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter searching location name',
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (value) {
                        BlocProvider.of<HomeBloc>(context).add(
                          FindLocationByNameEvent(locationName: value),
                        );
                      },
                      onTap: nameController.clear,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: theme.backgroundSecondaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Search location by coordinates',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: formKeyLat,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lattitude cannot be empty';
                        } else if (value.contains('other')) {
                          return 'Incorrect format';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: latitudeController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Enter lattitude, format eg. 50.068',
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (value) {
                        node.requestFocus(focus);
                      },
                      onTap: latitudeController.clear,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: formKeyLong,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Longitude cannot be empty';
                        } else if (value.contains('other')) {
                          return 'Incorrect format';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      focusNode: focus,
                      controller: longitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Enter longitude, format eg. -5.316',
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (value) {
                        if (formKeyLong.currentState!.validate() &&
                            formKeyLat.currentState!.validate()) {
                          BlocProvider.of<HomeBloc>(context).add(
                            FindLocationByCoordinatesEvent(
                                lattitude: latitudeController.text,
                                longitude: value),
                          );
                        }
                      },
                      onTap: longitudeController.clear,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (locations != null)
            LocationsList(
              locations: locations,
            )
        ],
      ),
    );
  }
}
