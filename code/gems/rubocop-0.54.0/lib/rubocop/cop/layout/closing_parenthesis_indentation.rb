# frozen_string_literal: true

module RuboCop
  module Cop
    module Layout
      # This cops checks the indentation of hanging closing parentheses in
      # method calls, method definitions, and grouped expressions. A hanging
      # closing parenthesis means `)` preceded by a line break.
      #
      # @example
      #
      #   # good: when x is on its own line, indent this way
      #   func(
      #     x,
      #     y
      #   )
      #
      #   # good: when x follows opening parenthesis, align parentheses
      #   a = b * (x +
      #            y
      #           )
      #
      #   # bad
      #   def func(
      #     x,
      #     y
      #     )
      #   end
      class ClosingParenthesisIndentation < Cop
        include Alignment

        MSG_INDENT =
          'Indent `)` the same as the start of the line where `(` is.'.freeze
        MSG_ALIGN = 'Align `)` with `(`.'.freeze

        def on_send(node)
          check(node, node.arguments)
        end

        def on_begin(node)
          check(node, node.children)
        end

        def on_def(node)
          check(node.arguments, node.arguments)
        end
        alias on_defs on_def

        def autocorrect(node)
          AlignmentCorrector.correct(processed_source, node, @column_delta)
        end

        private

        def check(node, elements)
          right_paren = node.loc.end

          return unless right_paren && begins_its_line?(right_paren)

          correct_column = expected_column(node, elements)
          @column_delta = correct_column - right_paren.column

          return if @column_delta.zero?

          left_paren = node.loc.begin
          msg = correct_column == left_paren.column ? MSG_ALIGN : MSG_INDENT

          add_offense(right_paren, location: right_paren, message: msg)
        end

        def expected_column(node, elements)
          left_paren = node.loc.begin

          if node.send_type? && fixed_parameter_indentation? ||
             line_break_after_left_paren?(left_paren, elements)
            left_paren.source_line =~ /\S/
          else
            left_paren.column
          end
        end

        def fixed_parameter_indentation?
          config.for_cop('Layout/AlignParameters')['EnforcedStyle'] ==
            'with_fixed_indentation'
        end

        def line_break_after_left_paren?(left_paren, elements)
          elements.first && elements.first.loc.line > left_paren.line
        end
      end
    end
  end
end
