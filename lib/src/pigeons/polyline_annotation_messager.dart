part of mapbox_maps_flutter;

/// The display of line endings.
enum LineCap {
  /// A cap with a squared-off end which is drawn to the exact endpoint of the line.
  BUTT,

  /// A cap with a rounded end which is drawn beyond the endpoint of the line at a radius of one-half of the line's width and centered on the endpoint of the line.
  ROUND,

  /// A cap with a squared-off end which is drawn beyond the endpoint of the line at a distance of one-half of the line's width.
  SQUARE,
}

/// The display of lines when joining.
enum LineJoin {
  /// A join with a squared-off end which is drawn beyond the endpoint of the line at a distance of one-half of the line's width.
  BEVEL,

  /// A join with a rounded end which is drawn beyond the endpoint of the line at a radius of one-half of the line's width and centered on the endpoint of the line.
  ROUND,

  /// A join with a sharp, angled corner which is drawn with the outer sides beyond the endpoint of the path until they meet.
  MITER,
}

/// Controls the frame of reference for `line-translate`.
enum LineTranslateAnchor {
  /// The line is translated relative to the map.
  MAP,

  /// The line is translated relative to the viewport.
  VIEWPORT,
}

class PolylineAnnotation {
  PolylineAnnotation({
    required this.id,
    this.geometry,
    this.lineJoin,
    this.lineSortKey,
    this.lineBlur,
    this.lineBorderColor,
    this.lineBorderWidth,
    this.lineColor,
    this.lineGapWidth,
    this.lineOffset,
    this.lineOpacity,
    this.linePattern,
    this.lineWidth,
  });

  /// The id for annotation
  String id;

  /// The geometry that determines the location/shape of this annotation
  Map<String?, Object?>? geometry;

  /// The display of lines when joining.
  LineJoin? lineJoin;

  /// Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key.
  double? lineSortKey;

  /// Blur applied to the line, in pixels.
  double? lineBlur;

  /// The color of the line border. If line-border-width is greater than zero and the alpha value of this color is 0 (default), the color for the border will be selected automatically based on the line color.
  int? lineBorderColor;

  /// The width of the line border. A value of zero means no border.
  double? lineBorderWidth;

  /// The color with which the line will be drawn.
  int? lineColor;

  /// Draws a line casing outside of a line's actual path. Value indicates the width of the inner gap.
  double? lineGapWidth;

  /// The line's offset. For linear features, a positive value offsets the line to the right, relative to the direction of the line, and a negative value to the left. For polygon features, a positive value results in an inset, and a negative value results in an outset.
  double? lineOffset;

  /// The opacity at which the line will be drawn.
  double? lineOpacity;

  /// Name of image in sprite to use for drawing image lines. For seamless patterns, image width must be a factor of two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be evaluated only at integer zoom levels.
  String? linePattern;

  /// Stroke thickness.
  double? lineWidth;

  Object encode() {
    return <Object?>[
      id,
      geometry,
      lineJoin?.index,
      lineSortKey,
      lineBlur,
      lineBorderColor,
      lineBorderWidth,
      lineColor,
      lineGapWidth,
      lineOffset,
      lineOpacity,
      linePattern,
      lineWidth,
    ];
  }

  static PolylineAnnotation decode(Object result) {
    result as List<Object?>;
    return PolylineAnnotation(
      id: result[0]! as String,
      geometry: (result[1] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
      lineJoin: result[2] != null ? LineJoin.values[result[2]! as int] : null,
      lineSortKey: result[3] as double?,
      lineBlur: result[4] as double?,
      lineBorderColor: result[5] as int?,
      lineBorderWidth: result[6] as double?,
      lineColor: result[7] as int?,
      lineGapWidth: result[8] as double?,
      lineOffset: result[9] as double?,
      lineOpacity: result[10] as double?,
      linePattern: result[11] as String?,
      lineWidth: result[12] as double?,
    );
  }
}

class PolylineAnnotationOptions {
  PolylineAnnotationOptions({
    this.geometry,
    this.lineJoin,
    this.lineSortKey,
    this.lineBlur,
    this.lineBorderColor,
    this.lineBorderWidth,
    this.lineColor,
    this.lineGapWidth,
    this.lineOffset,
    this.lineOpacity,
    this.linePattern,
    this.lineWidth,
  });

  /// The geometry that determines the location/shape of this annotation
  Map<String?, Object?>? geometry;

  /// The display of lines when joining.
  LineJoin? lineJoin;

  /// Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key.
  double? lineSortKey;

  /// Blur applied to the line, in pixels.
  double? lineBlur;

  /// The color of the line border. If line-border-width is greater than zero and the alpha value of this color is 0 (default), the color for the border will be selected automatically based on the line color.
  int? lineBorderColor;

  /// The width of the line border. A value of zero means no border.
  double? lineBorderWidth;

  /// The color with which the line will be drawn.
  int? lineColor;

  /// Draws a line casing outside of a line's actual path. Value indicates the width of the inner gap.
  double? lineGapWidth;

  /// The line's offset. For linear features, a positive value offsets the line to the right, relative to the direction of the line, and a negative value to the left. For polygon features, a positive value results in an inset, and a negative value results in an outset.
  double? lineOffset;

  /// The opacity at which the line will be drawn.
  double? lineOpacity;

  /// Name of image in sprite to use for drawing image lines. For seamless patterns, image width must be a factor of two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be evaluated only at integer zoom levels.
  String? linePattern;

  /// Stroke thickness.
  double? lineWidth;

  Object encode() {
    return <Object?>[
      geometry,
      lineJoin?.index,
      lineSortKey,
      lineBlur,
      lineBorderColor,
      lineBorderWidth,
      lineColor,
      lineGapWidth,
      lineOffset,
      lineOpacity,
      linePattern,
      lineWidth,
    ];
  }

  static PolylineAnnotationOptions decode(Object result) {
    result as List<Object?>;
    return PolylineAnnotationOptions(
      geometry: (result[0] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
      lineJoin: result[1] != null ? LineJoin.values[result[1]! as int] : null,
      lineSortKey: result[2] as double?,
      lineBlur: result[3] as double?,
      lineBorderColor: result[4] as int?,
      lineBorderWidth: result[5] as double?,
      lineColor: result[6] as int?,
      lineGapWidth: result[7] as double?,
      lineOffset: result[8] as double?,
      lineOpacity: result[9] as double?,
      linePattern: result[10] as String?,
      lineWidth: result[11] as double?,
    );
  }
}

class _OnPolylineAnnotationClickListenerCodec extends StandardMessageCodec {
  const _OnPolylineAnnotationClickListenerCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PolylineAnnotation) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return PolylineAnnotation.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class OnPolylineAnnotationClickListener {
  static const MessageCodec<Object?> pigeonChannelCodec =
      _OnPolylineAnnotationClickListenerCodec();

  void onPolylineAnnotationClick(PolylineAnnotation annotation);

  static void setup(OnPolylineAnnotationClickListener? api,
      {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.mapbox_maps_flutter.OnPolylineAnnotationClickListener.onPolylineAnnotationClick',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnPolylineAnnotationClickListener.onPolylineAnnotationClick was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PolylineAnnotation? arg_annotation =
              (args[0] as PolylineAnnotation?);
          assert(arg_annotation != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnPolylineAnnotationClickListener.onPolylineAnnotationClick was null, expected non-null PolylineAnnotation.');
          try {
            api.onPolylineAnnotationClick(arg_annotation!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}

class __PolylineAnnotationMessagerCodec extends StandardMessageCodec {
  const __PolylineAnnotationMessagerCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PolylineAnnotation) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is PolylineAnnotation) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is PolylineAnnotationOptions) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is PolylineAnnotationOptions) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return PolylineAnnotation.decode(readValue(buffer)!);
      case 129:
        return PolylineAnnotation.decode(readValue(buffer)!);
      case 130:
        return PolylineAnnotationOptions.decode(readValue(buffer)!);
      case 131:
        return PolylineAnnotationOptions.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class _PolylineAnnotationMessager {
  /// Constructor for [_PolylineAnnotationMessager].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  _PolylineAnnotationMessager({BinaryMessenger? binaryMessenger})
      : __pigeon_binaryMessenger = binaryMessenger;
  final BinaryMessenger? __pigeon_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec =
      __PolylineAnnotationMessagerCodec();

  Future<PolylineAnnotation> create(
      String managerId, PolylineAnnotationOptions annotationOption) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.create';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, annotationOption]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as PolylineAnnotation?)!;
    }
  }

  Future<List<PolylineAnnotation?>> createMulti(String managerId,
      List<PolylineAnnotationOptions?> annotationOptions) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.createMulti';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, annotationOptions]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as List<Object?>?)!
          .cast<PolylineAnnotation?>();
    }
  }

  Future<void> update(String managerId, PolylineAnnotation annotation) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.update';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, annotation]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> delete(String managerId, PolylineAnnotation annotation) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.delete';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, annotation]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> deleteAll(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.deleteAll';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> setLineCap(String managerId, LineCap lineCap) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineCap';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, lineCap.index]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<LineCap?> getLineCap(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineCap';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as int?) == null
          ? null
          : LineCap.values[__pigeon_replyList[0]! as int];
    }
  }

  Future<void> setLineMiterLimit(
      String managerId, double lineMiterLimit) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineMiterLimit';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, lineMiterLimit]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<double?> getLineMiterLimit(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineMiterLimit';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as double?);
    }
  }

  Future<void> setLineRoundLimit(
      String managerId, double lineRoundLimit) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineRoundLimit';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, lineRoundLimit]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<double?> getLineRoundLimit(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineRoundLimit';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as double?);
    }
  }

  Future<void> setLineDasharray(
      String managerId, List<double?> lineDasharray) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineDasharray';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, lineDasharray]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<List<double?>?> getLineDasharray(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineDasharray';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as List<Object?>?)?.cast<double?>();
    }
  }

  Future<void> setLineDepthOcclusionFactor(
      String managerId, double lineDepthOcclusionFactor) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineDepthOcclusionFactor';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, lineDepthOcclusionFactor]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<double?> getLineDepthOcclusionFactor(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineDepthOcclusionFactor';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as double?);
    }
  }

  Future<void> setLineEmissiveStrength(
      String managerId, double lineEmissiveStrength) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineEmissiveStrength';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, lineEmissiveStrength]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<double?> getLineEmissiveStrength(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineEmissiveStrength';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as double?);
    }
  }

  Future<void> setLineTranslate(
      String managerId, List<double?> lineTranslate) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineTranslate';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, lineTranslate]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<List<double?>?> getLineTranslate(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineTranslate';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as List<Object?>?)?.cast<double?>();
    }
  }

  Future<void> setLineTranslateAnchor(
      String managerId, LineTranslateAnchor lineTranslateAnchor) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineTranslateAnchor';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
            .send(<Object?>[managerId, lineTranslateAnchor.index])
        as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<LineTranslateAnchor?> getLineTranslateAnchor(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineTranslateAnchor';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as int?) == null
          ? null
          : LineTranslateAnchor.values[__pigeon_replyList[0]! as int];
    }
  }

  Future<void> setLineTrimOffset(
      String managerId, List<double?> lineTrimOffset) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.setLineTrimOffset';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel
        .send(<Object?>[managerId, lineTrimOffset]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<List<double?>?> getLineTrimOffset(String managerId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter._PolylineAnnotationMessager.getLineTrimOffset';
    final BasicMessageChannel<Object?> __pigeon_channel =
        BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[managerId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as List<Object?>?)?.cast<double?>();
    }
  }
}
