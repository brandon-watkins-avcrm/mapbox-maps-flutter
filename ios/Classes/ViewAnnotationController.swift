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

        // Create a container view without a background
        let annotationView = UIView()
        annotationView.translatesAutoresizingMaskIntoConstraints = false

        // Add a title label (bright green, bold)
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 16) // Bold font for the title
        titleLabel.textColor = UIColor.green // Bright green text
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        annotationView.addSubview(titleLabel)

        // Add a body label (smaller, dark gray text)
        let bodyLabel = UILabel()
        bodyLabel.text = body
        bodyLabel.font = .boldSystemFont(ofSize: 14) // Regular font for the body
        bodyLabel.textColor = UIColor.green
        bodyLabel.numberOfLines = 0
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        annotationView.addSubview(bodyLabel)

        // Add constraints to arrange the labels
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: annotationView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            bodyLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: annotationView.bottomAnchor)
        ])

        // // Create a custom UIView for the annotation (InfoWindow style)
        // let annotationView = UIView()
        // annotationView.backgroundColor = UIColor.white.withAlphaComponent(0.5) // Add opacity here
        // annotationView.layer.cornerRadius = 10
        // annotationView.layer.borderColor = UIColor.lightGray.cgColor
        // annotationView.layer.borderWidth = 1
        // annotationView.translatesAutoresizingMaskIntoConstraints = false

        // // Add a title label
        // let titleLabel = UILabel()
        // titleLabel.text = title
        // titleLabel.font = .boldSystemFont(ofSize: 16)
        // titleLabel.textColor = .black
        // titleLabel.translatesAutoresizingMaskIntoConstraints = false
        // annotationView.addSubview(titleLabel)

        // // Add a body label
        // let bodyLabel = UILabel()
        // bodyLabel.text = body
        // bodyLabel.font = .systemFont(ofSize: 14)
        // bodyLabel.textColor = .darkGray
        // bodyLabel.numberOfLines = 0
        // bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        // annotationView.addSubview(bodyLabel)

        // // Add constraints for dynamic sizing
        // NSLayoutConstraint.activate([
        //     titleLabel.topAnchor.constraint(equalTo: annotationView.topAnchor, constant: 8),
        //     titleLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor, constant: 8),
        //     titleLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor, constant: -8),

        //     bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
        //     bodyLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor, constant: 8),
        //     bodyLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor, constant: -8),
        //     bodyLabel.bottomAnchor.constraint(equalTo: annotationView.bottomAnchor, constant: -8)
        // ])

        // Trigger Auto Layout calculations
        annotationView.layoutIfNeeded()

        // Calculate dynamic size
        let dynamicSize = annotationView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let dynamicWidth = dynamicSize.width
        let dynamicHeight = dynamicSize.height

        // Add annotation to Mapbox
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let point = Point(centerCoordinate)

        let viewAnnotationOptions = ViewAnnotationOptions(
            geometry: point,
            width: dynamicWidth,
            height: dynamicHeight,
            allowOverlap: true,
            offsetX: offsetX,
            offsetY: offsetY
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
            let body = args["body"] as? String,
            let latitude = args["latitude"] as? Double,
            let longitude = args["longitude"] as? Double
        else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }

        if let annotationView = annotationsMap[viewAnnotationId] {
            do {
                // Update title and body
                if let titleLabel = annotationView.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).font == .boldSystemFont(ofSize: 16) }) as? UILabel {
                    titleLabel.text = title
                }
                if let bodyLabel = annotationView.subviews.first(where: { $0 is UILabel && ($0 as! UILabel).font == .boldSystemFont(ofSize: 14) }) as? UILabel {
                    bodyLabel.text = body
                }

                let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let point = Point(centerCoordinate)

                annotationView.annotatedFeature.geometry = .point(point)

                result(nil)
            } catch {
                result(FlutterError(code: "ANNOTATION_ERROR", message: "Failed to add annotation", details: error.localizedDescription))
            }
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

    func viewAnnotationExists(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = methodCall.arguments as? [String: Any],
              let viewAnnotationId = args["viewAnnotationId"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }

        result(annotationsMap[viewAnnotationId] != nil)
    }
}
