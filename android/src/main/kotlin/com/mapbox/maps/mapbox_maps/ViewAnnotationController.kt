package com.mapbox.maps.mapbox_maps

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.TextView
import com.mapbox.geojson.Point
import com.mapbox.maps.MapView
import com.mapbox.maps.ViewAnnotationAnchor
import com.mapbox.maps.ViewAnnotationOptions
import com.mapbox.maps.viewannotation.ViewAnnotationManager
import com.mapbox.maps.viewannotation.annotatedLayerFeature
import com.mapbox.maps.viewannotation.annotationAnchor
import com.mapbox.maps.viewannotation.geometry
import com.mapbox.maps.viewannotation.viewAnnotationOptions
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall

class ViewAnnotationController(private val mapView: MapView, private val context: Context) {

  private val viewAnnotationManager: ViewAnnotationManager = mapView.viewAnnotationManager
  private val annotationsMap = mutableMapOf<String, View>() // Map to track annotations by ID

  fun addViewAnnotationOnFeature(call: MethodCall, result: MethodChannel.Result) {
    val viewAnnotationId = call.argument<String>("viewAnnotationId")
    val featureId = call.argument<String>("featureId")
    val layerId = call.argument<String>("layerId")

    val title = call.argument<String>("title")
    val body = call.argument<String>("body")

    val offsetXx = call.argument<Double?>("offsetX") ?: 0.0
    val offsetYy = call.argument<Double?>("offsetY") ?: 0.0

    if (viewAnnotationId != null && featureId != null && layerId != null && title != null && body != null) {
      // Inflate the custom view layout
      val inflater = LayoutInflater.from(context)
      val customView: View = inflater.inflate(R.layout.view_annotation_layout, mapView, false)

      // Set the custom text on the view
      val titleTextView = customView.findViewById<TextView>(R.id.annotation_title_text)
      titleTextView.text = title

      val bodyTextView = customView.findViewById<TextView>(R.id.annotation_body_text)
      bodyTextView.text = body

      // add view annotation attached to the feature
      viewAnnotationManager.addViewAnnotation(
        customView,
        viewAnnotationOptions {
          annotatedLayerFeature(layerId) {
            featureId(featureId)
          }
//          offsetX(offsetX)
//          offsetY(offsetY)
        }
      )

//      // Add the view annotation to the map
//      viewAnnotationManager.updateViewAnnotation(
//        customView,
//        viewAnnotationOptions {
//          geometry(Point.fromLngLat(longitude, latitude))
//          annotationAnchor {
//            // bottom of the view annotation is placed on the geometry
//            anchor(ViewAnnotationAnchor.BOTTOM)
//            offsetX(offsetX)
//            offsetY(offsetY)
//          }
//        }
//      )

      // Store the annotation view by ID
      annotationsMap[viewAnnotationId] = customView

      result.success(null)
    } else {
      result.error("INVALID_ARGUMENTS", "Latitude, longitude, or text is null", null)
    }
  }

  fun updateViewAnnotationOnFeature(call: MethodCall, result: MethodChannel.Result) {
//    val latitude = call.argument<Double>("latitude")
//    val longitude = call.argument<Double>("longitude")
//    val text = call.argument<String>("text")
//    val id = call.argument<String>("id")

    val viewAnnotationId = call.argument<String>("viewAnnotationId")
    val featureId = call.argument<String>("featureId")
    val layerId = call.argument<String>("layerId")

    val title = call.argument<String>("title")
    val body = call.argument<String>("body")

    if (viewAnnotationId != null && featureId != null && layerId != null && title != null && body != null) {
      val customView = annotationsMap[viewAnnotationId]

      if (customView != null) {


        viewAnnotationManager.updateViewAnnotation(
          customView,
          viewAnnotationOptions {
            annotatedLayerFeature(layerId) {
              featureId(featureId)
            }
          }
        )

//        viewAnnotationManager.updateViewAnnotation(customView,
//          ViewAnnotationOptions.Builder()
//          .geometry(Point.fromLngLat(longitude, latitude))
//          .build()
//        )

        val titleTextView = customView.findViewById<TextView>(R.id.annotation_title_text)
        titleTextView.text = title

        val bodyTextView = customView.findViewById<TextView>(R.id.annotation_body_text)
        bodyTextView.text = body

        result.success(null)
      } else {
        result.error("ANNOTATION_NOT_FOUND", "No annotation found with id $viewAnnotationId", null)
      }
    } else {
      result.error("INVALID_ARGUMENTS", "ID or text is null", null)
    }
  }

  fun removeViewAnnotation(call: MethodCall, result: MethodChannel.Result) {
    val id = call.argument<String>("id")

    if (id != null) {
      val customView = annotationsMap[id]
      if (customView != null) {
        viewAnnotationManager.removeViewAnnotation(customView)
        annotationsMap.remove(id)
        result.success(null)
      } else {
        result.error("ANNOTATION_NOT_FOUND", "No annotation found with id $id", null)
      }
    } else {
      result.error("INVALID_ARGUMENTS", "ID is null", null)
    }
  }
}
