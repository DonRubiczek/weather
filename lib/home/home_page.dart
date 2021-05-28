import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/backend.dart';
import 'package:weather/backend/globals.dart';
import 'package:weather/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/home/widgets/home_form.dart';
import 'package:weather/home/widgets/locations_list.dart';
import 'package:weather/repository/model/location.dart';
import 'package:weather/settings/settings_page.dart';
import 'package:weather/widgets/error_card.dart';
import 'package:weather/widgets/loader.dart';
import 'package:weather/theme/app_specific_theme.dart';

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
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final nameController = TextEditingController();
  final formKeyLat = GlobalKey<FormState>();
  final formKeyLong = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          key: const Key(
            'homeAppBarSettingsButton',
          ),
          icon: const Icon(
            Icons.settings,
          ),
          onPressed: () => Navigator.push(
            context,
            SettingsPage.route(),
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is Error)
            return _buildPage(
              context,
              null,
              ErrorCard(
                errorMessage: '',
              ),
            );
          else if (state is LocationsCollected)
            return _buildPage(
              context,
              state.locations,
              null,
            );
          else if (state is Loading) {
            return Loader();
          } else
            return _buildPage(
              context,
              null,
              null,
            );
        },
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    List<Location>? locations,
    Widget? errorCard,
  ) {
    final node = FocusScope.of(context);
    final focus = FocusNode();

    return Container(
      color: context.theme.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Card(
              color: context.theme.backgroundSecondaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Search location by name',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: context.theme.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    HomeForm(
                      formFieldKey: const Key(
                        'searchLocationByNameField',
                      ),
                      controller: nameController,
                      labelText: 'Enter searching location name',
                      onFieldSubmitted: (value) =>
                          BlocProvider.of<HomeBloc>(context).add(
                        FindLocationByNameEvent(
                          locationName: value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: context.theme.backgroundSecondaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Search location by coordinates',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: context.theme.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    HomeForm(
                      formKey: formKeyLat,
                      formFieldKey: const Key(
                        'searchLocationByCoordinatesLattitudeField',
                      ),
                      controller: latitudeController,
                      labelText: 'Enter lattitude, format eg. 50.068',
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lattitude cannot be empty';
                        } else if (value.contains('other')) {
                          return 'Incorrect format';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) => node.requestFocus(focus),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    HomeForm(
                      formKey: formKeyLong,
                      formFieldKey: const Key(
                        'searchLocationByCoordinatesLongitudeField',
                      ),
                      controller: longitudeController,
                      labelText: 'Enter longitude, format eg. -5.316',
                      textInputType: TextInputType.number,
                      focus: focus,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Longitude cannot be empty';
                        } else if (value.contains('other')) {
                          return 'Incorrect format';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (formKeyLong.currentState!.validate() &&
                            formKeyLat.currentState!.validate()) {
                          BlocProvider.of<HomeBloc>(context).add(
                            FindLocationByCoordinatesEvent(
                              lattitude: latitudeController.text,
                              longitude: value,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (locations != null)
              LocationsList(
                locations: locations,
              ),
            const SizedBox(
              height: 10,
            ),
            errorCard ?? Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();

    super.dispose();
  }
}
