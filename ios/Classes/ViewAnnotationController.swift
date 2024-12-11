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
        
        // Optional font sizes with defaults
        let titleFontSize = args["titleFontSize"] as? Double ?? 16
        let bodyFontSize = args["bodyFontSize"] as? Double ?? 14

        // Check if the annotation already exists
        if annotationsMap[viewAnnotationId] != nil {
            result(FlutterError(code: "ANNOTATION_EXISTS", message: "Annotation with this ID already exists", details: nil))
            return
        }

        // Create a container view without a background
        let annotationView = createAnnotationView(title: title, body: body, titleFontSize: titleFontSize, bodyFontSize: bodyFontSize)

        // Calculate dynamic size
        annotationView.layoutIfNeeded()
        let dynamicSize = annotationView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        // Add annotation to Mapbox
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let point = Point(centerCoordinate)

        let viewAnnotationOptions = ViewAnnotationOptions(
            geometry: point,
            width: dynamicSize.width,
            height: dynamicSize.height,
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
              let longitude = args["longitude"] as? Double else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }

        guard let annotationView = annotationsMap[viewAnnotationId] else {
            result(FlutterError(code: "ANNOTATION_NOT_FOUND", message: "Annotation not found", details: nil))
            return
        }

        // Optional font sizes with defaults
        let titleFontSize = args["titleFontSize"] as? Double
        let bodyFontSize = args["bodyFontSize"] as? Double
        
        // Update title and body
        if let titleLabel = annotationView.subviews.first(where: { $0.accessibilityIdentifier == "titleLabel" }) as? UILabel {
            titleLabel.text = title
            if let fontSize = titleFontSize { // Safely unwrap the optional
                titleLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
            }
        }

        if let bodyLabel = annotationView.subviews.first(where: { $0.accessibilityIdentifier == "bodyLabel" }) as? UILabel {
            bodyLabel.text = body
            if let fontSize = bodyFontSize { // Safely unwrap the optional
                bodyLabel.font = .systemFont(ofSize: CGFloat(fontSize))
            }
        }

        // Calculate dynamic size after updates
        annotationView.layoutIfNeeded()
        let dynamicSize = annotationView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        // Update the annotation options
        let centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let point = Point(centerCoordinate)

        let viewAnnotationOptions = ViewAnnotationOptions(
            geometry: point,
            width: dynamicSize.width,
            height: dynamicSize.height,
            allowOverlap: true
        )

        do {
            try mapView.viewAnnotations.update(annotationView, options: viewAnnotationOptions)
            result(nil)
        } catch {
            result(FlutterError(code: "ANNOTATION_ERROR", message: "Failed to update annotation", details: error.localizedDescription))
        }
    }

    // Remove view annotation from the map
    func removeViewAnnotation(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = methodCall.arguments as? [String: Any],
              let viewAnnotationId = args["viewAnnotationId"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }

        guard let annotationView = annotationsMap[viewAnnotationId] else {
            result(FlutterError(code: "ANNOTATION_NOT_FOUND", message: "Annotation not found", details: nil))
            return
        }

        do {
            try mapView.viewAnnotations.remove(annotationView)
            annotationsMap.removeValue(forKey: viewAnnotationId)
            result(nil)
        } catch {
            result(FlutterError(code: "ANNOTATION_ERROR", message: "Failed to remove annotation", details: error.localizedDescription))
        }
    }

    // Check if an annotation exists
    func viewAnnotationExists(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = methodCall.arguments as? [String: Any],
              let viewAnnotationId = args["viewAnnotationId"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing arguments", details: nil))
            return
        }

        result(annotationsMap[viewAnnotationId] != nil)
    }

    // Helper method to create the annotation view
    private func createAnnotationView(title: String, body: String, titleFontSize: Double, bodyFontSize: Double) -> UIView {
        let annotationView = UIView()
        annotationView.translatesAutoresizingMaskIntoConstraints = false

        // Title label
        let titleLabel = UILabel()
        titleLabel.accessibilityIdentifier = "titleLabel"
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: CGFloat(titleFontSize))
        titleLabel.textColor = UIColor.green
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        annotationView.addSubview(titleLabel)

        // Body label
        let bodyLabel = UILabel()
        titleLabel.accessibilityIdentifier = "bodyLabel"
        bodyLabel.text = body
        bodyLabel.font = .boldSystemFont(ofSize:  CGFloat(bodyFontSize))
        bodyLabel.textColor = UIColor.green
        bodyLabel.numberOfLines = 0
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        annotationView.addSubview(bodyLabel)

        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: annotationView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            bodyLabel.leadingAnchor.constraint(equalTo: annotationView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: annotationView.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: annotationView.bottomAnchor)
        ])

        return annotationView
    }
}
