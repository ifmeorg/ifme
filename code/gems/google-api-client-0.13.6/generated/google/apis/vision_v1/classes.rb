# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'date'
require 'google/apis/core/base_service'
require 'google/apis/core/json_representation'
require 'google/apis/core/hashable'
require 'google/apis/errors'

module Google
  module Apis
    module VisionV1
      
      # Request for performing Google Cloud Vision API tasks over a user-provided
      # image, with user-requested features.
      class AnnotateImageRequest
        include Google::Apis::Core::Hashable
      
        # Requested features.
        # Corresponds to the JSON property `features`
        # @return [Array<Google::Apis::VisionV1::Feature>]
        attr_accessor :features
      
        # Client image to perform Google Cloud Vision API tasks over.
        # Corresponds to the JSON property `image`
        # @return [Google::Apis::VisionV1::Image]
        attr_accessor :image
      
        # Image context and/or feature-specific parameters.
        # Corresponds to the JSON property `imageContext`
        # @return [Google::Apis::VisionV1::ImageContext]
        attr_accessor :image_context
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @features = args[:features] if args.key?(:features)
          @image = args[:image] if args.key?(:image)
          @image_context = args[:image_context] if args.key?(:image_context)
        end
      end
      
      # Response to an image annotation request.
      class AnnotateImageResponse
        include Google::Apis::Core::Hashable
      
        # Set of crop hints that are used to generate new crops when serving images.
        # Corresponds to the JSON property `cropHintsAnnotation`
        # @return [Google::Apis::VisionV1::CropHintsAnnotation]
        attr_accessor :crop_hints_annotation
      
        # The `Status` type defines a logical error model that is suitable for different
        # programming environments, including REST APIs and RPC APIs. It is used by
        # [gRPC](https://github.com/grpc). The error model is designed to be:
        # - Simple to use and understand for most users
        # - Flexible enough to meet unexpected needs
        # # Overview
        # The `Status` message contains three pieces of data: error code, error message,
        # and error details. The error code should be an enum value of
        # google.rpc.Code, but it may accept additional error codes if needed.  The
        # error message should be a developer-facing English message that helps
        # developers *understand* and *resolve* the error. If a localized user-facing
        # error message is needed, put the localized message in the error details or
        # localize it in the client. The optional error details may contain arbitrary
        # information about the error. There is a predefined set of error detail types
        # in the package `google.rpc` that can be used for common error conditions.
        # # Language mapping
        # The `Status` message is the logical representation of the error model, but it
        # is not necessarily the actual wire format. When the `Status` message is
        # exposed in different client libraries and different wire protocols, it can be
        # mapped differently. For example, it will likely be mapped to some exceptions
        # in Java, but more likely mapped to some error codes in C.
        # # Other uses
        # The error model and the `Status` message can be used in a variety of
        # environments, either with or without APIs, to provide a
        # consistent developer experience across different environments.
        # Example uses of this error model include:
        # - Partial errors. If a service needs to return partial errors to the client,
        # it may embed the `Status` in the normal response to indicate the partial
        # errors.
        # - Workflow errors. A typical workflow has multiple steps. Each step may
        # have a `Status` message for error reporting.
        # - Batch operations. If a client uses batch request and batch response, the
        # `Status` message should be used directly inside batch response, one for
        # each error sub-response.
        # - Asynchronous operations. If an API call embeds asynchronous operation
        # results in its response, the status of those operations should be
        # represented directly using the `Status` message.
        # - Logging. If some API errors are stored in logs, the message `Status` could
        # be used directly after any stripping needed for security/privacy reasons.
        # Corresponds to the JSON property `error`
        # @return [Google::Apis::VisionV1::Status]
        attr_accessor :error
      
        # If present, face detection has completed successfully.
        # Corresponds to the JSON property `faceAnnotations`
        # @return [Array<Google::Apis::VisionV1::FaceAnnotation>]
        attr_accessor :face_annotations
      
        # TextAnnotation contains a structured representation of OCR extracted text.
        # The hierarchy of an OCR extracted text structure is like this:
        # TextAnnotation -> Page -> Block -> Paragraph -> Word -> Symbol
        # Each structural component, starting from Page, may further have their own
        # properties. Properties describe detected languages, breaks etc.. Please
        # refer to the google.cloud.vision.v1.TextAnnotation.TextProperty message
        # definition below for more detail.
        # Corresponds to the JSON property `fullTextAnnotation`
        # @return [Google::Apis::VisionV1::TextAnnotation]
        attr_accessor :full_text_annotation
      
        # Stores image properties, such as dominant colors.
        # Corresponds to the JSON property `imagePropertiesAnnotation`
        # @return [Google::Apis::VisionV1::ImageProperties]
        attr_accessor :image_properties_annotation
      
        # If present, label detection has completed successfully.
        # Corresponds to the JSON property `labelAnnotations`
        # @return [Array<Google::Apis::VisionV1::EntityAnnotation>]
        attr_accessor :label_annotations
      
        # If present, landmark detection has completed successfully.
        # Corresponds to the JSON property `landmarkAnnotations`
        # @return [Array<Google::Apis::VisionV1::EntityAnnotation>]
        attr_accessor :landmark_annotations
      
        # If present, logo detection has completed successfully.
        # Corresponds to the JSON property `logoAnnotations`
        # @return [Array<Google::Apis::VisionV1::EntityAnnotation>]
        attr_accessor :logo_annotations
      
        # Set of features pertaining to the image, computed by computer vision
        # methods over safe-search verticals (for example, adult, spoof, medical,
        # violence).
        # Corresponds to the JSON property `safeSearchAnnotation`
        # @return [Google::Apis::VisionV1::SafeSearchAnnotation]
        attr_accessor :safe_search_annotation
      
        # If present, text (OCR) detection has completed successfully.
        # Corresponds to the JSON property `textAnnotations`
        # @return [Array<Google::Apis::VisionV1::EntityAnnotation>]
        attr_accessor :text_annotations
      
        # Relevant information for the image from the Internet.
        # Corresponds to the JSON property `webDetection`
        # @return [Google::Apis::VisionV1::WebDetection]
        attr_accessor :web_detection
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @crop_hints_annotation = args[:crop_hints_annotation] if args.key?(:crop_hints_annotation)
          @error = args[:error] if args.key?(:error)
          @face_annotations = args[:face_annotations] if args.key?(:face_annotations)
          @full_text_annotation = args[:full_text_annotation] if args.key?(:full_text_annotation)
          @image_properties_annotation = args[:image_properties_annotation] if args.key?(:image_properties_annotation)
          @label_annotations = args[:label_annotations] if args.key?(:label_annotations)
          @landmark_annotations = args[:landmark_annotations] if args.key?(:landmark_annotations)
          @logo_annotations = args[:logo_annotations] if args.key?(:logo_annotations)
          @safe_search_annotation = args[:safe_search_annotation] if args.key?(:safe_search_annotation)
          @text_annotations = args[:text_annotations] if args.key?(:text_annotations)
          @web_detection = args[:web_detection] if args.key?(:web_detection)
        end
      end
      
      # Multiple image annotation requests are batched into a single service call.
      class BatchAnnotateImagesRequest
        include Google::Apis::Core::Hashable
      
        # Individual image annotation requests for this batch.
        # Corresponds to the JSON property `requests`
        # @return [Array<Google::Apis::VisionV1::AnnotateImageRequest>]
        attr_accessor :requests
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @requests = args[:requests] if args.key?(:requests)
        end
      end
      
      # Response to a batch image annotation request.
      class BatchAnnotateImagesResponse
        include Google::Apis::Core::Hashable
      
        # Individual responses to image annotation requests within the batch.
        # Corresponds to the JSON property `responses`
        # @return [Array<Google::Apis::VisionV1::AnnotateImageResponse>]
        attr_accessor :responses
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @responses = args[:responses] if args.key?(:responses)
        end
      end
      
      # Logical element on the page.
      class Block
        include Google::Apis::Core::Hashable
      
        # Detected block type (text, image etc) for this block.
        # Corresponds to the JSON property `blockType`
        # @return [String]
        attr_accessor :block_type
      
        # A bounding polygon for the detected image annotation.
        # Corresponds to the JSON property `boundingBox`
        # @return [Google::Apis::VisionV1::BoundingPoly]
        attr_accessor :bounding_box
      
        # List of paragraphs in this block (if this blocks is of type text).
        # Corresponds to the JSON property `paragraphs`
        # @return [Array<Google::Apis::VisionV1::Paragraph>]
        attr_accessor :paragraphs
      
        # Additional information detected on the structural component.
        # Corresponds to the JSON property `property`
        # @return [Google::Apis::VisionV1::TextProperty]
        attr_accessor :property
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @block_type = args[:block_type] if args.key?(:block_type)
          @bounding_box = args[:bounding_box] if args.key?(:bounding_box)
          @paragraphs = args[:paragraphs] if args.key?(:paragraphs)
          @property = args[:property] if args.key?(:property)
        end
      end
      
      # A bounding polygon for the detected image annotation.
      class BoundingPoly
        include Google::Apis::Core::Hashable
      
        # The bounding polygon vertices.
        # Corresponds to the JSON property `vertices`
        # @return [Array<Google::Apis::VisionV1::Vertex>]
        attr_accessor :vertices
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @vertices = args[:vertices] if args.key?(:vertices)
        end
      end
      
      # Represents a color in the RGBA color space. This representation is designed
      # for simplicity of conversion to/from color representations in various
      # languages over compactness; for example, the fields of this representation
      # can be trivially provided to the constructor of "java.awt.Color" in Java; it
      # can also be trivially provided to UIColor's "+colorWithRed:green:blue:alpha"
      # method in iOS; and, with just a little work, it can be easily formatted into
      # a CSS "rgba()" string in JavaScript, as well. Here are some examples:
      # Example (Java):
      # import com.google.type.Color;
      # // ...
      # public static java.awt.Color fromProto(Color protocolor) `
      # float alpha = protocolor.hasAlpha()
      # ? protocolor.getAlpha().getValue()
      # : 1.0;
      # return new java.awt.Color(
      # protocolor.getRed(),
      # protocolor.getGreen(),
      # protocolor.getBlue(),
      # alpha);
      # `
      # public static Color toProto(java.awt.Color color) `
      # float red = (float) color.getRed();
      # float green = (float) color.getGreen();
      # float blue = (float) color.getBlue();
      # float denominator = 255.0;
      # Color.Builder resultBuilder =
      # Color
      # .newBuilder()
      # .setRed(red / denominator)
      # .setGreen(green / denominator)
      # .setBlue(blue / denominator);
      # int alpha = color.getAlpha();
      # if (alpha != 255) `
      # result.setAlpha(
      # FloatValue
      # .newBuilder()
      # .setValue(((float) alpha) / denominator)
      # .build());
      # `
      # return resultBuilder.build();
      # `
      # // ...
      # Example (iOS / Obj-C):
      # // ...
      # static UIColor* fromProto(Color* protocolor) `
      # float red = [protocolor red];
      # float green = [protocolor green];
      # float blue = [protocolor blue];
      # FloatValue* alpha_wrapper = [protocolor alpha];
      # float alpha = 1.0;
      # if (alpha_wrapper != nil) `
      # alpha = [alpha_wrapper value];
      # `
      # return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
      # `
      # static Color* toProto(UIColor* color) `
      # CGFloat red, green, blue, alpha;
      # if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) `
      # return nil;
      # `
      # Color* result = [Color alloc] init];
      # [result setRed:red];
      # [result setGreen:green];
      # [result setBlue:blue];
      # if (alpha <= 0.9999) `
      # [result setAlpha:floatWrapperWithValue(alpha)];
      # `
      # [result autorelease];
      # return result;
      # `
      # // ...
      # Example (JavaScript):
      # // ...
      # var protoToCssColor = function(rgb_color) `
      # var redFrac = rgb_color.red || 0.0;
      # var greenFrac = rgb_color.green || 0.0;
      # var blueFrac = rgb_color.blue || 0.0;
      # var red = Math.floor(redFrac * 255);
      # var green = Math.floor(greenFrac * 255);
      # var blue = Math.floor(blueFrac * 255);
      # if (!('alpha' in rgb_color)) `
      # return rgbToCssColor_(red, green, blue);
      # `
      # var alphaFrac = rgb_color.alpha.value || 0.0;
      # var rgbParams = [red, green, blue].join(',');
      # return ['rgba(', rgbParams, ',', alphaFrac, ')'].join('');
      # `;
      # var rgbToCssColor_ = function(red, green, blue) `
      # var rgbNumber = new Number((red << 16) | (green << 8) | blue);
      # var hexString = rgbNumber.toString(16);
      # var missingZeros = 6 - hexString.length;
      # var resultBuilder = ['#'];
      # for (var i = 0; i < missingZeros; i++) `
      # resultBuilder.push('0');
      # `
      # resultBuilder.push(hexString);
      # return resultBuilder.join('');
      # `;
      # // ...
      class Color
        include Google::Apis::Core::Hashable
      
        # The fraction of this color that should be applied to the pixel. That is,
        # the final pixel color is defined by the equation:
        # pixel color = alpha * (this color) + (1.0 - alpha) * (background color)
        # This means that a value of 1.0 corresponds to a solid color, whereas
        # a value of 0.0 corresponds to a completely transparent color. This
        # uses a wrapper message rather than a simple float scalar so that it is
        # possible to distinguish between a default value and the value being unset.
        # If omitted, this color object is to be rendered as a solid color
        # (as if the alpha value had been explicitly given with a value of 1.0).
        # Corresponds to the JSON property `alpha`
        # @return [Float]
        attr_accessor :alpha
      
        # The amount of blue in the color as a value in the interval [0, 1].
        # Corresponds to the JSON property `blue`
        # @return [Float]
        attr_accessor :blue
      
        # The amount of green in the color as a value in the interval [0, 1].
        # Corresponds to the JSON property `green`
        # @return [Float]
        attr_accessor :green
      
        # The amount of red in the color as a value in the interval [0, 1].
        # Corresponds to the JSON property `red`
        # @return [Float]
        attr_accessor :red
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @alpha = args[:alpha] if args.key?(:alpha)
          @blue = args[:blue] if args.key?(:blue)
          @green = args[:green] if args.key?(:green)
          @red = args[:red] if args.key?(:red)
        end
      end
      
      # Color information consists of RGB channels, score, and the fraction of
      # the image that the color occupies in the image.
      class ColorInfo
        include Google::Apis::Core::Hashable
      
        # Represents a color in the RGBA color space. This representation is designed
        # for simplicity of conversion to/from color representations in various
        # languages over compactness; for example, the fields of this representation
        # can be trivially provided to the constructor of "java.awt.Color" in Java; it
        # can also be trivially provided to UIColor's "+colorWithRed:green:blue:alpha"
        # method in iOS; and, with just a little work, it can be easily formatted into
        # a CSS "rgba()" string in JavaScript, as well. Here are some examples:
        # Example (Java):
        # import com.google.type.Color;
        # // ...
        # public static java.awt.Color fromProto(Color protocolor) `
        # float alpha = protocolor.hasAlpha()
        # ? protocolor.getAlpha().getValue()
        # : 1.0;
        # return new java.awt.Color(
        # protocolor.getRed(),
        # protocolor.getGreen(),
        # protocolor.getBlue(),
        # alpha);
        # `
        # public static Color toProto(java.awt.Color color) `
        # float red = (float) color.getRed();
        # float green = (float) color.getGreen();
        # float blue = (float) color.getBlue();
        # float denominator = 255.0;
        # Color.Builder resultBuilder =
        # Color
        # .newBuilder()
        # .setRed(red / denominator)
        # .setGreen(green / denominator)
        # .setBlue(blue / denominator);
        # int alpha = color.getAlpha();
        # if (alpha != 255) `
        # result.setAlpha(
        # FloatValue
        # .newBuilder()
        # .setValue(((float) alpha) / denominator)
        # .build());
        # `
        # return resultBuilder.build();
        # `
        # // ...
        # Example (iOS / Obj-C):
        # // ...
        # static UIColor* fromProto(Color* protocolor) `
        # float red = [protocolor red];
        # float green = [protocolor green];
        # float blue = [protocolor blue];
        # FloatValue* alpha_wrapper = [protocolor alpha];
        # float alpha = 1.0;
        # if (alpha_wrapper != nil) `
        # alpha = [alpha_wrapper value];
        # `
        # return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        # `
        # static Color* toProto(UIColor* color) `
        # CGFloat red, green, blue, alpha;
        # if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) `
        # return nil;
        # `
        # Color* result = [Color alloc] init];
        # [result setRed:red];
        # [result setGreen:green];
        # [result setBlue:blue];
        # if (alpha <= 0.9999) `
        # [result setAlpha:floatWrapperWithValue(alpha)];
        # `
        # [result autorelease];
        # return result;
        # `
        # // ...
        # Example (JavaScript):
        # // ...
        # var protoToCssColor = function(rgb_color) `
        # var redFrac = rgb_color.red || 0.0;
        # var greenFrac = rgb_color.green || 0.0;
        # var blueFrac = rgb_color.blue || 0.0;
        # var red = Math.floor(redFrac * 255);
        # var green = Math.floor(greenFrac * 255);
        # var blue = Math.floor(blueFrac * 255);
        # if (!('alpha' in rgb_color)) `
        # return rgbToCssColor_(red, green, blue);
        # `
        # var alphaFrac = rgb_color.alpha.value || 0.0;
        # var rgbParams = [red, green, blue].join(',');
        # return ['rgba(', rgbParams, ',', alphaFrac, ')'].join('');
        # `;
        # var rgbToCssColor_ = function(red, green, blue) `
        # var rgbNumber = new Number((red << 16) | (green << 8) | blue);
        # var hexString = rgbNumber.toString(16);
        # var missingZeros = 6 - hexString.length;
        # var resultBuilder = ['#'];
        # for (var i = 0; i < missingZeros; i++) `
        # resultBuilder.push('0');
        # `
        # resultBuilder.push(hexString);
        # return resultBuilder.join('');
        # `;
        # // ...
        # Corresponds to the JSON property `color`
        # @return [Google::Apis::VisionV1::Color]
        attr_accessor :color
      
        # The fraction of pixels the color occupies in the image.
        # Value in range [0, 1].
        # Corresponds to the JSON property `pixelFraction`
        # @return [Float]
        attr_accessor :pixel_fraction
      
        # Image-specific score for this color. Value in range [0, 1].
        # Corresponds to the JSON property `score`
        # @return [Float]
        attr_accessor :score
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @color = args[:color] if args.key?(:color)
          @pixel_fraction = args[:pixel_fraction] if args.key?(:pixel_fraction)
          @score = args[:score] if args.key?(:score)
        end
      end
      
      # Single crop hint that is used to generate a new crop when serving an image.
      class CropHint
        include Google::Apis::Core::Hashable
      
        # A bounding polygon for the detected image annotation.
        # Corresponds to the JSON property `boundingPoly`
        # @return [Google::Apis::VisionV1::BoundingPoly]
        attr_accessor :bounding_poly
      
        # Confidence of this being a salient region.  Range [0, 1].
        # Corresponds to the JSON property `confidence`
        # @return [Float]
        attr_accessor :confidence
      
        # Fraction of importance of this salient region with respect to the original
        # image.
        # Corresponds to the JSON property `importanceFraction`
        # @return [Float]
        attr_accessor :importance_fraction
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bounding_poly = args[:bounding_poly] if args.key?(:bounding_poly)
          @confidence = args[:confidence] if args.key?(:confidence)
          @importance_fraction = args[:importance_fraction] if args.key?(:importance_fraction)
        end
      end
      
      # Set of crop hints that are used to generate new crops when serving images.
      class CropHintsAnnotation
        include Google::Apis::Core::Hashable
      
        # Crop hint results.
        # Corresponds to the JSON property `cropHints`
        # @return [Array<Google::Apis::VisionV1::CropHint>]
        attr_accessor :crop_hints
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @crop_hints = args[:crop_hints] if args.key?(:crop_hints)
        end
      end
      
      # Parameters for crop hints annotation request.
      class CropHintsParams
        include Google::Apis::Core::Hashable
      
        # Aspect ratios in floats, representing the ratio of the width to the height
        # of the image. For example, if the desired aspect ratio is 4/3, the
        # corresponding float value should be 1.33333.  If not specified, the
        # best possible crop is returned. The number of provided aspect ratios is
        # limited to a maximum of 16; any aspect ratios provided after the 16th are
        # ignored.
        # Corresponds to the JSON property `aspectRatios`
        # @return [Array<Float>]
        attr_accessor :aspect_ratios
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @aspect_ratios = args[:aspect_ratios] if args.key?(:aspect_ratios)
        end
      end
      
      # Detected start or end of a structural component.
      class DetectedBreak
        include Google::Apis::Core::Hashable
      
        # True if break prepends the element.
        # Corresponds to the JSON property `isPrefix`
        # @return [Boolean]
        attr_accessor :is_prefix
        alias_method :is_prefix?, :is_prefix
      
        # Detected break type.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @is_prefix = args[:is_prefix] if args.key?(:is_prefix)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # Detected language for a structural component.
      class DetectedLanguage
        include Google::Apis::Core::Hashable
      
        # Confidence of detected language. Range [0, 1].
        # Corresponds to the JSON property `confidence`
        # @return [Float]
        attr_accessor :confidence
      
        # The BCP-47 language code, such as "en-US" or "sr-Latn". For more
        # information, see
        # http://www.unicode.org/reports/tr35/#Unicode_locale_identifier.
        # Corresponds to the JSON property `languageCode`
        # @return [String]
        attr_accessor :language_code
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @confidence = args[:confidence] if args.key?(:confidence)
          @language_code = args[:language_code] if args.key?(:language_code)
        end
      end
      
      # Set of dominant colors and their corresponding scores.
      class DominantColorsAnnotation
        include Google::Apis::Core::Hashable
      
        # RGB color values with their score and pixel fraction.
        # Corresponds to the JSON property `colors`
        # @return [Array<Google::Apis::VisionV1::ColorInfo>]
        attr_accessor :colors
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @colors = args[:colors] if args.key?(:colors)
        end
      end
      
      # Set of detected entity features.
      class EntityAnnotation
        include Google::Apis::Core::Hashable
      
        # A bounding polygon for the detected image annotation.
        # Corresponds to the JSON property `boundingPoly`
        # @return [Google::Apis::VisionV1::BoundingPoly]
        attr_accessor :bounding_poly
      
        # The accuracy of the entity detection in an image.
        # For example, for an image in which the "Eiffel Tower" entity is detected,
        # this field represents the confidence that there is a tower in the query
        # image. Range [0, 1].
        # Corresponds to the JSON property `confidence`
        # @return [Float]
        attr_accessor :confidence
      
        # Entity textual description, expressed in its `locale` language.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # The language code for the locale in which the entity textual
        # `description` is expressed.
        # Corresponds to the JSON property `locale`
        # @return [String]
        attr_accessor :locale
      
        # The location information for the detected entity. Multiple
        # `LocationInfo` elements can be present because one location may
        # indicate the location of the scene in the image, and another location
        # may indicate the location of the place where the image was taken.
        # Location information is usually present for landmarks.
        # Corresponds to the JSON property `locations`
        # @return [Array<Google::Apis::VisionV1::LocationInfo>]
        attr_accessor :locations
      
        # Opaque entity ID. Some IDs may be available in
        # [Google Knowledge Graph Search API](https://developers.google.com/knowledge-
        # graph/).
        # Corresponds to the JSON property `mid`
        # @return [String]
        attr_accessor :mid
      
        # Some entities may have optional user-supplied `Property` (name/value)
        # fields, such a score or string that qualifies the entity.
        # Corresponds to the JSON property `properties`
        # @return [Array<Google::Apis::VisionV1::Property>]
        attr_accessor :properties
      
        # Overall score of the result. Range [0, 1].
        # Corresponds to the JSON property `score`
        # @return [Float]
        attr_accessor :score
      
        # The relevancy of the ICA (Image Content Annotation) label to the
        # image. For example, the relevancy of "tower" is likely higher to an image
        # containing the detected "Eiffel Tower" than to an image containing a
        # detected distant towering building, even though the confidence that
        # there is a tower in each image may be the same. Range [0, 1].
        # Corresponds to the JSON property `topicality`
        # @return [Float]
        attr_accessor :topicality
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bounding_poly = args[:bounding_poly] if args.key?(:bounding_poly)
          @confidence = args[:confidence] if args.key?(:confidence)
          @description = args[:description] if args.key?(:description)
          @locale = args[:locale] if args.key?(:locale)
          @locations = args[:locations] if args.key?(:locations)
          @mid = args[:mid] if args.key?(:mid)
          @properties = args[:properties] if args.key?(:properties)
          @score = args[:score] if args.key?(:score)
          @topicality = args[:topicality] if args.key?(:topicality)
        end
      end
      
      # A face annotation object contains the results of face detection.
      class FaceAnnotation
        include Google::Apis::Core::Hashable
      
        # Anger likelihood.
        # Corresponds to the JSON property `angerLikelihood`
        # @return [String]
        attr_accessor :anger_likelihood
      
        # Blurred likelihood.
        # Corresponds to the JSON property `blurredLikelihood`
        # @return [String]
        attr_accessor :blurred_likelihood
      
        # A bounding polygon for the detected image annotation.
        # Corresponds to the JSON property `boundingPoly`
        # @return [Google::Apis::VisionV1::BoundingPoly]
        attr_accessor :bounding_poly
      
        # Detection confidence. Range [0, 1].
        # Corresponds to the JSON property `detectionConfidence`
        # @return [Float]
        attr_accessor :detection_confidence
      
        # A bounding polygon for the detected image annotation.
        # Corresponds to the JSON property `fdBoundingPoly`
        # @return [Google::Apis::VisionV1::BoundingPoly]
        attr_accessor :fd_bounding_poly
      
        # Headwear likelihood.
        # Corresponds to the JSON property `headwearLikelihood`
        # @return [String]
        attr_accessor :headwear_likelihood
      
        # Joy likelihood.
        # Corresponds to the JSON property `joyLikelihood`
        # @return [String]
        attr_accessor :joy_likelihood
      
        # Face landmarking confidence. Range [0, 1].
        # Corresponds to the JSON property `landmarkingConfidence`
        # @return [Float]
        attr_accessor :landmarking_confidence
      
        # Detected face landmarks.
        # Corresponds to the JSON property `landmarks`
        # @return [Array<Google::Apis::VisionV1::Landmark>]
        attr_accessor :landmarks
      
        # Yaw angle, which indicates the leftward/rightward angle that the face is
        # pointing relative to the vertical plane perpendicular to the image. Range
        # [-180,180].
        # Corresponds to the JSON property `panAngle`
        # @return [Float]
        attr_accessor :pan_angle
      
        # Roll angle, which indicates the amount of clockwise/anti-clockwise rotation
        # of the face relative to the image vertical about the axis perpendicular to
        # the face. Range [-180,180].
        # Corresponds to the JSON property `rollAngle`
        # @return [Float]
        attr_accessor :roll_angle
      
        # Sorrow likelihood.
        # Corresponds to the JSON property `sorrowLikelihood`
        # @return [String]
        attr_accessor :sorrow_likelihood
      
        # Surprise likelihood.
        # Corresponds to the JSON property `surpriseLikelihood`
        # @return [String]
        attr_accessor :surprise_likelihood
      
        # Pitch angle, which indicates the upwards/downwards angle that the face is
        # pointing relative to the image's horizontal plane. Range [-180,180].
        # Corresponds to the JSON property `tiltAngle`
        # @return [Float]
        attr_accessor :tilt_angle
      
        # Under-exposed likelihood.
        # Corresponds to the JSON property `underExposedLikelihood`
        # @return [String]
        attr_accessor :under_exposed_likelihood
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @anger_likelihood = args[:anger_likelihood] if args.key?(:anger_likelihood)
          @blurred_likelihood = args[:blurred_likelihood] if args.key?(:blurred_likelihood)
          @bounding_poly = args[:bounding_poly] if args.key?(:bounding_poly)
          @detection_confidence = args[:detection_confidence] if args.key?(:detection_confidence)
          @fd_bounding_poly = args[:fd_bounding_poly] if args.key?(:fd_bounding_poly)
          @headwear_likelihood = args[:headwear_likelihood] if args.key?(:headwear_likelihood)
          @joy_likelihood = args[:joy_likelihood] if args.key?(:joy_likelihood)
          @landmarking_confidence = args[:landmarking_confidence] if args.key?(:landmarking_confidence)
          @landmarks = args[:landmarks] if args.key?(:landmarks)
          @pan_angle = args[:pan_angle] if args.key?(:pan_angle)
          @roll_angle = args[:roll_angle] if args.key?(:roll_angle)
          @sorrow_likelihood = args[:sorrow_likelihood] if args.key?(:sorrow_likelihood)
          @surprise_likelihood = args[:surprise_likelihood] if args.key?(:surprise_likelihood)
          @tilt_angle = args[:tilt_angle] if args.key?(:tilt_angle)
          @under_exposed_likelihood = args[:under_exposed_likelihood] if args.key?(:under_exposed_likelihood)
        end
      end
      
      # Users describe the type of Google Cloud Vision API tasks to perform over
      # images by using *Feature*s. Each Feature indicates a type of image
      # detection task to perform. Features encode the Cloud Vision API
      # vertical to operate on and the number of top-scoring results to return.
      class Feature
        include Google::Apis::Core::Hashable
      
        # Maximum number of results of this type.
        # Corresponds to the JSON property `maxResults`
        # @return [Fixnum]
        attr_accessor :max_results
      
        # The feature type.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @max_results = args[:max_results] if args.key?(:max_results)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # Client image to perform Google Cloud Vision API tasks over.
      class Image
        include Google::Apis::Core::Hashable
      
        # Image content, represented as a stream of bytes.
        # Note: as with all `bytes` fields, protobuffers use a pure binary
        # representation, whereas JSON representations use base64.
        # Corresponds to the JSON property `content`
        # NOTE: Values are automatically base64 encoded/decoded in the client library.
        # @return [String]
        attr_accessor :content
      
        # External image source (Google Cloud Storage image location).
        # Corresponds to the JSON property `source`
        # @return [Google::Apis::VisionV1::ImageSource]
        attr_accessor :source
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @content = args[:content] if args.key?(:content)
          @source = args[:source] if args.key?(:source)
        end
      end
      
      # Image context and/or feature-specific parameters.
      class ImageContext
        include Google::Apis::Core::Hashable
      
        # Parameters for crop hints annotation request.
        # Corresponds to the JSON property `cropHintsParams`
        # @return [Google::Apis::VisionV1::CropHintsParams]
        attr_accessor :crop_hints_params
      
        # List of languages to use for TEXT_DETECTION. In most cases, an empty value
        # yields the best results since it enables automatic language detection. For
        # languages based on the Latin alphabet, setting `language_hints` is not
        # needed. In rare cases, when the language of the text in the image is known,
        # setting a hint will help get better results (although it will be a
        # significant hindrance if the hint is wrong). Text detection returns an
        # error if one or more of the specified languages is not one of the
        # [supported languages](/vision/docs/languages).
        # Corresponds to the JSON property `languageHints`
        # @return [Array<String>]
        attr_accessor :language_hints
      
        # Rectangle determined by min and max `LatLng` pairs.
        # Corresponds to the JSON property `latLongRect`
        # @return [Google::Apis::VisionV1::LatLongRect]
        attr_accessor :lat_long_rect
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @crop_hints_params = args[:crop_hints_params] if args.key?(:crop_hints_params)
          @language_hints = args[:language_hints] if args.key?(:language_hints)
          @lat_long_rect = args[:lat_long_rect] if args.key?(:lat_long_rect)
        end
      end
      
      # Stores image properties, such as dominant colors.
      class ImageProperties
        include Google::Apis::Core::Hashable
      
        # Set of dominant colors and their corresponding scores.
        # Corresponds to the JSON property `dominantColors`
        # @return [Google::Apis::VisionV1::DominantColorsAnnotation]
        attr_accessor :dominant_colors
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @dominant_colors = args[:dominant_colors] if args.key?(:dominant_colors)
        end
      end
      
      # External image source (Google Cloud Storage image location).
      class ImageSource
        include Google::Apis::Core::Hashable
      
        # NOTE: For new code `image_uri` below is preferred.
        # Google Cloud Storage image URI, which must be in the following form:
        # `gs://bucket_name/object_name` (for details, see
        # [Google Cloud Storage Request
        # URIs](https://cloud.google.com/storage/docs/reference-uris)).
        # NOTE: Cloud Storage object versioning is not supported.
        # Corresponds to the JSON property `gcsImageUri`
        # @return [String]
        attr_accessor :gcs_image_uri
      
        # Image URI which supports:
        # 1) Google Cloud Storage image URI, which must be in the following form:
        # `gs://bucket_name/object_name` (for details, see
        # [Google Cloud Storage Request
        # URIs](https://cloud.google.com/storage/docs/reference-uris)).
        # NOTE: Cloud Storage object versioning is not supported.
        # 2) Publicly accessible image HTTP/HTTPS URL.
        # This is preferred over the legacy `gcs_image_uri` above. When both
        # `gcs_image_uri` and `image_uri` are specified, `image_uri` takes
        # precedence.
        # Corresponds to the JSON property `imageUri`
        # @return [String]
        attr_accessor :image_uri
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @gcs_image_uri = args[:gcs_image_uri] if args.key?(:gcs_image_uri)
          @image_uri = args[:image_uri] if args.key?(:image_uri)
        end
      end
      
      # A face-specific landmark (for example, a face feature).
      # Landmark positions may fall outside the bounds of the image
      # if the face is near one or more edges of the image.
      # Therefore it is NOT guaranteed that `0 <= x < width` or
      # `0 <= y < height`.
      class Landmark
        include Google::Apis::Core::Hashable
      
        # A 3D position in the image, used primarily for Face detection landmarks.
        # A valid Position must have both x and y coordinates.
        # The position coordinates are in the same scale as the original image.
        # Corresponds to the JSON property `position`
        # @return [Google::Apis::VisionV1::Position]
        attr_accessor :position
      
        # Face landmark type.
        # Corresponds to the JSON property `type`
        # @return [String]
        attr_accessor :type
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @position = args[:position] if args.key?(:position)
          @type = args[:type] if args.key?(:type)
        end
      end
      
      # An object representing a latitude/longitude pair. This is expressed as a pair
      # of doubles representing degrees latitude and degrees longitude. Unless
      # specified otherwise, this must conform to the
      # <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
      # standard</a>. Values must be within normalized ranges.
      # Example of normalization code in Python:
      # def NormalizeLongitude(longitude):
      # """Wraps decimal degrees longitude to [-180.0, 180.0]."""
      # q, r = divmod(longitude, 360.0)
      # if r > 180.0 or (r == 180.0 and q <= -1.0):
      # return r - 360.0
      # return r
      # def NormalizeLatLng(latitude, longitude):
      # """Wraps decimal degrees latitude and longitude to
      # [-90.0, 90.0] and [-180.0, 180.0], respectively."""
      # r = latitude % 360.0
      # if r <= 90.0:
      # return r, NormalizeLongitude(longitude)
      # elif r >= 270.0:
      # return r - 360, NormalizeLongitude(longitude)
      # else:
      # return 180 - r, NormalizeLongitude(longitude + 180.0)
      # assert 180.0 == NormalizeLongitude(180.0)
      # assert -180.0 == NormalizeLongitude(-180.0)
      # assert -179.0 == NormalizeLongitude(181.0)
      # assert (0.0, 0.0) == NormalizeLatLng(360.0, 0.0)
      # assert (0.0, 0.0) == NormalizeLatLng(-360.0, 0.0)
      # assert (85.0, 180.0) == NormalizeLatLng(95.0, 0.0)
      # assert (-85.0, -170.0) == NormalizeLatLng(-95.0, 10.0)
      # assert (90.0, 10.0) == NormalizeLatLng(90.0, 10.0)
      # assert (-90.0, -10.0) == NormalizeLatLng(-90.0, -10.0)
      # assert (0.0, -170.0) == NormalizeLatLng(-180.0, 10.0)
      # assert (0.0, -170.0) == NormalizeLatLng(180.0, 10.0)
      # assert (-90.0, 10.0) == NormalizeLatLng(270.0, 10.0)
      # assert (90.0, 10.0) == NormalizeLatLng(-270.0, 10.0)
      class LatLng
        include Google::Apis::Core::Hashable
      
        # The latitude in degrees. It must be in the range [-90.0, +90.0].
        # Corresponds to the JSON property `latitude`
        # @return [Float]
        attr_accessor :latitude
      
        # The longitude in degrees. It must be in the range [-180.0, +180.0].
        # Corresponds to the JSON property `longitude`
        # @return [Float]
        attr_accessor :longitude
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @latitude = args[:latitude] if args.key?(:latitude)
          @longitude = args[:longitude] if args.key?(:longitude)
        end
      end
      
      # Rectangle determined by min and max `LatLng` pairs.
      class LatLongRect
        include Google::Apis::Core::Hashable
      
        # An object representing a latitude/longitude pair. This is expressed as a pair
        # of doubles representing degrees latitude and degrees longitude. Unless
        # specified otherwise, this must conform to the
        # <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
        # standard</a>. Values must be within normalized ranges.
        # Example of normalization code in Python:
        # def NormalizeLongitude(longitude):
        # """Wraps decimal degrees longitude to [-180.0, 180.0]."""
        # q, r = divmod(longitude, 360.0)
        # if r > 180.0 or (r == 180.0 and q <= -1.0):
        # return r - 360.0
        # return r
        # def NormalizeLatLng(latitude, longitude):
        # """Wraps decimal degrees latitude and longitude to
        # [-90.0, 90.0] and [-180.0, 180.0], respectively."""
        # r = latitude % 360.0
        # if r <= 90.0:
        # return r, NormalizeLongitude(longitude)
        # elif r >= 270.0:
        # return r - 360, NormalizeLongitude(longitude)
        # else:
        # return 180 - r, NormalizeLongitude(longitude + 180.0)
        # assert 180.0 == NormalizeLongitude(180.0)
        # assert -180.0 == NormalizeLongitude(-180.0)
        # assert -179.0 == NormalizeLongitude(181.0)
        # assert (0.0, 0.0) == NormalizeLatLng(360.0, 0.0)
        # assert (0.0, 0.0) == NormalizeLatLng(-360.0, 0.0)
        # assert (85.0, 180.0) == NormalizeLatLng(95.0, 0.0)
        # assert (-85.0, -170.0) == NormalizeLatLng(-95.0, 10.0)
        # assert (90.0, 10.0) == NormalizeLatLng(90.0, 10.0)
        # assert (-90.0, -10.0) == NormalizeLatLng(-90.0, -10.0)
        # assert (0.0, -170.0) == NormalizeLatLng(-180.0, 10.0)
        # assert (0.0, -170.0) == NormalizeLatLng(180.0, 10.0)
        # assert (-90.0, 10.0) == NormalizeLatLng(270.0, 10.0)
        # assert (90.0, 10.0) == NormalizeLatLng(-270.0, 10.0)
        # Corresponds to the JSON property `maxLatLng`
        # @return [Google::Apis::VisionV1::LatLng]
        attr_accessor :max_lat_lng
      
        # An object representing a latitude/longitude pair. This is expressed as a pair
        # of doubles representing degrees latitude and degrees longitude. Unless
        # specified otherwise, this must conform to the
        # <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
        # standard</a>. Values must be within normalized ranges.
        # Example of normalization code in Python:
        # def NormalizeLongitude(longitude):
        # """Wraps decimal degrees longitude to [-180.0, 180.0]."""
        # q, r = divmod(longitude, 360.0)
        # if r > 180.0 or (r == 180.0 and q <= -1.0):
        # return r - 360.0
        # return r
        # def NormalizeLatLng(latitude, longitude):
        # """Wraps decimal degrees latitude and longitude to
        # [-90.0, 90.0] and [-180.0, 180.0], respectively."""
        # r = latitude % 360.0
        # if r <= 90.0:
        # return r, NormalizeLongitude(longitude)
        # elif r >= 270.0:
        # return r - 360, NormalizeLongitude(longitude)
        # else:
        # return 180 - r, NormalizeLongitude(longitude + 180.0)
        # assert 180.0 == NormalizeLongitude(180.0)
        # assert -180.0 == NormalizeLongitude(-180.0)
        # assert -179.0 == NormalizeLongitude(181.0)
        # assert (0.0, 0.0) == NormalizeLatLng(360.0, 0.0)
        # assert (0.0, 0.0) == NormalizeLatLng(-360.0, 0.0)
        # assert (85.0, 180.0) == NormalizeLatLng(95.0, 0.0)
        # assert (-85.0, -170.0) == NormalizeLatLng(-95.0, 10.0)
        # assert (90.0, 10.0) == NormalizeLatLng(90.0, 10.0)
        # assert (-90.0, -10.0) == NormalizeLatLng(-90.0, -10.0)
        # assert (0.0, -170.0) == NormalizeLatLng(-180.0, 10.0)
        # assert (0.0, -170.0) == NormalizeLatLng(180.0, 10.0)
        # assert (-90.0, 10.0) == NormalizeLatLng(270.0, 10.0)
        # assert (90.0, 10.0) == NormalizeLatLng(-270.0, 10.0)
        # Corresponds to the JSON property `minLatLng`
        # @return [Google::Apis::VisionV1::LatLng]
        attr_accessor :min_lat_lng
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @max_lat_lng = args[:max_lat_lng] if args.key?(:max_lat_lng)
          @min_lat_lng = args[:min_lat_lng] if args.key?(:min_lat_lng)
        end
      end
      
      # Detected entity location information.
      class LocationInfo
        include Google::Apis::Core::Hashable
      
        # An object representing a latitude/longitude pair. This is expressed as a pair
        # of doubles representing degrees latitude and degrees longitude. Unless
        # specified otherwise, this must conform to the
        # <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
        # standard</a>. Values must be within normalized ranges.
        # Example of normalization code in Python:
        # def NormalizeLongitude(longitude):
        # """Wraps decimal degrees longitude to [-180.0, 180.0]."""
        # q, r = divmod(longitude, 360.0)
        # if r > 180.0 or (r == 180.0 and q <= -1.0):
        # return r - 360.0
        # return r
        # def NormalizeLatLng(latitude, longitude):
        # """Wraps decimal degrees latitude and longitude to
        # [-90.0, 90.0] and [-180.0, 180.0], respectively."""
        # r = latitude % 360.0
        # if r <= 90.0:
        # return r, NormalizeLongitude(longitude)
        # elif r >= 270.0:
        # return r - 360, NormalizeLongitude(longitude)
        # else:
        # return 180 - r, NormalizeLongitude(longitude + 180.0)
        # assert 180.0 == NormalizeLongitude(180.0)
        # assert -180.0 == NormalizeLongitude(-180.0)
        # assert -179.0 == NormalizeLongitude(181.0)
        # assert (0.0, 0.0) == NormalizeLatLng(360.0, 0.0)
        # assert (0.0, 0.0) == NormalizeLatLng(-360.0, 0.0)
        # assert (85.0, 180.0) == NormalizeLatLng(95.0, 0.0)
        # assert (-85.0, -170.0) == NormalizeLatLng(-95.0, 10.0)
        # assert (90.0, 10.0) == NormalizeLatLng(90.0, 10.0)
        # assert (-90.0, -10.0) == NormalizeLatLng(-90.0, -10.0)
        # assert (0.0, -170.0) == NormalizeLatLng(-180.0, 10.0)
        # assert (0.0, -170.0) == NormalizeLatLng(180.0, 10.0)
        # assert (-90.0, 10.0) == NormalizeLatLng(270.0, 10.0)
        # assert (90.0, 10.0) == NormalizeLatLng(-270.0, 10.0)
        # Corresponds to the JSON property `latLng`
        # @return [Google::Apis::VisionV1::LatLng]
        attr_accessor :lat_lng
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @lat_lng = args[:lat_lng] if args.key?(:lat_lng)
        end
      end
      
      # Detected page from OCR.
      class Page
        include Google::Apis::Core::Hashable
      
        # List of blocks of text, images etc on this page.
        # Corresponds to the JSON property `blocks`
        # @return [Array<Google::Apis::VisionV1::Block>]
        attr_accessor :blocks
      
        # Page height in pixels.
        # Corresponds to the JSON property `height`
        # @return [Fixnum]
        attr_accessor :height
      
        # Additional information detected on the structural component.
        # Corresponds to the JSON property `property`
        # @return [Google::Apis::VisionV1::TextProperty]
        attr_accessor :property
      
        # Page width in pixels.
        # Corresponds to the JSON property `width`
        # @return [Fixnum]
        attr_accessor :width
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @blocks = args[:blocks] if args.key?(:blocks)
          @height = args[:height] if args.key?(:height)
          @property = args[:property] if args.key?(:property)
          @width = args[:width] if args.key?(:width)
        end
      end
      
      # Structural unit of text representing a number of words in certain order.
      class Paragraph
        include Google::Apis::Core::Hashable
      
        # A bounding polygon for the detected image annotation.
        # Corresponds to the JSON property `boundingBox`
        # @return [Google::Apis::VisionV1::BoundingPoly]
        attr_accessor :bounding_box
      
        # Additional information detected on the structural component.
        # Corresponds to the JSON property `property`
        # @return [Google::Apis::VisionV1::TextProperty]
        attr_accessor :property
      
        # List of words in this paragraph.
        # Corresponds to the JSON property `words`
        # @return [Array<Google::Apis::VisionV1::Word>]
        attr_accessor :words
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bounding_box = args[:bounding_box] if args.key?(:bounding_box)
          @property = args[:property] if args.key?(:property)
          @words = args[:words] if args.key?(:words)
        end
      end
      
      # A 3D position in the image, used primarily for Face detection landmarks.
      # A valid Position must have both x and y coordinates.
      # The position coordinates are in the same scale as the original image.
      class Position
        include Google::Apis::Core::Hashable
      
        # X coordinate.
        # Corresponds to the JSON property `x`
        # @return [Float]
        attr_accessor :x
      
        # Y coordinate.
        # Corresponds to the JSON property `y`
        # @return [Float]
        attr_accessor :y
      
        # Z coordinate (or depth).
        # Corresponds to the JSON property `z`
        # @return [Float]
        attr_accessor :z
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @x = args[:x] if args.key?(:x)
          @y = args[:y] if args.key?(:y)
          @z = args[:z] if args.key?(:z)
        end
      end
      
      # A `Property` consists of a user-supplied name/value pair.
      class Property
        include Google::Apis::Core::Hashable
      
        # Name of the property.
        # Corresponds to the JSON property `name`
        # @return [String]
        attr_accessor :name
      
        # Value of numeric properties.
        # Corresponds to the JSON property `uint64Value`
        # @return [Fixnum]
        attr_accessor :uint64_value
      
        # Value of the property.
        # Corresponds to the JSON property `value`
        # @return [String]
        attr_accessor :value
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @name = args[:name] if args.key?(:name)
          @uint64_value = args[:uint64_value] if args.key?(:uint64_value)
          @value = args[:value] if args.key?(:value)
        end
      end
      
      # Set of features pertaining to the image, computed by computer vision
      # methods over safe-search verticals (for example, adult, spoof, medical,
      # violence).
      class SafeSearchAnnotation
        include Google::Apis::Core::Hashable
      
        # Represents the adult content likelihood for the image.
        # Corresponds to the JSON property `adult`
        # @return [String]
        attr_accessor :adult
      
        # Likelihood that this is a medical image.
        # Corresponds to the JSON property `medical`
        # @return [String]
        attr_accessor :medical
      
        # Spoof likelihood. The likelihood that an modification
        # was made to the image's canonical version to make it appear
        # funny or offensive.
        # Corresponds to the JSON property `spoof`
        # @return [String]
        attr_accessor :spoof
      
        # Violence likelihood.
        # Corresponds to the JSON property `violence`
        # @return [String]
        attr_accessor :violence
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @adult = args[:adult] if args.key?(:adult)
          @medical = args[:medical] if args.key?(:medical)
          @spoof = args[:spoof] if args.key?(:spoof)
          @violence = args[:violence] if args.key?(:violence)
        end
      end
      
      # The `Status` type defines a logical error model that is suitable for different
      # programming environments, including REST APIs and RPC APIs. It is used by
      # [gRPC](https://github.com/grpc). The error model is designed to be:
      # - Simple to use and understand for most users
      # - Flexible enough to meet unexpected needs
      # # Overview
      # The `Status` message contains three pieces of data: error code, error message,
      # and error details. The error code should be an enum value of
      # google.rpc.Code, but it may accept additional error codes if needed.  The
      # error message should be a developer-facing English message that helps
      # developers *understand* and *resolve* the error. If a localized user-facing
      # error message is needed, put the localized message in the error details or
      # localize it in the client. The optional error details may contain arbitrary
      # information about the error. There is a predefined set of error detail types
      # in the package `google.rpc` that can be used for common error conditions.
      # # Language mapping
      # The `Status` message is the logical representation of the error model, but it
      # is not necessarily the actual wire format. When the `Status` message is
      # exposed in different client libraries and different wire protocols, it can be
      # mapped differently. For example, it will likely be mapped to some exceptions
      # in Java, but more likely mapped to some error codes in C.
      # # Other uses
      # The error model and the `Status` message can be used in a variety of
      # environments, either with or without APIs, to provide a
      # consistent developer experience across different environments.
      # Example uses of this error model include:
      # - Partial errors. If a service needs to return partial errors to the client,
      # it may embed the `Status` in the normal response to indicate the partial
      # errors.
      # - Workflow errors. A typical workflow has multiple steps. Each step may
      # have a `Status` message for error reporting.
      # - Batch operations. If a client uses batch request and batch response, the
      # `Status` message should be used directly inside batch response, one for
      # each error sub-response.
      # - Asynchronous operations. If an API call embeds asynchronous operation
      # results in its response, the status of those operations should be
      # represented directly using the `Status` message.
      # - Logging. If some API errors are stored in logs, the message `Status` could
      # be used directly after any stripping needed for security/privacy reasons.
      class Status
        include Google::Apis::Core::Hashable
      
        # The status code, which should be an enum value of google.rpc.Code.
        # Corresponds to the JSON property `code`
        # @return [Fixnum]
        attr_accessor :code
      
        # A list of messages that carry the error details.  There is a common set of
        # message types for APIs to use.
        # Corresponds to the JSON property `details`
        # @return [Array<Hash<String,Object>>]
        attr_accessor :details
      
        # A developer-facing error message, which should be in English. Any
        # user-facing error message should be localized and sent in the
        # google.rpc.Status.details field, or localized by the client.
        # Corresponds to the JSON property `message`
        # @return [String]
        attr_accessor :message
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @code = args[:code] if args.key?(:code)
          @details = args[:details] if args.key?(:details)
          @message = args[:message] if args.key?(:message)
        end
      end
      
      # A single symbol representation.
      class Symbol
        include Google::Apis::Core::Hashable
      
        # A bounding polygon for the detected image annotation.
        # Corresponds to the JSON property `boundingBox`
        # @return [Google::Apis::VisionV1::BoundingPoly]
        attr_accessor :bounding_box
      
        # Additional information detected on the structural component.
        # Corresponds to the JSON property `property`
        # @return [Google::Apis::VisionV1::TextProperty]
        attr_accessor :property
      
        # The actual UTF-8 representation of the symbol.
        # Corresponds to the JSON property `text`
        # @return [String]
        attr_accessor :text
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bounding_box = args[:bounding_box] if args.key?(:bounding_box)
          @property = args[:property] if args.key?(:property)
          @text = args[:text] if args.key?(:text)
        end
      end
      
      # TextAnnotation contains a structured representation of OCR extracted text.
      # The hierarchy of an OCR extracted text structure is like this:
      # TextAnnotation -> Page -> Block -> Paragraph -> Word -> Symbol
      # Each structural component, starting from Page, may further have their own
      # properties. Properties describe detected languages, breaks etc.. Please
      # refer to the google.cloud.vision.v1.TextAnnotation.TextProperty message
      # definition below for more detail.
      class TextAnnotation
        include Google::Apis::Core::Hashable
      
        # List of pages detected by OCR.
        # Corresponds to the JSON property `pages`
        # @return [Array<Google::Apis::VisionV1::Page>]
        attr_accessor :pages
      
        # UTF-8 text detected on the pages.
        # Corresponds to the JSON property `text`
        # @return [String]
        attr_accessor :text
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @pages = args[:pages] if args.key?(:pages)
          @text = args[:text] if args.key?(:text)
        end
      end
      
      # Additional information detected on the structural component.
      class TextProperty
        include Google::Apis::Core::Hashable
      
        # Detected start or end of a structural component.
        # Corresponds to the JSON property `detectedBreak`
        # @return [Google::Apis::VisionV1::DetectedBreak]
        attr_accessor :detected_break
      
        # A list of detected languages together with confidence.
        # Corresponds to the JSON property `detectedLanguages`
        # @return [Array<Google::Apis::VisionV1::DetectedLanguage>]
        attr_accessor :detected_languages
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @detected_break = args[:detected_break] if args.key?(:detected_break)
          @detected_languages = args[:detected_languages] if args.key?(:detected_languages)
        end
      end
      
      # A vertex represents a 2D point in the image.
      # NOTE: the vertex coordinates are in the same scale as the original image.
      class Vertex
        include Google::Apis::Core::Hashable
      
        # X coordinate.
        # Corresponds to the JSON property `x`
        # @return [Fixnum]
        attr_accessor :x
      
        # Y coordinate.
        # Corresponds to the JSON property `y`
        # @return [Fixnum]
        attr_accessor :y
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @x = args[:x] if args.key?(:x)
          @y = args[:y] if args.key?(:y)
        end
      end
      
      # Relevant information for the image from the Internet.
      class WebDetection
        include Google::Apis::Core::Hashable
      
        # Fully matching images from the Internet.
        # Can include resized copies of the query image.
        # Corresponds to the JSON property `fullMatchingImages`
        # @return [Array<Google::Apis::VisionV1::WebImage>]
        attr_accessor :full_matching_images
      
        # Web pages containing the matching images from the Internet.
        # Corresponds to the JSON property `pagesWithMatchingImages`
        # @return [Array<Google::Apis::VisionV1::WebPage>]
        attr_accessor :pages_with_matching_images
      
        # Partial matching images from the Internet.
        # Those images are similar enough to share some key-point features. For
        # example an original image will likely have partial matching for its crops.
        # Corresponds to the JSON property `partialMatchingImages`
        # @return [Array<Google::Apis::VisionV1::WebImage>]
        attr_accessor :partial_matching_images
      
        # The visually similar image results.
        # Corresponds to the JSON property `visuallySimilarImages`
        # @return [Array<Google::Apis::VisionV1::WebImage>]
        attr_accessor :visually_similar_images
      
        # Deduced entities from similar images on the Internet.
        # Corresponds to the JSON property `webEntities`
        # @return [Array<Google::Apis::VisionV1::WebEntity>]
        attr_accessor :web_entities
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @full_matching_images = args[:full_matching_images] if args.key?(:full_matching_images)
          @pages_with_matching_images = args[:pages_with_matching_images] if args.key?(:pages_with_matching_images)
          @partial_matching_images = args[:partial_matching_images] if args.key?(:partial_matching_images)
          @visually_similar_images = args[:visually_similar_images] if args.key?(:visually_similar_images)
          @web_entities = args[:web_entities] if args.key?(:web_entities)
        end
      end
      
      # Entity deduced from similar images on the Internet.
      class WebEntity
        include Google::Apis::Core::Hashable
      
        # Canonical description of the entity, in English.
        # Corresponds to the JSON property `description`
        # @return [String]
        attr_accessor :description
      
        # Opaque entity ID.
        # Corresponds to the JSON property `entityId`
        # @return [String]
        attr_accessor :entity_id
      
        # Overall relevancy score for the entity.
        # Not normalized and not comparable across different image queries.
        # Corresponds to the JSON property `score`
        # @return [Float]
        attr_accessor :score
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @description = args[:description] if args.key?(:description)
          @entity_id = args[:entity_id] if args.key?(:entity_id)
          @score = args[:score] if args.key?(:score)
        end
      end
      
      # Metadata for online images.
      class WebImage
        include Google::Apis::Core::Hashable
      
        # (Deprecated) Overall relevancy score for the image.
        # Corresponds to the JSON property `score`
        # @return [Float]
        attr_accessor :score
      
        # The result image URL.
        # Corresponds to the JSON property `url`
        # @return [String]
        attr_accessor :url
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @score = args[:score] if args.key?(:score)
          @url = args[:url] if args.key?(:url)
        end
      end
      
      # Metadata for web pages.
      class WebPage
        include Google::Apis::Core::Hashable
      
        # (Deprecated) Overall relevancy score for the web page.
        # Corresponds to the JSON property `score`
        # @return [Float]
        attr_accessor :score
      
        # The result web page URL.
        # Corresponds to the JSON property `url`
        # @return [String]
        attr_accessor :url
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @score = args[:score] if args.key?(:score)
          @url = args[:url] if args.key?(:url)
        end
      end
      
      # A word representation.
      class Word
        include Google::Apis::Core::Hashable
      
        # A bounding polygon for the detected image annotation.
        # Corresponds to the JSON property `boundingBox`
        # @return [Google::Apis::VisionV1::BoundingPoly]
        attr_accessor :bounding_box
      
        # Additional information detected on the structural component.
        # Corresponds to the JSON property `property`
        # @return [Google::Apis::VisionV1::TextProperty]
        attr_accessor :property
      
        # List of symbols in the word.
        # The order of the symbols follows the natural reading order.
        # Corresponds to the JSON property `symbols`
        # @return [Array<Google::Apis::VisionV1::Symbol>]
        attr_accessor :symbols
      
        def initialize(**args)
           update!(**args)
        end
      
        # Update properties of this object
        def update!(**args)
          @bounding_box = args[:bounding_box] if args.key?(:bounding_box)
          @property = args[:property] if args.key?(:property)
          @symbols = args[:symbols] if args.key?(:symbols)
        end
      end
    end
  end
end
