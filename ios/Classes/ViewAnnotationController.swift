import Flutter
import UIKit
import MapboxMaps

class ViewAnnotationController: NSObject {

    private var mapView: MapView
    private var annotationsMap: [String: UIView] = [:] // Store annotations by their ID

    init(withMapView mapView: MapView) {
        self.mapView = mapView
        super.init()
    }

    // Add view annotation to the map
    func addViewAnnotation(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = methodCall.arguments as? [String: Any],
              let viewAnnotationId = args["viewAnnotationId"] as? String,
              let latitude = args["latitude"] as? Double,
              let longitude = args["longitude"] as? Double,
              let title = args["title"] as? String,
              let body = args["body"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }

        // Optional offsets with defaults
        let offsetX = args["offsetX"] as? Double ?? 0.0
        let offsetY = args["offsetY"] as? Double ?? 0.0

        // Create a custom UIView for the annotation
        let annotationView = UIView()
        annotationView.backgroundColor = .white
        annotationView.layer.cornerRadius = 8
        annotationView.layer.borderColor = UIColor.lightGray.cgColor
        annotationView.layer.borderWidth = 1

        // Add a UILabel for title
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        annotationView.addSubview(titleLabel)

        // Add a UILabel for body
        let bodyLabel = UILabel()
        bodyLabel.text = body
        bodyLabel.font = .systemFont(ofSize: 14)
        bodyLabel.textColor = .black
        annotationView.addSubview(bodyLabel)

        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: annotationView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor, constant: -8),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            bodyLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor, constant: 8),
            bodyLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor, constant: -8),
            bodyLabel.bottomAnchor.constraint(equalTo: annotationView.bottomAnchor, constant: -8)
        ])

        // Explicit size for Mapbox
        annotationView.frame = CGRect(x: 0, y: 0, width: 170, height: 110)

        // Create the coordinate and add annotation to the map
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let point = Point(centerCoordinate)

        let viewAnnotationOptions = ViewAnnotationOptions(
            geometry: point,
            width: 170,
            height: 110,
            offsetX: offsetX,
            offsetY: offsetY,
        )

        do {
            try mapView.viewAnnotations.add(annotationView, options: viewAnnotationOptions)
            annotationsMap[viewAnnotationId] = annotationView
            result(nil)
        } catch {
            result(FlutterError(code: "ANNOTATION_ERROR", message: "Failed to add annotation", details: error.localizedDescription))
        }
    }

    // Update view annotation with new content
    func updateViewAnnotation(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = methodCall.arguments as? [String: Any],
              let viewAnnotationId = args["viewAnnotationId"] as? String,
              let title = args["title"] as? String,
              let body = args["body"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }

        if let annotationView = annotationsMap[viewAnnotationId] {
            // Find the title and body labels and update their content
            if let titleLabel = annotationView.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).font == .boldSystemFont(ofSize: 16) }) as? UILabel {
                titleLabel.text = title
            }
            if let bodyLabel = annotationView.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).font == .systemFont(ofSize: 14) }) as? UILabel {
                bodyLabel.text = body
            }
            result(nil)
        } else {
            result(FlutterError(code: "ANNOTATION_NOT_FOUND", message: "Annotation not found", details: nil))
        }
    }

    // Remove view annotation from the map
    func removeViewAnnotation(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = methodCall.arguments as? [String: Any],
              let viewAnnotationId = args["viewAnnotationId"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }

        if let annotationView = annotationsMap[viewAnnotationId] {
            do {
                try mapView.viewAnnotations.remove(annotationView)
                annotationsMap.removeValue(forKey: viewAnnotationId)
                result(nil)
            } catch {
                result(FlutterError(code: "ANNOTATION_ERROR", message: "Failed to remove annotation", details: error.localizedDescription))
            }
        } else {
            result(FlutterError(code: "ANNOTATION_NOT_FOUND", message: "Annotation not found", details: nil))
        }
    }
}

// import Flutter
// import UIKit
// import MapboxMaps

// class ViewAnnotationController: NSObject {

//     private var mapView: MapView
//     private var annotationsMap: [String: UIView] = [:] // Store annotations by their ID

//     init(withMapView mapView: MapView) {
//         self.mapView = mapView
//         super.init()
//     }

//     // Add view annotation to the map
//     func addViewAnnotation(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
//         guard let viewAnnotationId = methodCall.arguments?["viewAnnotationId"] as? String,
//               let latitude = methodCall.arguments?["latitude"] as? Double,
//               let longitude = methodCall.arguments?["longitude"] as? Double,
//               let title = methodCall.arguments?["title"] as? String,
//               let body = methodCall.arguments?["body"] as? String else {
//             result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
//             return
//         }

//         // Create a custom UIView
//         let annotationView = UIView()
//         annotationView.backgroundColor = UIColor.white
//         annotationView.layer.cornerRadius = 8
//         annotationView.layer.borderColor = UIColor.lightGray.cgColor
//         annotationView.layer.borderWidth = 1

//         // Add a UILabel for title
//         let titleLabel = UILabel()
//         titleLabel.text = title
//         titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
//         titleLabel.textColor = UIColor.black
//         annotationView.addSubview(titleLabel)
//         titleLabel.translatesAutoresizingMaskIntoConstraints = false
//         titleLabel.topAnchor.constraint(equalTo: annotationView.topAnchor, constant: 8).isActive = true
//         titleLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor, constant: 8).isActive = true
//         titleLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor, constant: -8).isActive = true

//         // Add a UILabel for body
//         let bodyLabel = UILabel()
//         bodyLabel.text = body
//         bodyLabel.font = UIFont.systemFont(ofSize: 14)
//         bodyLabel.textColor = UIColor.black
//         annotationView.addSubview(bodyLabel)
//         bodyLabel.translatesAutoresizingMaskIntoConstraints = false
//         bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
//         bodyLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor, constant: 8).isActive = true
//         bodyLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor, constant: -8).isActive = true
//         bodyLabel.bottomAnchor.constraint(equalTo: annotationView.bottomAnchor, constant: -8).isActive = true

//         let viewAnnotation = ViewAnnotation(coordinate: centerCoordinate, view: annotationView)
//         viewAnnotation.allowOverlap = true
//         mapView.viewAnnotations.add(viewAnnotation)

//         // // Add the annotation to the map
//         // mapView.addAnnotation(pointAnnotation)



//         // let annotation = ViewAnnotation(coordinate: coordinate, view: annotationView)
//         // annotation.allowOverlap = true
//         // annotationView.onClose = { [weak annotation] in annotation?.remove() }
//         // annotationView.onSelect = { [weak annotation] selected in
//         //     annotation?.selected = selected
//         //     annotation?.setNeedsUpdateSize()
//         // }
//         // mapView.viewAnnotations.add(annotation)

//         // Store the annotation view by ID
//         annotationsMap[viewAnnotationId] = annotationView

//         result(nil)
//     }

//     // Update view annotation with new content
//     func updateViewAnnotation(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
//         guard let viewAnnotationId = methodCall.arguments?["viewAnnotationId"] as? String,
//               let title = methodCall.arguments?["title"] as? String,
//               let body = methodCall.arguments?["body"] as? String else {
//             result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
//             return
//         }

//         if let annotationView = annotationsMap[viewAnnotationId] {
//             // Find the title and body labels and update them
//             if let titleLabel = annotationView.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).text == title }) as? UILabel {
//                 titleLabel.text = title
//             }
//             if let bodyLabel = annotationView.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).text == body }) as? UILabel {
//                 bodyLabel.text = body
//             }

//             result(nil)
//         } else {
//             result(FlutterError(code: "ANNOTATION_NOT_FOUND", message: "Annotation not found", details: nil))
//         }
//     }

//     // Remove view annotation from the map
//     func removeViewAnnotation(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
//         guard let viewAnnotationId = methodCall.arguments?["viewAnnotationId"] as? String else {
//             result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
//             return
//         }

//         if let annotationView = annotationsMap[viewAnnotationId] {
//             // Remove annotation view from map
//             annotationView.removeFromSuperview()
//             annotationsMap.removeValue(forKey: viewAnnotationId)
//             result(nil)
//         } else {
//             result(FlutterError(code: "ANNOTATION_NOT_FOUND", message: "Annotation not found", details: nil))
//         }
//     }
// }
