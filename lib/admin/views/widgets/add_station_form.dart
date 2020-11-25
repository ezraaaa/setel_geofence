import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:setel_geofence/admin/cubits/station_form/station_form_cubit.dart';

class AddStationForm extends StatefulWidget {
  const AddStationForm({
    @required this.scaffoldKey,
    @required this.formKey,
    @required this.enabled,
  });
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final bool enabled;

  @override
  _AddStationFormState createState() => _AddStationFormState();
}

class _AddStationFormState extends State<AddStationForm> {
  final FocusNode _nameNode = FocusNode();
  final FocusNode _latitudeNode = FocusNode();
  final FocusNode _longitudeNode = FocusNode();
  final FocusNode _radiusNode = FocusNode();
  final FocusNode _ssidNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Wrap(
        runSpacing: 16.0,
        children: <Widget>[
          BlocBuilder<StationFormCubit, StationFormState>(
            buildWhen: (StationFormState previous, StationFormState current) =>
                previous.name != current.name,
            builder: (BuildContext context, StationFormState state) {
              return TextFormField(
                enabled: widget.enabled,
                decoration: const InputDecoration(
                  labelText: 'Station name *',
                ),
                autofocus: true,
                focusNode: _nameNode,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (String term) {
                  _nameNode.unfocus();
                  FocusScope.of(context).requestFocus(_latitudeNode);
                },
                validator: (String value) {
                  return state.name.invalid || value.isEmpty
                      ? 'Station name required'
                      : null;
                },
                onChanged: (String value) {
                  context.read<StationFormCubit>().nameChanged(value);
                },
              );
            },
          ),
          BlocBuilder<StationFormCubit, StationFormState>(
            buildWhen: (StationFormState previous, StationFormState current) =>
                previous.latitude != current.latitude,
            builder: (BuildContext context, StationFormState state) {
              return TextFormField(
                enabled: widget.enabled,
                decoration: const InputDecoration(
                  labelText: 'Latitude *',
                ),
                focusNode: _latitudeNode,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (String term) {
                  _latitudeNode.unfocus();
                  FocusScope.of(context).requestFocus(_longitudeNode);
                },
                validator: (String value) {
                  return state.latitude.invalid || value.isEmpty
                      ? 'Latitude required'
                      : null;
                },
                onChanged: (String value) {
                  context.read<StationFormCubit>().latitudeChanged(value);
                },
              );
            },
          ),
          BlocBuilder<StationFormCubit, StationFormState>(
            buildWhen: (StationFormState previous, StationFormState current) =>
                previous.longitude != current.longitude,
            builder: (BuildContext context, StationFormState state) {
              return TextFormField(
                enabled: widget.enabled,
                decoration: const InputDecoration(
                  labelText: 'Longitude *',
                ),
                focusNode: _longitudeNode,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (String term) {
                  _longitudeNode.unfocus();
                  FocusScope.of(context).requestFocus(_radiusNode);
                },
                validator: (String value) {
                  return state.longitude.invalid || value.isEmpty
                      ? 'Longitude required'
                      : null;
                },
                onChanged: (String value) {
                  context.read<StationFormCubit>().longitudeChanged(value);
                },
              );
            },
          ),
          BlocBuilder<StationFormCubit, StationFormState>(
            buildWhen: (StationFormState previous, StationFormState current) =>
                previous.radius != current.radius,
            builder: (BuildContext context, StationFormState state) {
              return TextFormField(
                enabled: widget.enabled,
                decoration: const InputDecoration(
                  labelText: 'Radius (m) *',
                ),
                focusNode: _radiusNode,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (String term) {
                  _radiusNode.unfocus();
                  FocusScope.of(context).requestFocus(_ssidNode);
                },
                validator: (String value) {
                  return state.radius.invalid || value.isEmpty
                      ? 'Radius required'
                      : null;
                },
                onChanged: (String value) {
                  context.read<StationFormCubit>().radiusChanged(value);
                },
              );
            },
          ),
          BlocBuilder<StationFormCubit, StationFormState>(
            buildWhen: (StationFormState previous, StationFormState current) =>
                previous.ssid != current.ssid,
            builder: (BuildContext context, StationFormState state) {
              return TextFormField(
                enabled: widget.enabled,
                decoration: const InputDecoration(
                  labelText: 'WiFi name *',
                ),
                focusNode: _ssidNode,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (String term) {
                  _ssidNode.unfocus();
                  if (widget.formKey.currentState.validate()) {
                    widget.formKey.currentState.save();
                    context.read<StationFormCubit>().addStation();
                  } else {
                    widget.scaffoldKey.currentState
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(
                        content: Text('Please fill up the required fields'),
                      ));
                  }
                },
                validator: (String value) {
                  return state.ssid.invalid || value.isEmpty
                      ? 'WiFi name required'
                      : null;
                },
                onChanged: (String value) {
                  context.read<StationFormCubit>().ssidChanged(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
