import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/admin/cubits/station_form/station_form_cubit.dart';
import 'package:setel_geofence/admin/views/admin_page.dart';
import 'package:setel_geofence/admin/views/widgets/add_station_form.dart';
import 'package:formz/formz.dart';
import 'package:setel_geofence/common_widgets/loader.dart';

class AddStationPage extends StatefulWidget {
  @override
  _AddStationPageState createState() => _AddStationPageState();
}

class _AddStationPageState extends State<AddStationPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool enabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StationFormCubit, StationFormState>(
      listener: (BuildContext context, StationFormState state) {
        if (state.status.isSubmissionInProgress) {
          setState(() {
            enabled = false;
          });
        }
        if (state.status.isSubmissionSuccess) {
          setState(() {
            enabled = true;
          });
          Navigator.popUntil(context, ModalRoute.withName(AdminPage.routeName));
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              snap: true,
              floating: true,
              title: Text('Add station'),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AddStationForm(
                  scaffoldKey: _scaffoldKey,
                  formKey: _formKey,
                  enabled: enabled,
                ),
              ),
            )
          ],
        ),
        floatingActionButton: BlocBuilder<StationFormCubit, StationFormState>(
          builder: (BuildContext context, StationFormState state) {
            return FloatingActionButton.extended(
              onPressed: enabled
                  ? () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        BlocProvider.of<StationFormCubit>(context).addStation();
                      } else {
                        _scaffoldKey.currentState
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                            content: Text('Please fill up the required fields'),
                          ));
                      }
                    }
                  : null,
              icon: state.status.isSubmissionInProgress
                  ? const Loader()
                  : const Icon(Icons.save),
              label: const Text('Save'),
            );
          },
        ),
      ),
    );
  }
}
