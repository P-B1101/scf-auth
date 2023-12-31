import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/components/custom/location_pin_widget.dart';
import '../../../../core/utils/ui_utils.dart';

class MMapWidget extends StatefulWidget {
  final double? lat;
  final double? lng;
  final Function(double lat, double lng)? onLocationSelected;
  final bool updateCamera;
  const MMapWidget({
    super.key,
    required this.lat,
    required this.lng,
    this.onLocationSelected,
    this.updateCamera = true,
  });

  @override
  State<MMapWidget> createState() => _MMapWidgetState();
}

class _MMapWidgetState extends State<MMapWidget> {
  final _controller = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final latlng = _hasLatLng
          ? LatLng(widget.lat!, widget.lng!)
          : const LatLng(35.778227, 51.418700);
      _controller.move(latlng, 17);
    });
  }

  @override
  void didUpdateWidget(covariant MMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.lat != widget.lat || oldWidget.lng != widget.lng) &&
        widget.updateCamera) {
      final latlng = _hasLatLng
          ? LatLng(widget.lat!, widget.lng!)
          : const LatLng(35.778227, 51.418700);
      _controller.move(latlng, 17);
    }
  }

  @override
  Widget build(BuildContext context) {
    final latlng = _hasLatLng
        ? LatLng(widget.lat!, widget.lng!)
        : const LatLng(35.778227, 51.418700);
    return SizedBox(
      width: UiUtils.mapSize,
      height: UiUtils.mapSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FlutterMap(
          mapController: _controller,
          options: MapOptions(
            interactiveFlags: widget.onLocationSelected != null
                ? InteractiveFlag.all
                : InteractiveFlag.none,
            minZoom: 10,
            maxZoom: 17,
            center: latlng,
            zoom: 17,
            onTap: (tapPosition, point) => widget.onLocationSelected
                ?.call(point.latitude, point.longitude),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: [
                if (_hasLatLng)
                  Marker(
                    point: latlng,
                    builder: (context) => const LocationPinWidget(size: 42),
                    width: 42,
                    height: 42,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool get _hasLatLng => widget.lat != null && widget.lng != null;
}
