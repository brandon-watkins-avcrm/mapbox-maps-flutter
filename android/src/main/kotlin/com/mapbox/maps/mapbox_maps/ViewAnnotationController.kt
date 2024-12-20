package com.mapbox.maps.mapbox_maps

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.TextView
import com.mapbox.geojson.Point
import com.mapbox.maps.MapView
import com.mapbox.maps.ViewAnnotationAnchor
import com.mapbox.maps.viewannotation.ViewAnnotationManager
import com.mapbox.maps.viewannotation.annotationAnchor
import com.mapbox.maps.viewannotation.geometry
import com.mapbox.maps.viewannotation.viewAnnotationOptions
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

class ViewAnnotationController(private val mapView: MapView, private val context: Context) {

  private val viewAnnotationManager: ViewAnnotationManager = mapView.viewAnnotationManager
  private val annotationsMap = mutableMapOf<String, View>() // Map to track annotations by ID

  fun addViewAnnotation(call: MethodCall, result: MethodChannel.Result) {
    val viewAnnotationId = call.argument<String>("viewAnnotationId")
    val latitude = call.argument<Double>("latitude")
    val longitude = call.argument<Double>("longitude")

    val title = call.argument<String>("title")
    val body = call.argument<String>("body")

    val titleFontSize = call.argument<Double?>("titleFontSize")
    val bodyFontSize = call.argument<Double?>("bodyFontSize")

    val offsetX = call.argument<Double?>("offsetX") ?: 0.0
    val offsetY = call.argument<Double?>("offsetY") ?: 0.0

    if (viewAnnotationId != null && latitude != null && longitude != null && title != null && body != null) {
      // Inflate the custom view layout
      val inflater = LayoutInflater.from(context)
      val customView: View = inflater.inflate(R.layout.view_annotation_layout, mapView, false)

      // Set the custom text on the view
      val titleTextView = customView.findViewById<TextView>(R.id.annotation_title_text)
      titleTextView.text = title

      if (titleFontSize != null) {
        titleTextView.textSize = titleFontSize.toFloat()
      }

      val bodyTextView = customView.findViewById<TextView>(R.id.annotation_body_text)
      bodyTextView.text = body

      if (bodyFontSize != null) {
        bodyTextView.textSize = bodyFontSize.toFloat()
      }

      // Add the view annotation to the map
      viewAnnotationManager.addViewAnnotation(
        customView,
        viewAnnotationOptions {
          geometry(Point.fromLngLat(longitude, latitude))
          annotationAnchor {
            anchor(ViewAnnotationAnchor.BOTTOM)
            offsetX(offsetX)
            offsetY(offsetY)
          }
          allowOverlap(true)
        }
      )

      // Store the annotation view by ID
      annotationsMap[viewAnnotationId] = customView

      result.success(null)
    } else {
      result.error("INVALID_ARGUMENTS", "Latitude, longitude, or text is null", null)
    }
  }

  fun updateViewAnnotation(call: MethodCall, result: MethodChannel.Result) {
    val viewAnnotationId = call.argument<String>("viewAnnotationId")
    val latitude = call.argument<Double>("latitude")
    val longitude = call.argument<Double>("longitude")

    val title = call.argument<String>("title")
    val body = call.argument<String>("body")

    val titleFontSize = call.argument<Double?>("titleFontSize")
    val bodyFontSize = call.argument<Double?>("bodyFontSize")

    if (viewAnnotationId != null && latitude != null && longitude != null && title != null && body != null) {
      val customView = annotationsMap[viewAnnotationId]

      if (customView != null) {
        viewAnnotationManager.updateViewAnnotation(
          customView,
          viewAnnotationOptions {
            geometry(Point.fromLngLat(longitude, latitude))
          }
        )

        val titleTextView = customView.findViewById<TextView>(R.id.annotation_title_text)
        titleTextView.text = title

        if (titleFontSize != null) {
          titleTextView.textSize = titleFontSize.toFloat()
        }

        val bodyTextView = customView.findViewById<TextView>(R.id.annotation_body_text)
        bodyTextView.text = body

        if (bodyFontSize != null) {
          bodyTextView.textSize = bodyFontSize.toFloat()
        }

        result.success(null)
      } else {
        result.error("ANNOTATION_NOT_FOUND", "No annotation found with id $viewAnnotationId", null)
      }
    } else {
      result.error("INVALID_ARGUMENTS", "ID or text is null", null)
    }
  }

  fun removeViewAnnotation(call: MethodCall, result: MethodChannel.Result) {
    val viewAnnotationId = call.argument<String>("viewAnnotationId")

    if (viewAnnotationId != null) {
      val customView = annotationsMap[viewAnnotationId]
      if (customView != null) {
        viewAnnotationManager.removeViewAnnotation(customView)
        annotationsMap.remove(viewAnnotationId)
        result.success(null)
      } else {
        result.error("ANNOTATION_NOT_FOUND", "No annotation found with id $viewAnnotationId", null)
      }
    } else {
      result.error("INVALID_ARGUMENTS", "ID is null", null)
    }
  }

  fun viewAnnotationExists(call: MethodCall, result: MethodChannel.Result) {
    val viewAnnotationId = call.argument<String>("viewAnnotationId")

    if (viewAnnotationId != null) {
      val customView = annotationsMap[viewAnnotationId]

      result.success(customView != null)
    } else {
      result.error("INVALID_ARGUMENTS", "ID is null", null)
    }
  }
}
