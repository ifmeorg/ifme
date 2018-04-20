# frozen_string_literal: true

module RuboCop
  module Cop
    module Performance
      # This cop identifies places where a case-insensitive string comparison
      # can better be implemented using `casecmp`.
      #
      # @example
      #   # bad
      #   str.downcase == 'abc'
      #   str.upcase.eql? 'ABC'
      #   'abc' == str.downcase
      #   'ABC'.eql? str.upcase
      #   str.downcase == str.downcase
      #
      #   # good
      #   str.casecmp('ABC').zero?
      #   'abc'.casecmp(str).zero?
      class Casecmp < Cop
        MSG = 'Use `casecmp` instead of `%<methods>s`.'.freeze
        CASE_METHODS = %i[downcase upcase].freeze

        def_node_matcher :downcase_eq, <<-PATTERN
          (send
            $(send _ ${:downcase :upcase})
            ${:== :eql? :!=}
            ${str (send _ {:downcase :upcase} ...) (begin str)})
        PATTERN

        def_node_matcher :eq_downcase, <<-PATTERN
          (send
            {str (send _ {:downcase :upcase} ...) (begin str)}
            ${:== :eql? :!=}
            $(send _ ${:downcase :upcase}))
        PATTERN

        def_node_matcher :downcase_downcase, <<-PATTERN
          (send
            $(send _ ${:downcase :upcase})
            ${:== :eql? :!=}
            $(send _ ${:downcase :upcase}))
        PATTERN

        def on_send(node)
          return if part_of_ignored_node?(node)

          inefficient_comparison(node) do |range, is_other_part, *methods|
            ignore_node(node) if is_other_part
            add_offense(node, location: range,
                              message: format(MSG, methods: methods.join(' ')))
          end
        end

        def autocorrect(node)
          if downcase_downcase(node)
            receiver, method, rhs = *node
            arg, = *rhs
          elsif downcase_eq(node)
            receiver, method, arg = *node
          elsif eq_downcase(node)
            arg, method, receiver = *node
          else
            return
          end

          variable, = *receiver
          correction(node, receiver, method, arg, variable)
        end

        private

        def inefficient_comparison(node)
          loc = node.loc

          downcase_eq(node) do |send_downcase, case_method, eq_method, other|
            *_, method = *other
            range, is_other_part = downcase_eq_range(method, loc, send_downcase)

            yield range, is_other_part, case_method, eq_method
            return
          end

          eq_downcase(node) do |eq_method, send_downcase, case_method|
            range = loc.selector.join(send_downcase.loc.selector)
            yield range, false, eq_method, case_method
          end
        end

        def downcase_eq_range(method, loc, send_downcase)
          if CASE_METHODS.include?(method)
            [loc.expression, true]
          else
            [loc.selector.join(send_downcase.loc.selector), false]
          end
        end

        def correction(node, _receiver, method, arg, variable)
          lambda do |corrector|
            corrector.insert_before(node.loc.expression, '!') if method == :!=

            # we want resulting call to be parenthesized
            # if arg already includes one or more sets of parens, don't add more
            # or if method call already used parens, again, don't add more
            replacement = if arg.send_type? || !parentheses?(arg)
                            "#{variable.source}.casecmp(#{arg.source}).zero?"
                          else
                            "#{variable.source}.casecmp#{arg.source}.zero?"
                          end

            corrector.replace(node.loc.expression, replacement)
          end
        end
      end
    end
  end
end
