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
    module SheetsV4
      
      class AddBandingRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddBandingResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddChartRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddChartResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddConditionalFormatRuleRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddFilterViewRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddFilterViewResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddNamedRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddNamedRangeResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddProtectedRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddProtectedRangeResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddSheetRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddSheetResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppendCellsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppendDimensionRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AppendValuesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoFillRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AutoResizeDimensionsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BandedRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BandingProperties
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BasicChartAxis
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BasicChartDomain
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BasicChartSeries
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BasicChartSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BasicFilter
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BatchClearValuesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BatchClearValuesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BatchGetValuesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BatchUpdateSpreadsheetRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BatchUpdateSpreadsheetResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BatchUpdateValuesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BatchUpdateValuesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BooleanCondition
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BooleanRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Border
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Borders
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class BubbleChartSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CandlestickChartSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CandlestickData
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CandlestickDomain
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CandlestickSeries
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CellData
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CellFormat
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ChartData
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ChartSourceRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ChartSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClearBasicFilterRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClearValuesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ClearValuesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Color
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ConditionValue
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ConditionalFormatRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CopyPasteRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CopySheetToAnotherSpreadsheetRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class CutPasteRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DataValidationRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteBandingRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteConditionalFormatRuleRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteConditionalFormatRuleResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteDimensionRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteEmbeddedObjectRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteFilterViewRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteNamedRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteProtectedRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DeleteSheetRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DimensionProperties
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DimensionRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DuplicateFilterViewRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DuplicateFilterViewResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DuplicateSheetRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class DuplicateSheetResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Editors
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class EmbeddedChart
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class EmbeddedObjectPosition
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ErrorValue
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ExtendedValue
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class FilterCriteria
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class FilterView
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class FindReplaceRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class FindReplaceResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GradientRule
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GridCoordinate
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GridData
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GridProperties
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class GridRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HistogramChartSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class HistogramSeries
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InsertDimensionRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InsertRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class InterpolationPoint
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class IterativeCalculationSettings
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class MergeCellsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class MoveDimensionRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NamedRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class NumberFormat
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class OrgChartSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class OverlayPosition
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Padding
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PasteDataRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PieChartSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PivotFilterCriteria
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PivotGroup
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PivotGroupSortValueBucket
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PivotGroupValueMetadata
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PivotTable
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class PivotValue
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ProtectedRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RandomizeRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RepeatCellRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Request
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Response
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class RowData
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetBasicFilterRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SetDataValidationRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Sheet
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SheetProperties
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SortRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SortSpec
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SourceAndDestination
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class Spreadsheet
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class SpreadsheetProperties
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TextFormat
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TextFormatRun
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TextRotation
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class TextToColumnsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UnmergeCellsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateBandingRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateBordersRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateCellsRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateChartSpecRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateConditionalFormatRuleRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateConditionalFormatRuleResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateDimensionPropertiesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateEmbeddedObjectPositionRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateEmbeddedObjectPositionResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateFilterViewRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateNamedRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateProtectedRangeRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateSheetPropertiesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateSpreadsheetPropertiesRequest
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class UpdateValuesResponse
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class ValueRange
        class Representation < Google::Apis::Core::JsonRepresentation; end
      
        include Google::Apis::Core::JsonObjectSupport
      end
      
      class AddBandingRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :banded_range, as: 'bandedRange', class: Google::Apis::SheetsV4::BandedRange, decorator: Google::Apis::SheetsV4::BandedRange::Representation
      
        end
      end
      
      class AddBandingResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :banded_range, as: 'bandedRange', class: Google::Apis::SheetsV4::BandedRange, decorator: Google::Apis::SheetsV4::BandedRange::Representation
      
        end
      end
      
      class AddChartRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :chart, as: 'chart', class: Google::Apis::SheetsV4::EmbeddedChart, decorator: Google::Apis::SheetsV4::EmbeddedChart::Representation
      
        end
      end
      
      class AddChartResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :chart, as: 'chart', class: Google::Apis::SheetsV4::EmbeddedChart, decorator: Google::Apis::SheetsV4::EmbeddedChart::Representation
      
        end
      end
      
      class AddConditionalFormatRuleRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :index, as: 'index'
          property :rule, as: 'rule', class: Google::Apis::SheetsV4::ConditionalFormatRule, decorator: Google::Apis::SheetsV4::ConditionalFormatRule::Representation
      
        end
      end
      
      class AddFilterViewRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :filter, as: 'filter', class: Google::Apis::SheetsV4::FilterView, decorator: Google::Apis::SheetsV4::FilterView::Representation
      
        end
      end
      
      class AddFilterViewResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :filter, as: 'filter', class: Google::Apis::SheetsV4::FilterView, decorator: Google::Apis::SheetsV4::FilterView::Representation
      
        end
      end
      
      class AddNamedRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :named_range, as: 'namedRange', class: Google::Apis::SheetsV4::NamedRange, decorator: Google::Apis::SheetsV4::NamedRange::Representation
      
        end
      end
      
      class AddNamedRangeResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :named_range, as: 'namedRange', class: Google::Apis::SheetsV4::NamedRange, decorator: Google::Apis::SheetsV4::NamedRange::Representation
      
        end
      end
      
      class AddProtectedRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :protected_range, as: 'protectedRange', class: Google::Apis::SheetsV4::ProtectedRange, decorator: Google::Apis::SheetsV4::ProtectedRange::Representation
      
        end
      end
      
      class AddProtectedRangeResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :protected_range, as: 'protectedRange', class: Google::Apis::SheetsV4::ProtectedRange, decorator: Google::Apis::SheetsV4::ProtectedRange::Representation
      
        end
      end
      
      class AddSheetRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :properties, as: 'properties', class: Google::Apis::SheetsV4::SheetProperties, decorator: Google::Apis::SheetsV4::SheetProperties::Representation
      
        end
      end
      
      class AddSheetResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :properties, as: 'properties', class: Google::Apis::SheetsV4::SheetProperties, decorator: Google::Apis::SheetsV4::SheetProperties::Representation
      
        end
      end
      
      class AppendCellsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          collection :rows, as: 'rows', class: Google::Apis::SheetsV4::RowData, decorator: Google::Apis::SheetsV4::RowData::Representation
      
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class AppendDimensionRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :dimension, as: 'dimension'
          property :length, as: 'length'
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class AppendValuesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :spreadsheet_id, as: 'spreadsheetId'
          property :table_range, as: 'tableRange'
          property :updates, as: 'updates', class: Google::Apis::SheetsV4::UpdateValuesResponse, decorator: Google::Apis::SheetsV4::UpdateValuesResponse::Representation
      
        end
      end
      
      class AutoFillRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :source_and_destination, as: 'sourceAndDestination', class: Google::Apis::SheetsV4::SourceAndDestination, decorator: Google::Apis::SheetsV4::SourceAndDestination::Representation
      
          property :use_alternate_series, as: 'useAlternateSeries'
        end
      end
      
      class AutoResizeDimensionsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :dimensions, as: 'dimensions', class: Google::Apis::SheetsV4::DimensionRange, decorator: Google::Apis::SheetsV4::DimensionRange::Representation
      
        end
      end
      
      class BandedRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :banded_range_id, as: 'bandedRangeId'
          property :column_properties, as: 'columnProperties', class: Google::Apis::SheetsV4::BandingProperties, decorator: Google::Apis::SheetsV4::BandingProperties::Representation
      
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :row_properties, as: 'rowProperties', class: Google::Apis::SheetsV4::BandingProperties, decorator: Google::Apis::SheetsV4::BandingProperties::Representation
      
        end
      end
      
      class BandingProperties
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :first_band_color, as: 'firstBandColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :footer_color, as: 'footerColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :header_color, as: 'headerColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :second_band_color, as: 'secondBandColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
        end
      end
      
      class BasicChartAxis
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :format, as: 'format', class: Google::Apis::SheetsV4::TextFormat, decorator: Google::Apis::SheetsV4::TextFormat::Representation
      
          property :position, as: 'position'
          property :title, as: 'title'
        end
      end
      
      class BasicChartDomain
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :domain, as: 'domain', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :reversed, as: 'reversed'
        end
      end
      
      class BasicChartSeries
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :series, as: 'series', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :target_axis, as: 'targetAxis'
          property :type, as: 'type'
        end
      end
      
      class BasicChartSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :axis, as: 'axis', class: Google::Apis::SheetsV4::BasicChartAxis, decorator: Google::Apis::SheetsV4::BasicChartAxis::Representation
      
          property :chart_type, as: 'chartType'
          collection :domains, as: 'domains', class: Google::Apis::SheetsV4::BasicChartDomain, decorator: Google::Apis::SheetsV4::BasicChartDomain::Representation
      
          property :header_count, as: 'headerCount'
          property :interpolate_nulls, as: 'interpolateNulls'
          property :legend_position, as: 'legendPosition'
          property :line_smoothing, as: 'lineSmoothing'
          collection :series, as: 'series', class: Google::Apis::SheetsV4::BasicChartSeries, decorator: Google::Apis::SheetsV4::BasicChartSeries::Representation
      
          property :stacked_type, as: 'stackedType'
          property :three_dimensional, as: 'threeDimensional'
        end
      end
      
      class BasicFilter
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          hash :criteria, as: 'criteria', class: Google::Apis::SheetsV4::FilterCriteria, decorator: Google::Apis::SheetsV4::FilterCriteria::Representation
      
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          collection :sort_specs, as: 'sortSpecs', class: Google::Apis::SheetsV4::SortSpec, decorator: Google::Apis::SheetsV4::SortSpec::Representation
      
        end
      end
      
      class BatchClearValuesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :ranges, as: 'ranges'
        end
      end
      
      class BatchClearValuesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :cleared_ranges, as: 'clearedRanges'
          property :spreadsheet_id, as: 'spreadsheetId'
        end
      end
      
      class BatchGetValuesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :spreadsheet_id, as: 'spreadsheetId'
          collection :value_ranges, as: 'valueRanges', class: Google::Apis::SheetsV4::ValueRange, decorator: Google::Apis::SheetsV4::ValueRange::Representation
      
        end
      end
      
      class BatchUpdateSpreadsheetRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :include_spreadsheet_in_response, as: 'includeSpreadsheetInResponse'
          collection :requests, as: 'requests', class: Google::Apis::SheetsV4::Request, decorator: Google::Apis::SheetsV4::Request::Representation
      
          property :response_include_grid_data, as: 'responseIncludeGridData'
          collection :response_ranges, as: 'responseRanges'
        end
      end
      
      class BatchUpdateSpreadsheetResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :replies, as: 'replies', class: Google::Apis::SheetsV4::Response, decorator: Google::Apis::SheetsV4::Response::Representation
      
          property :spreadsheet_id, as: 'spreadsheetId'
          property :updated_spreadsheet, as: 'updatedSpreadsheet', class: Google::Apis::SheetsV4::Spreadsheet, decorator: Google::Apis::SheetsV4::Spreadsheet::Representation
      
        end
      end
      
      class BatchUpdateValuesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :data, as: 'data', class: Google::Apis::SheetsV4::ValueRange, decorator: Google::Apis::SheetsV4::ValueRange::Representation
      
          property :include_values_in_response, as: 'includeValuesInResponse'
          property :response_date_time_render_option, as: 'responseDateTimeRenderOption'
          property :response_value_render_option, as: 'responseValueRenderOption'
          property :value_input_option, as: 'valueInputOption'
        end
      end
      
      class BatchUpdateValuesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :responses, as: 'responses', class: Google::Apis::SheetsV4::UpdateValuesResponse, decorator: Google::Apis::SheetsV4::UpdateValuesResponse::Representation
      
          property :spreadsheet_id, as: 'spreadsheetId'
          property :total_updated_cells, as: 'totalUpdatedCells'
          property :total_updated_columns, as: 'totalUpdatedColumns'
          property :total_updated_rows, as: 'totalUpdatedRows'
          property :total_updated_sheets, as: 'totalUpdatedSheets'
        end
      end
      
      class BooleanCondition
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :type, as: 'type'
          collection :values, as: 'values', class: Google::Apis::SheetsV4::ConditionValue, decorator: Google::Apis::SheetsV4::ConditionValue::Representation
      
        end
      end
      
      class BooleanRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :condition, as: 'condition', class: Google::Apis::SheetsV4::BooleanCondition, decorator: Google::Apis::SheetsV4::BooleanCondition::Representation
      
          property :format, as: 'format', class: Google::Apis::SheetsV4::CellFormat, decorator: Google::Apis::SheetsV4::CellFormat::Representation
      
        end
      end
      
      class Border
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :color, as: 'color', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :style, as: 'style'
          property :width, as: 'width'
        end
      end
      
      class Borders
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bottom, as: 'bottom', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
          property :left, as: 'left', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
          property :right, as: 'right', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
          property :top, as: 'top', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
        end
      end
      
      class BubbleChartSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bubble_border_color, as: 'bubbleBorderColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :bubble_labels, as: 'bubbleLabels', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :bubble_max_radius_size, as: 'bubbleMaxRadiusSize'
          property :bubble_min_radius_size, as: 'bubbleMinRadiusSize'
          property :bubble_opacity, as: 'bubbleOpacity'
          property :bubble_sizes, as: 'bubbleSizes', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :bubble_text_style, as: 'bubbleTextStyle', class: Google::Apis::SheetsV4::TextFormat, decorator: Google::Apis::SheetsV4::TextFormat::Representation
      
          property :domain, as: 'domain', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :group_ids, as: 'groupIds', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :legend_position, as: 'legendPosition'
          property :series, as: 'series', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
        end
      end
      
      class CandlestickChartSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :data, as: 'data', class: Google::Apis::SheetsV4::CandlestickData, decorator: Google::Apis::SheetsV4::CandlestickData::Representation
      
          property :domain, as: 'domain', class: Google::Apis::SheetsV4::CandlestickDomain, decorator: Google::Apis::SheetsV4::CandlestickDomain::Representation
      
        end
      end
      
      class CandlestickData
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :close_series, as: 'closeSeries', class: Google::Apis::SheetsV4::CandlestickSeries, decorator: Google::Apis::SheetsV4::CandlestickSeries::Representation
      
          property :high_series, as: 'highSeries', class: Google::Apis::SheetsV4::CandlestickSeries, decorator: Google::Apis::SheetsV4::CandlestickSeries::Representation
      
          property :low_series, as: 'lowSeries', class: Google::Apis::SheetsV4::CandlestickSeries, decorator: Google::Apis::SheetsV4::CandlestickSeries::Representation
      
          property :open_series, as: 'openSeries', class: Google::Apis::SheetsV4::CandlestickSeries, decorator: Google::Apis::SheetsV4::CandlestickSeries::Representation
      
        end
      end
      
      class CandlestickDomain
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :data, as: 'data', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :reversed, as: 'reversed'
        end
      end
      
      class CandlestickSeries
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :data, as: 'data', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
        end
      end
      
      class CellData
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :data_validation, as: 'dataValidation', class: Google::Apis::SheetsV4::DataValidationRule, decorator: Google::Apis::SheetsV4::DataValidationRule::Representation
      
          property :effective_format, as: 'effectiveFormat', class: Google::Apis::SheetsV4::CellFormat, decorator: Google::Apis::SheetsV4::CellFormat::Representation
      
          property :effective_value, as: 'effectiveValue', class: Google::Apis::SheetsV4::ExtendedValue, decorator: Google::Apis::SheetsV4::ExtendedValue::Representation
      
          property :formatted_value, as: 'formattedValue'
          property :hyperlink, as: 'hyperlink'
          property :note, as: 'note'
          property :pivot_table, as: 'pivotTable', class: Google::Apis::SheetsV4::PivotTable, decorator: Google::Apis::SheetsV4::PivotTable::Representation
      
          collection :text_format_runs, as: 'textFormatRuns', class: Google::Apis::SheetsV4::TextFormatRun, decorator: Google::Apis::SheetsV4::TextFormatRun::Representation
      
          property :user_entered_format, as: 'userEnteredFormat', class: Google::Apis::SheetsV4::CellFormat, decorator: Google::Apis::SheetsV4::CellFormat::Representation
      
          property :user_entered_value, as: 'userEnteredValue', class: Google::Apis::SheetsV4::ExtendedValue, decorator: Google::Apis::SheetsV4::ExtendedValue::Representation
      
        end
      end
      
      class CellFormat
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :background_color, as: 'backgroundColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :borders, as: 'borders', class: Google::Apis::SheetsV4::Borders, decorator: Google::Apis::SheetsV4::Borders::Representation
      
          property :horizontal_alignment, as: 'horizontalAlignment'
          property :hyperlink_display_type, as: 'hyperlinkDisplayType'
          property :number_format, as: 'numberFormat', class: Google::Apis::SheetsV4::NumberFormat, decorator: Google::Apis::SheetsV4::NumberFormat::Representation
      
          property :padding, as: 'padding', class: Google::Apis::SheetsV4::Padding, decorator: Google::Apis::SheetsV4::Padding::Representation
      
          property :text_direction, as: 'textDirection'
          property :text_format, as: 'textFormat', class: Google::Apis::SheetsV4::TextFormat, decorator: Google::Apis::SheetsV4::TextFormat::Representation
      
          property :text_rotation, as: 'textRotation', class: Google::Apis::SheetsV4::TextRotation, decorator: Google::Apis::SheetsV4::TextRotation::Representation
      
          property :vertical_alignment, as: 'verticalAlignment'
          property :wrap_strategy, as: 'wrapStrategy'
        end
      end
      
      class ChartData
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :source_range, as: 'sourceRange', class: Google::Apis::SheetsV4::ChartSourceRange, decorator: Google::Apis::SheetsV4::ChartSourceRange::Representation
      
        end
      end
      
      class ChartSourceRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :sources, as: 'sources', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class ChartSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :alt_text, as: 'altText'
          property :background_color, as: 'backgroundColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :basic_chart, as: 'basicChart', class: Google::Apis::SheetsV4::BasicChartSpec, decorator: Google::Apis::SheetsV4::BasicChartSpec::Representation
      
          property :bubble_chart, as: 'bubbleChart', class: Google::Apis::SheetsV4::BubbleChartSpec, decorator: Google::Apis::SheetsV4::BubbleChartSpec::Representation
      
          property :candlestick_chart, as: 'candlestickChart', class: Google::Apis::SheetsV4::CandlestickChartSpec, decorator: Google::Apis::SheetsV4::CandlestickChartSpec::Representation
      
          property :font_name, as: 'fontName'
          property :hidden_dimension_strategy, as: 'hiddenDimensionStrategy'
          property :histogram_chart, as: 'histogramChart', class: Google::Apis::SheetsV4::HistogramChartSpec, decorator: Google::Apis::SheetsV4::HistogramChartSpec::Representation
      
          property :maximized, as: 'maximized'
          property :org_chart, as: 'orgChart', class: Google::Apis::SheetsV4::OrgChartSpec, decorator: Google::Apis::SheetsV4::OrgChartSpec::Representation
      
          property :pie_chart, as: 'pieChart', class: Google::Apis::SheetsV4::PieChartSpec, decorator: Google::Apis::SheetsV4::PieChartSpec::Representation
      
          property :title, as: 'title'
          property :title_text_format, as: 'titleTextFormat', class: Google::Apis::SheetsV4::TextFormat, decorator: Google::Apis::SheetsV4::TextFormat::Representation
      
        end
      end
      
      class ClearBasicFilterRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class ClearValuesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
        end
      end
      
      class ClearValuesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cleared_range, as: 'clearedRange'
          property :spreadsheet_id, as: 'spreadsheetId'
        end
      end
      
      class Color
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :alpha, as: 'alpha'
          property :blue, as: 'blue'
          property :green, as: 'green'
          property :red, as: 'red'
        end
      end
      
      class ConditionValue
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :relative_date, as: 'relativeDate'
          property :user_entered_value, as: 'userEnteredValue'
        end
      end
      
      class ConditionalFormatRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :boolean_rule, as: 'booleanRule', class: Google::Apis::SheetsV4::BooleanRule, decorator: Google::Apis::SheetsV4::BooleanRule::Representation
      
          property :gradient_rule, as: 'gradientRule', class: Google::Apis::SheetsV4::GradientRule, decorator: Google::Apis::SheetsV4::GradientRule::Representation
      
          collection :ranges, as: 'ranges', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class CopyPasteRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :destination, as: 'destination', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :paste_orientation, as: 'pasteOrientation'
          property :paste_type, as: 'pasteType'
          property :source, as: 'source', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class CopySheetToAnotherSpreadsheetRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :destination_spreadsheet_id, as: 'destinationSpreadsheetId'
        end
      end
      
      class CutPasteRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :destination, as: 'destination', class: Google::Apis::SheetsV4::GridCoordinate, decorator: Google::Apis::SheetsV4::GridCoordinate::Representation
      
          property :paste_type, as: 'pasteType'
          property :source, as: 'source', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class DataValidationRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :condition, as: 'condition', class: Google::Apis::SheetsV4::BooleanCondition, decorator: Google::Apis::SheetsV4::BooleanCondition::Representation
      
          property :input_message, as: 'inputMessage'
          property :show_custom_ui, as: 'showCustomUi'
          property :strict, as: 'strict'
        end
      end
      
      class DeleteBandingRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :banded_range_id, as: 'bandedRangeId'
        end
      end
      
      class DeleteConditionalFormatRuleRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :index, as: 'index'
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class DeleteConditionalFormatRuleResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :rule, as: 'rule', class: Google::Apis::SheetsV4::ConditionalFormatRule, decorator: Google::Apis::SheetsV4::ConditionalFormatRule::Representation
      
        end
      end
      
      class DeleteDimensionRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :range, as: 'range', class: Google::Apis::SheetsV4::DimensionRange, decorator: Google::Apis::SheetsV4::DimensionRange::Representation
      
        end
      end
      
      class DeleteEmbeddedObjectRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :object_id_prop, as: 'objectId'
        end
      end
      
      class DeleteFilterViewRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :filter_id, as: 'filterId'
        end
      end
      
      class DeleteNamedRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :named_range_id, as: 'namedRangeId'
        end
      end
      
      class DeleteProtectedRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :protected_range_id, as: 'protectedRangeId'
        end
      end
      
      class DeleteRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :shift_dimension, as: 'shiftDimension'
        end
      end
      
      class DeleteSheetRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class DimensionProperties
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :hidden_by_filter, as: 'hiddenByFilter'
          property :hidden_by_user, as: 'hiddenByUser'
          property :pixel_size, as: 'pixelSize'
        end
      end
      
      class DimensionRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :dimension, as: 'dimension'
          property :end_index, as: 'endIndex'
          property :sheet_id, as: 'sheetId'
          property :start_index, as: 'startIndex'
        end
      end
      
      class DuplicateFilterViewRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :filter_id, as: 'filterId'
        end
      end
      
      class DuplicateFilterViewResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :filter, as: 'filter', class: Google::Apis::SheetsV4::FilterView, decorator: Google::Apis::SheetsV4::FilterView::Representation
      
        end
      end
      
      class DuplicateSheetRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :insert_sheet_index, as: 'insertSheetIndex'
          property :new_sheet_id, as: 'newSheetId'
          property :new_sheet_name, as: 'newSheetName'
          property :source_sheet_id, as: 'sourceSheetId'
        end
      end
      
      class DuplicateSheetResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :properties, as: 'properties', class: Google::Apis::SheetsV4::SheetProperties, decorator: Google::Apis::SheetsV4::SheetProperties::Representation
      
        end
      end
      
      class Editors
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :domain_users_can_edit, as: 'domainUsersCanEdit'
          collection :groups, as: 'groups'
          collection :users, as: 'users'
        end
      end
      
      class EmbeddedChart
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :chart_id, as: 'chartId'
          property :position, as: 'position', class: Google::Apis::SheetsV4::EmbeddedObjectPosition, decorator: Google::Apis::SheetsV4::EmbeddedObjectPosition::Representation
      
          property :spec, as: 'spec', class: Google::Apis::SheetsV4::ChartSpec, decorator: Google::Apis::SheetsV4::ChartSpec::Representation
      
        end
      end
      
      class EmbeddedObjectPosition
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :new_sheet, as: 'newSheet'
          property :overlay_position, as: 'overlayPosition', class: Google::Apis::SheetsV4::OverlayPosition, decorator: Google::Apis::SheetsV4::OverlayPosition::Representation
      
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class ErrorValue
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :message, as: 'message'
          property :type, as: 'type'
        end
      end
      
      class ExtendedValue
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bool_value, as: 'boolValue'
          property :error_value, as: 'errorValue', class: Google::Apis::SheetsV4::ErrorValue, decorator: Google::Apis::SheetsV4::ErrorValue::Representation
      
          property :formula_value, as: 'formulaValue'
          property :number_value, as: 'numberValue'
          property :string_value, as: 'stringValue'
        end
      end
      
      class FilterCriteria
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :condition, as: 'condition', class: Google::Apis::SheetsV4::BooleanCondition, decorator: Google::Apis::SheetsV4::BooleanCondition::Representation
      
          collection :hidden_values, as: 'hiddenValues'
        end
      end
      
      class FilterView
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          hash :criteria, as: 'criteria', class: Google::Apis::SheetsV4::FilterCriteria, decorator: Google::Apis::SheetsV4::FilterCriteria::Representation
      
          property :filter_view_id, as: 'filterViewId'
          property :named_range_id, as: 'namedRangeId'
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          collection :sort_specs, as: 'sortSpecs', class: Google::Apis::SheetsV4::SortSpec, decorator: Google::Apis::SheetsV4::SortSpec::Representation
      
          property :title, as: 'title'
        end
      end
      
      class FindReplaceRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :all_sheets, as: 'allSheets'
          property :find, as: 'find'
          property :include_formulas, as: 'includeFormulas'
          property :match_case, as: 'matchCase'
          property :match_entire_cell, as: 'matchEntireCell'
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :replacement, as: 'replacement'
          property :search_by_regex, as: 'searchByRegex'
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class FindReplaceResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :formulas_changed, as: 'formulasChanged'
          property :occurrences_changed, as: 'occurrencesChanged'
          property :rows_changed, as: 'rowsChanged'
          property :sheets_changed, as: 'sheetsChanged'
          property :values_changed, as: 'valuesChanged'
        end
      end
      
      class GradientRule
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :maxpoint, as: 'maxpoint', class: Google::Apis::SheetsV4::InterpolationPoint, decorator: Google::Apis::SheetsV4::InterpolationPoint::Representation
      
          property :midpoint, as: 'midpoint', class: Google::Apis::SheetsV4::InterpolationPoint, decorator: Google::Apis::SheetsV4::InterpolationPoint::Representation
      
          property :minpoint, as: 'minpoint', class: Google::Apis::SheetsV4::InterpolationPoint, decorator: Google::Apis::SheetsV4::InterpolationPoint::Representation
      
        end
      end
      
      class GridCoordinate
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :column_index, as: 'columnIndex'
          property :row_index, as: 'rowIndex'
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class GridData
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :column_metadata, as: 'columnMetadata', class: Google::Apis::SheetsV4::DimensionProperties, decorator: Google::Apis::SheetsV4::DimensionProperties::Representation
      
          collection :row_data, as: 'rowData', class: Google::Apis::SheetsV4::RowData, decorator: Google::Apis::SheetsV4::RowData::Representation
      
          collection :row_metadata, as: 'rowMetadata', class: Google::Apis::SheetsV4::DimensionProperties, decorator: Google::Apis::SheetsV4::DimensionProperties::Representation
      
          property :start_column, as: 'startColumn'
          property :start_row, as: 'startRow'
        end
      end
      
      class GridProperties
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :column_count, as: 'columnCount'
          property :frozen_column_count, as: 'frozenColumnCount'
          property :frozen_row_count, as: 'frozenRowCount'
          property :hide_gridlines, as: 'hideGridlines'
          property :row_count, as: 'rowCount'
        end
      end
      
      class GridRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :end_column_index, as: 'endColumnIndex'
          property :end_row_index, as: 'endRowIndex'
          property :sheet_id, as: 'sheetId'
          property :start_column_index, as: 'startColumnIndex'
          property :start_row_index, as: 'startRowIndex'
        end
      end
      
      class HistogramChartSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bucket_size, as: 'bucketSize'
          property :legend_position, as: 'legendPosition'
          property :outlier_percentile, as: 'outlierPercentile'
          collection :series, as: 'series', class: Google::Apis::SheetsV4::HistogramSeries, decorator: Google::Apis::SheetsV4::HistogramSeries::Representation
      
          property :show_item_dividers, as: 'showItemDividers'
        end
      end
      
      class HistogramSeries
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bar_color, as: 'barColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :data, as: 'data', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
        end
      end
      
      class InsertDimensionRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :inherit_from_before, as: 'inheritFromBefore'
          property :range, as: 'range', class: Google::Apis::SheetsV4::DimensionRange, decorator: Google::Apis::SheetsV4::DimensionRange::Representation
      
        end
      end
      
      class InsertRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :shift_dimension, as: 'shiftDimension'
        end
      end
      
      class InterpolationPoint
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :color, as: 'color', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :type, as: 'type'
          property :value, as: 'value'
        end
      end
      
      class IterativeCalculationSettings
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :convergence_threshold, as: 'convergenceThreshold'
          property :max_iterations, as: 'maxIterations'
        end
      end
      
      class MergeCellsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :merge_type, as: 'mergeType'
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class MoveDimensionRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :destination_index, as: 'destinationIndex'
          property :source, as: 'source', class: Google::Apis::SheetsV4::DimensionRange, decorator: Google::Apis::SheetsV4::DimensionRange::Representation
      
        end
      end
      
      class NamedRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :name, as: 'name'
          property :named_range_id, as: 'namedRangeId'
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class NumberFormat
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :pattern, as: 'pattern'
          property :type, as: 'type'
        end
      end
      
      class OrgChartSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :labels, as: 'labels', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :node_color, as: 'nodeColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :node_size, as: 'nodeSize'
          property :parent_labels, as: 'parentLabels', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :selected_node_color, as: 'selectedNodeColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :tooltips, as: 'tooltips', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
        end
      end
      
      class OverlayPosition
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :anchor_cell, as: 'anchorCell', class: Google::Apis::SheetsV4::GridCoordinate, decorator: Google::Apis::SheetsV4::GridCoordinate::Representation
      
          property :height_pixels, as: 'heightPixels'
          property :offset_x_pixels, as: 'offsetXPixels'
          property :offset_y_pixels, as: 'offsetYPixels'
          property :width_pixels, as: 'widthPixels'
        end
      end
      
      class Padding
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bottom, as: 'bottom'
          property :left, as: 'left'
          property :right, as: 'right'
          property :top, as: 'top'
        end
      end
      
      class PasteDataRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :coordinate, as: 'coordinate', class: Google::Apis::SheetsV4::GridCoordinate, decorator: Google::Apis::SheetsV4::GridCoordinate::Representation
      
          property :data, as: 'data'
          property :delimiter, as: 'delimiter'
          property :html, as: 'html'
          property :type, as: 'type'
        end
      end
      
      class PieChartSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :domain, as: 'domain', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :legend_position, as: 'legendPosition'
          property :pie_hole, as: 'pieHole'
          property :series, as: 'series', class: Google::Apis::SheetsV4::ChartData, decorator: Google::Apis::SheetsV4::ChartData::Representation
      
          property :three_dimensional, as: 'threeDimensional'
        end
      end
      
      class PivotFilterCriteria
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :visible_values, as: 'visibleValues'
        end
      end
      
      class PivotGroup
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :show_totals, as: 'showTotals'
          property :sort_order, as: 'sortOrder'
          property :source_column_offset, as: 'sourceColumnOffset'
          property :value_bucket, as: 'valueBucket', class: Google::Apis::SheetsV4::PivotGroupSortValueBucket, decorator: Google::Apis::SheetsV4::PivotGroupSortValueBucket::Representation
      
          collection :value_metadata, as: 'valueMetadata', class: Google::Apis::SheetsV4::PivotGroupValueMetadata, decorator: Google::Apis::SheetsV4::PivotGroupValueMetadata::Representation
      
        end
      end
      
      class PivotGroupSortValueBucket
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :buckets, as: 'buckets', class: Google::Apis::SheetsV4::ExtendedValue, decorator: Google::Apis::SheetsV4::ExtendedValue::Representation
      
          property :values_index, as: 'valuesIndex'
        end
      end
      
      class PivotGroupValueMetadata
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :collapsed, as: 'collapsed'
          property :value, as: 'value', class: Google::Apis::SheetsV4::ExtendedValue, decorator: Google::Apis::SheetsV4::ExtendedValue::Representation
      
        end
      end
      
      class PivotTable
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :columns, as: 'columns', class: Google::Apis::SheetsV4::PivotGroup, decorator: Google::Apis::SheetsV4::PivotGroup::Representation
      
          hash :criteria, as: 'criteria', class: Google::Apis::SheetsV4::PivotFilterCriteria, decorator: Google::Apis::SheetsV4::PivotFilterCriteria::Representation
      
          collection :rows, as: 'rows', class: Google::Apis::SheetsV4::PivotGroup, decorator: Google::Apis::SheetsV4::PivotGroup::Representation
      
          property :source, as: 'source', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :value_layout, as: 'valueLayout'
          collection :values, as: 'values', class: Google::Apis::SheetsV4::PivotValue, decorator: Google::Apis::SheetsV4::PivotValue::Representation
      
        end
      end
      
      class PivotValue
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :formula, as: 'formula'
          property :name, as: 'name'
          property :source_column_offset, as: 'sourceColumnOffset'
          property :summarize_function, as: 'summarizeFunction'
        end
      end
      
      class ProtectedRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :description, as: 'description'
          property :editors, as: 'editors', class: Google::Apis::SheetsV4::Editors, decorator: Google::Apis::SheetsV4::Editors::Representation
      
          property :named_range_id, as: 'namedRangeId'
          property :protected_range_id, as: 'protectedRangeId'
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :requesting_user_can_edit, as: 'requestingUserCanEdit'
          collection :unprotected_ranges, as: 'unprotectedRanges', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :warning_only, as: 'warningOnly'
        end
      end
      
      class RandomizeRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class RepeatCellRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :cell, as: 'cell', class: Google::Apis::SheetsV4::CellData, decorator: Google::Apis::SheetsV4::CellData::Representation
      
          property :fields, as: 'fields'
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class Request
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :add_banding, as: 'addBanding', class: Google::Apis::SheetsV4::AddBandingRequest, decorator: Google::Apis::SheetsV4::AddBandingRequest::Representation
      
          property :add_chart, as: 'addChart', class: Google::Apis::SheetsV4::AddChartRequest, decorator: Google::Apis::SheetsV4::AddChartRequest::Representation
      
          property :add_conditional_format_rule, as: 'addConditionalFormatRule', class: Google::Apis::SheetsV4::AddConditionalFormatRuleRequest, decorator: Google::Apis::SheetsV4::AddConditionalFormatRuleRequest::Representation
      
          property :add_filter_view, as: 'addFilterView', class: Google::Apis::SheetsV4::AddFilterViewRequest, decorator: Google::Apis::SheetsV4::AddFilterViewRequest::Representation
      
          property :add_named_range, as: 'addNamedRange', class: Google::Apis::SheetsV4::AddNamedRangeRequest, decorator: Google::Apis::SheetsV4::AddNamedRangeRequest::Representation
      
          property :add_protected_range, as: 'addProtectedRange', class: Google::Apis::SheetsV4::AddProtectedRangeRequest, decorator: Google::Apis::SheetsV4::AddProtectedRangeRequest::Representation
      
          property :add_sheet, as: 'addSheet', class: Google::Apis::SheetsV4::AddSheetRequest, decorator: Google::Apis::SheetsV4::AddSheetRequest::Representation
      
          property :append_cells, as: 'appendCells', class: Google::Apis::SheetsV4::AppendCellsRequest, decorator: Google::Apis::SheetsV4::AppendCellsRequest::Representation
      
          property :append_dimension, as: 'appendDimension', class: Google::Apis::SheetsV4::AppendDimensionRequest, decorator: Google::Apis::SheetsV4::AppendDimensionRequest::Representation
      
          property :auto_fill, as: 'autoFill', class: Google::Apis::SheetsV4::AutoFillRequest, decorator: Google::Apis::SheetsV4::AutoFillRequest::Representation
      
          property :auto_resize_dimensions, as: 'autoResizeDimensions', class: Google::Apis::SheetsV4::AutoResizeDimensionsRequest, decorator: Google::Apis::SheetsV4::AutoResizeDimensionsRequest::Representation
      
          property :clear_basic_filter, as: 'clearBasicFilter', class: Google::Apis::SheetsV4::ClearBasicFilterRequest, decorator: Google::Apis::SheetsV4::ClearBasicFilterRequest::Representation
      
          property :copy_paste, as: 'copyPaste', class: Google::Apis::SheetsV4::CopyPasteRequest, decorator: Google::Apis::SheetsV4::CopyPasteRequest::Representation
      
          property :cut_paste, as: 'cutPaste', class: Google::Apis::SheetsV4::CutPasteRequest, decorator: Google::Apis::SheetsV4::CutPasteRequest::Representation
      
          property :delete_banding, as: 'deleteBanding', class: Google::Apis::SheetsV4::DeleteBandingRequest, decorator: Google::Apis::SheetsV4::DeleteBandingRequest::Representation
      
          property :delete_conditional_format_rule, as: 'deleteConditionalFormatRule', class: Google::Apis::SheetsV4::DeleteConditionalFormatRuleRequest, decorator: Google::Apis::SheetsV4::DeleteConditionalFormatRuleRequest::Representation
      
          property :delete_dimension, as: 'deleteDimension', class: Google::Apis::SheetsV4::DeleteDimensionRequest, decorator: Google::Apis::SheetsV4::DeleteDimensionRequest::Representation
      
          property :delete_embedded_object, as: 'deleteEmbeddedObject', class: Google::Apis::SheetsV4::DeleteEmbeddedObjectRequest, decorator: Google::Apis::SheetsV4::DeleteEmbeddedObjectRequest::Representation
      
          property :delete_filter_view, as: 'deleteFilterView', class: Google::Apis::SheetsV4::DeleteFilterViewRequest, decorator: Google::Apis::SheetsV4::DeleteFilterViewRequest::Representation
      
          property :delete_named_range, as: 'deleteNamedRange', class: Google::Apis::SheetsV4::DeleteNamedRangeRequest, decorator: Google::Apis::SheetsV4::DeleteNamedRangeRequest::Representation
      
          property :delete_protected_range, as: 'deleteProtectedRange', class: Google::Apis::SheetsV4::DeleteProtectedRangeRequest, decorator: Google::Apis::SheetsV4::DeleteProtectedRangeRequest::Representation
      
          property :delete_range, as: 'deleteRange', class: Google::Apis::SheetsV4::DeleteRangeRequest, decorator: Google::Apis::SheetsV4::DeleteRangeRequest::Representation
      
          property :delete_sheet, as: 'deleteSheet', class: Google::Apis::SheetsV4::DeleteSheetRequest, decorator: Google::Apis::SheetsV4::DeleteSheetRequest::Representation
      
          property :duplicate_filter_view, as: 'duplicateFilterView', class: Google::Apis::SheetsV4::DuplicateFilterViewRequest, decorator: Google::Apis::SheetsV4::DuplicateFilterViewRequest::Representation
      
          property :duplicate_sheet, as: 'duplicateSheet', class: Google::Apis::SheetsV4::DuplicateSheetRequest, decorator: Google::Apis::SheetsV4::DuplicateSheetRequest::Representation
      
          property :find_replace, as: 'findReplace', class: Google::Apis::SheetsV4::FindReplaceRequest, decorator: Google::Apis::SheetsV4::FindReplaceRequest::Representation
      
          property :insert_dimension, as: 'insertDimension', class: Google::Apis::SheetsV4::InsertDimensionRequest, decorator: Google::Apis::SheetsV4::InsertDimensionRequest::Representation
      
          property :insert_range, as: 'insertRange', class: Google::Apis::SheetsV4::InsertRangeRequest, decorator: Google::Apis::SheetsV4::InsertRangeRequest::Representation
      
          property :merge_cells, as: 'mergeCells', class: Google::Apis::SheetsV4::MergeCellsRequest, decorator: Google::Apis::SheetsV4::MergeCellsRequest::Representation
      
          property :move_dimension, as: 'moveDimension', class: Google::Apis::SheetsV4::MoveDimensionRequest, decorator: Google::Apis::SheetsV4::MoveDimensionRequest::Representation
      
          property :paste_data, as: 'pasteData', class: Google::Apis::SheetsV4::PasteDataRequest, decorator: Google::Apis::SheetsV4::PasteDataRequest::Representation
      
          property :randomize_range, as: 'randomizeRange', class: Google::Apis::SheetsV4::RandomizeRangeRequest, decorator: Google::Apis::SheetsV4::RandomizeRangeRequest::Representation
      
          property :repeat_cell, as: 'repeatCell', class: Google::Apis::SheetsV4::RepeatCellRequest, decorator: Google::Apis::SheetsV4::RepeatCellRequest::Representation
      
          property :set_basic_filter, as: 'setBasicFilter', class: Google::Apis::SheetsV4::SetBasicFilterRequest, decorator: Google::Apis::SheetsV4::SetBasicFilterRequest::Representation
      
          property :set_data_validation, as: 'setDataValidation', class: Google::Apis::SheetsV4::SetDataValidationRequest, decorator: Google::Apis::SheetsV4::SetDataValidationRequest::Representation
      
          property :sort_range, as: 'sortRange', class: Google::Apis::SheetsV4::SortRangeRequest, decorator: Google::Apis::SheetsV4::SortRangeRequest::Representation
      
          property :text_to_columns, as: 'textToColumns', class: Google::Apis::SheetsV4::TextToColumnsRequest, decorator: Google::Apis::SheetsV4::TextToColumnsRequest::Representation
      
          property :unmerge_cells, as: 'unmergeCells', class: Google::Apis::SheetsV4::UnmergeCellsRequest, decorator: Google::Apis::SheetsV4::UnmergeCellsRequest::Representation
      
          property :update_banding, as: 'updateBanding', class: Google::Apis::SheetsV4::UpdateBandingRequest, decorator: Google::Apis::SheetsV4::UpdateBandingRequest::Representation
      
          property :update_borders, as: 'updateBorders', class: Google::Apis::SheetsV4::UpdateBordersRequest, decorator: Google::Apis::SheetsV4::UpdateBordersRequest::Representation
      
          property :update_cells, as: 'updateCells', class: Google::Apis::SheetsV4::UpdateCellsRequest, decorator: Google::Apis::SheetsV4::UpdateCellsRequest::Representation
      
          property :update_chart_spec, as: 'updateChartSpec', class: Google::Apis::SheetsV4::UpdateChartSpecRequest, decorator: Google::Apis::SheetsV4::UpdateChartSpecRequest::Representation
      
          property :update_conditional_format_rule, as: 'updateConditionalFormatRule', class: Google::Apis::SheetsV4::UpdateConditionalFormatRuleRequest, decorator: Google::Apis::SheetsV4::UpdateConditionalFormatRuleRequest::Representation
      
          property :update_dimension_properties, as: 'updateDimensionProperties', class: Google::Apis::SheetsV4::UpdateDimensionPropertiesRequest, decorator: Google::Apis::SheetsV4::UpdateDimensionPropertiesRequest::Representation
      
          property :update_embedded_object_position, as: 'updateEmbeddedObjectPosition', class: Google::Apis::SheetsV4::UpdateEmbeddedObjectPositionRequest, decorator: Google::Apis::SheetsV4::UpdateEmbeddedObjectPositionRequest::Representation
      
          property :update_filter_view, as: 'updateFilterView', class: Google::Apis::SheetsV4::UpdateFilterViewRequest, decorator: Google::Apis::SheetsV4::UpdateFilterViewRequest::Representation
      
          property :update_named_range, as: 'updateNamedRange', class: Google::Apis::SheetsV4::UpdateNamedRangeRequest, decorator: Google::Apis::SheetsV4::UpdateNamedRangeRequest::Representation
      
          property :update_protected_range, as: 'updateProtectedRange', class: Google::Apis::SheetsV4::UpdateProtectedRangeRequest, decorator: Google::Apis::SheetsV4::UpdateProtectedRangeRequest::Representation
      
          property :update_sheet_properties, as: 'updateSheetProperties', class: Google::Apis::SheetsV4::UpdateSheetPropertiesRequest, decorator: Google::Apis::SheetsV4::UpdateSheetPropertiesRequest::Representation
      
          property :update_spreadsheet_properties, as: 'updateSpreadsheetProperties', class: Google::Apis::SheetsV4::UpdateSpreadsheetPropertiesRequest, decorator: Google::Apis::SheetsV4::UpdateSpreadsheetPropertiesRequest::Representation
      
        end
      end
      
      class Response
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :add_banding, as: 'addBanding', class: Google::Apis::SheetsV4::AddBandingResponse, decorator: Google::Apis::SheetsV4::AddBandingResponse::Representation
      
          property :add_chart, as: 'addChart', class: Google::Apis::SheetsV4::AddChartResponse, decorator: Google::Apis::SheetsV4::AddChartResponse::Representation
      
          property :add_filter_view, as: 'addFilterView', class: Google::Apis::SheetsV4::AddFilterViewResponse, decorator: Google::Apis::SheetsV4::AddFilterViewResponse::Representation
      
          property :add_named_range, as: 'addNamedRange', class: Google::Apis::SheetsV4::AddNamedRangeResponse, decorator: Google::Apis::SheetsV4::AddNamedRangeResponse::Representation
      
          property :add_protected_range, as: 'addProtectedRange', class: Google::Apis::SheetsV4::AddProtectedRangeResponse, decorator: Google::Apis::SheetsV4::AddProtectedRangeResponse::Representation
      
          property :add_sheet, as: 'addSheet', class: Google::Apis::SheetsV4::AddSheetResponse, decorator: Google::Apis::SheetsV4::AddSheetResponse::Representation
      
          property :delete_conditional_format_rule, as: 'deleteConditionalFormatRule', class: Google::Apis::SheetsV4::DeleteConditionalFormatRuleResponse, decorator: Google::Apis::SheetsV4::DeleteConditionalFormatRuleResponse::Representation
      
          property :duplicate_filter_view, as: 'duplicateFilterView', class: Google::Apis::SheetsV4::DuplicateFilterViewResponse, decorator: Google::Apis::SheetsV4::DuplicateFilterViewResponse::Representation
      
          property :duplicate_sheet, as: 'duplicateSheet', class: Google::Apis::SheetsV4::DuplicateSheetResponse, decorator: Google::Apis::SheetsV4::DuplicateSheetResponse::Representation
      
          property :find_replace, as: 'findReplace', class: Google::Apis::SheetsV4::FindReplaceResponse, decorator: Google::Apis::SheetsV4::FindReplaceResponse::Representation
      
          property :update_conditional_format_rule, as: 'updateConditionalFormatRule', class: Google::Apis::SheetsV4::UpdateConditionalFormatRuleResponse, decorator: Google::Apis::SheetsV4::UpdateConditionalFormatRuleResponse::Representation
      
          property :update_embedded_object_position, as: 'updateEmbeddedObjectPosition', class: Google::Apis::SheetsV4::UpdateEmbeddedObjectPositionResponse, decorator: Google::Apis::SheetsV4::UpdateEmbeddedObjectPositionResponse::Representation
      
        end
      end
      
      class RowData
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :values, as: 'values', class: Google::Apis::SheetsV4::CellData, decorator: Google::Apis::SheetsV4::CellData::Representation
      
        end
      end
      
      class SetBasicFilterRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :filter, as: 'filter', class: Google::Apis::SheetsV4::BasicFilter, decorator: Google::Apis::SheetsV4::BasicFilter::Representation
      
        end
      end
      
      class SetDataValidationRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :rule, as: 'rule', class: Google::Apis::SheetsV4::DataValidationRule, decorator: Google::Apis::SheetsV4::DataValidationRule::Representation
      
        end
      end
      
      class Sheet
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :banded_ranges, as: 'bandedRanges', class: Google::Apis::SheetsV4::BandedRange, decorator: Google::Apis::SheetsV4::BandedRange::Representation
      
          property :basic_filter, as: 'basicFilter', class: Google::Apis::SheetsV4::BasicFilter, decorator: Google::Apis::SheetsV4::BasicFilter::Representation
      
          collection :charts, as: 'charts', class: Google::Apis::SheetsV4::EmbeddedChart, decorator: Google::Apis::SheetsV4::EmbeddedChart::Representation
      
          collection :conditional_formats, as: 'conditionalFormats', class: Google::Apis::SheetsV4::ConditionalFormatRule, decorator: Google::Apis::SheetsV4::ConditionalFormatRule::Representation
      
          collection :data, as: 'data', class: Google::Apis::SheetsV4::GridData, decorator: Google::Apis::SheetsV4::GridData::Representation
      
          collection :filter_views, as: 'filterViews', class: Google::Apis::SheetsV4::FilterView, decorator: Google::Apis::SheetsV4::FilterView::Representation
      
          collection :merges, as: 'merges', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :properties, as: 'properties', class: Google::Apis::SheetsV4::SheetProperties, decorator: Google::Apis::SheetsV4::SheetProperties::Representation
      
          collection :protected_ranges, as: 'protectedRanges', class: Google::Apis::SheetsV4::ProtectedRange, decorator: Google::Apis::SheetsV4::ProtectedRange::Representation
      
        end
      end
      
      class SheetProperties
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :grid_properties, as: 'gridProperties', class: Google::Apis::SheetsV4::GridProperties, decorator: Google::Apis::SheetsV4::GridProperties::Representation
      
          property :hidden, as: 'hidden'
          property :index, as: 'index'
          property :right_to_left, as: 'rightToLeft'
          property :sheet_id, as: 'sheetId'
          property :sheet_type, as: 'sheetType'
          property :tab_color, as: 'tabColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :title, as: 'title'
        end
      end
      
      class SortRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          collection :sort_specs, as: 'sortSpecs', class: Google::Apis::SheetsV4::SortSpec, decorator: Google::Apis::SheetsV4::SortSpec::Representation
      
        end
      end
      
      class SortSpec
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :dimension_index, as: 'dimensionIndex'
          property :sort_order, as: 'sortOrder'
        end
      end
      
      class SourceAndDestination
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :dimension, as: 'dimension'
          property :fill_length, as: 'fillLength'
          property :source, as: 'source', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class Spreadsheet
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          collection :named_ranges, as: 'namedRanges', class: Google::Apis::SheetsV4::NamedRange, decorator: Google::Apis::SheetsV4::NamedRange::Representation
      
          property :properties, as: 'properties', class: Google::Apis::SheetsV4::SpreadsheetProperties, decorator: Google::Apis::SheetsV4::SpreadsheetProperties::Representation
      
          collection :sheets, as: 'sheets', class: Google::Apis::SheetsV4::Sheet, decorator: Google::Apis::SheetsV4::Sheet::Representation
      
          property :spreadsheet_id, as: 'spreadsheetId'
          property :spreadsheet_url, as: 'spreadsheetUrl'
        end
      end
      
      class SpreadsheetProperties
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :auto_recalc, as: 'autoRecalc'
          property :default_format, as: 'defaultFormat', class: Google::Apis::SheetsV4::CellFormat, decorator: Google::Apis::SheetsV4::CellFormat::Representation
      
          property :iterative_calculation_settings, as: 'iterativeCalculationSettings', class: Google::Apis::SheetsV4::IterativeCalculationSettings, decorator: Google::Apis::SheetsV4::IterativeCalculationSettings::Representation
      
          property :locale, as: 'locale'
          property :time_zone, as: 'timeZone'
          property :title, as: 'title'
        end
      end
      
      class TextFormat
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bold, as: 'bold'
          property :font_family, as: 'fontFamily'
          property :font_size, as: 'fontSize'
          property :foreground_color, as: 'foregroundColor', class: Google::Apis::SheetsV4::Color, decorator: Google::Apis::SheetsV4::Color::Representation
      
          property :italic, as: 'italic'
          property :strikethrough, as: 'strikethrough'
          property :underline, as: 'underline'
        end
      end
      
      class TextFormatRun
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :format, as: 'format', class: Google::Apis::SheetsV4::TextFormat, decorator: Google::Apis::SheetsV4::TextFormat::Representation
      
          property :start_index, as: 'startIndex'
        end
      end
      
      class TextRotation
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :angle, as: 'angle'
          property :vertical, as: 'vertical'
        end
      end
      
      class TextToColumnsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :delimiter, as: 'delimiter'
          property :delimiter_type, as: 'delimiterType'
          property :source, as: 'source', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class UnmergeCellsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
        end
      end
      
      class UpdateBandingRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :banded_range, as: 'bandedRange', class: Google::Apis::SheetsV4::BandedRange, decorator: Google::Apis::SheetsV4::BandedRange::Representation
      
          property :fields, as: 'fields'
        end
      end
      
      class UpdateBordersRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :bottom, as: 'bottom', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
          property :inner_horizontal, as: 'innerHorizontal', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
          property :inner_vertical, as: 'innerVertical', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
          property :left, as: 'left', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          property :right, as: 'right', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
          property :top, as: 'top', class: Google::Apis::SheetsV4::Border, decorator: Google::Apis::SheetsV4::Border::Representation
      
        end
      end
      
      class UpdateCellsRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          property :range, as: 'range', class: Google::Apis::SheetsV4::GridRange, decorator: Google::Apis::SheetsV4::GridRange::Representation
      
          collection :rows, as: 'rows', class: Google::Apis::SheetsV4::RowData, decorator: Google::Apis::SheetsV4::RowData::Representation
      
          property :start, as: 'start', class: Google::Apis::SheetsV4::GridCoordinate, decorator: Google::Apis::SheetsV4::GridCoordinate::Representation
      
        end
      end
      
      class UpdateChartSpecRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :chart_id, as: 'chartId'
          property :spec, as: 'spec', class: Google::Apis::SheetsV4::ChartSpec, decorator: Google::Apis::SheetsV4::ChartSpec::Representation
      
        end
      end
      
      class UpdateConditionalFormatRuleRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :index, as: 'index'
          property :new_index, as: 'newIndex'
          property :rule, as: 'rule', class: Google::Apis::SheetsV4::ConditionalFormatRule, decorator: Google::Apis::SheetsV4::ConditionalFormatRule::Representation
      
          property :sheet_id, as: 'sheetId'
        end
      end
      
      class UpdateConditionalFormatRuleResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :new_index, as: 'newIndex'
          property :new_rule, as: 'newRule', class: Google::Apis::SheetsV4::ConditionalFormatRule, decorator: Google::Apis::SheetsV4::ConditionalFormatRule::Representation
      
          property :old_index, as: 'oldIndex'
          property :old_rule, as: 'oldRule', class: Google::Apis::SheetsV4::ConditionalFormatRule, decorator: Google::Apis::SheetsV4::ConditionalFormatRule::Representation
      
        end
      end
      
      class UpdateDimensionPropertiesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          property :properties, as: 'properties', class: Google::Apis::SheetsV4::DimensionProperties, decorator: Google::Apis::SheetsV4::DimensionProperties::Representation
      
          property :range, as: 'range', class: Google::Apis::SheetsV4::DimensionRange, decorator: Google::Apis::SheetsV4::DimensionRange::Representation
      
        end
      end
      
      class UpdateEmbeddedObjectPositionRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          property :new_position, as: 'newPosition', class: Google::Apis::SheetsV4::EmbeddedObjectPosition, decorator: Google::Apis::SheetsV4::EmbeddedObjectPosition::Representation
      
          property :object_id_prop, as: 'objectId'
        end
      end
      
      class UpdateEmbeddedObjectPositionResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :position, as: 'position', class: Google::Apis::SheetsV4::EmbeddedObjectPosition, decorator: Google::Apis::SheetsV4::EmbeddedObjectPosition::Representation
      
        end
      end
      
      class UpdateFilterViewRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          property :filter, as: 'filter', class: Google::Apis::SheetsV4::FilterView, decorator: Google::Apis::SheetsV4::FilterView::Representation
      
        end
      end
      
      class UpdateNamedRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          property :named_range, as: 'namedRange', class: Google::Apis::SheetsV4::NamedRange, decorator: Google::Apis::SheetsV4::NamedRange::Representation
      
        end
      end
      
      class UpdateProtectedRangeRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          property :protected_range, as: 'protectedRange', class: Google::Apis::SheetsV4::ProtectedRange, decorator: Google::Apis::SheetsV4::ProtectedRange::Representation
      
        end
      end
      
      class UpdateSheetPropertiesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          property :properties, as: 'properties', class: Google::Apis::SheetsV4::SheetProperties, decorator: Google::Apis::SheetsV4::SheetProperties::Representation
      
        end
      end
      
      class UpdateSpreadsheetPropertiesRequest
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :fields, as: 'fields'
          property :properties, as: 'properties', class: Google::Apis::SheetsV4::SpreadsheetProperties, decorator: Google::Apis::SheetsV4::SpreadsheetProperties::Representation
      
        end
      end
      
      class UpdateValuesResponse
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :spreadsheet_id, as: 'spreadsheetId'
          property :updated_cells, as: 'updatedCells'
          property :updated_columns, as: 'updatedColumns'
          property :updated_data, as: 'updatedData', class: Google::Apis::SheetsV4::ValueRange, decorator: Google::Apis::SheetsV4::ValueRange::Representation
      
          property :updated_range, as: 'updatedRange'
          property :updated_rows, as: 'updatedRows'
        end
      end
      
      class ValueRange
        # @private
        class Representation < Google::Apis::Core::JsonRepresentation
          property :major_dimension, as: 'majorDimension'
          property :range, as: 'range'
          collection :values, as: 'values', :class => Array do
        include Representable::JSON::Collection
        items
      end
      
        end
      end
    end
  end
end
