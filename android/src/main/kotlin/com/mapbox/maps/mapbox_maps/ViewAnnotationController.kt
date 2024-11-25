package com.mapbox.maps.mapbox_maps

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.TextView
import com.mapbox.geojson.Point
import com.mapbox.maps.MapView
import com.mapbox.maps.ViewAnnotationOptions
import com.mapbox.maps.viewannotation.ViewAnnotationManager
import com.mapbox.maps.viewannotation.geometry
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

class ViewAnnotationController(private val mapView: MapView, private val context: Context) {

  private val viewAnnotationManager: ViewAnnotationManager = mapView.viewAnnotationManager

  fun addViewAnnotation(call: MethodCall, result: MethodChannel.Result) {
    val latitude = call.argument<Double>("latitude")
    val longitude = call.argument<Double>("longitude")
    val text = call.argument<String>("text")

    if (latitude != null && longitude != null && text != null) {
      // Inflate the custom view layout
      val inflater = LayoutInflater.from(context)
      val customView: View = inflater.inflate(R.layout.view_annotation_layout, null)

      // Set the custom text on the view
      val textView = customView.findViewById<TextView>(R.id.annotation_text)
      textView.text = text

      // Add the view annotation to the map
      viewAnnotationManager.addViewAnnotation(
        customView,
        ViewAnnotationOptions.Builder()
          .geometry(Point.fromLngLat(longitude, latitude))
          .build()
      )

      result.success(null)
    } else {
      result.error("INVALID_ARGUMENTS", "Latitude, longitude, or text is null", null)
    }

  }
}
