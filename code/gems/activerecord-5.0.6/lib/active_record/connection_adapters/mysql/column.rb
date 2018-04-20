module ActiveRecord
  module ConnectionAdapters
    module MySQL
      class Column < ConnectionAdapters::Column # :nodoc:
        delegate :strict, :extra, to: :sql_type_metadata, allow_nil: true

        def initialize(*)
          super
          assert_valid_default
          extract_default
        end

        def has_default?
          return false if blob_or_text_column? # MySQL forbids defaults on blob and text columns
          super
        end

        def blob_or_text_column?
          /\A(?:tiny|medium|long)?blob\b/ === sql_type || type == :text
        end

        def unsigned?
          /\A(?:enum|set)\b/ !~ sql_type && /\bunsigned\b/ === sql_type
        end

        def case_sensitive?
          collation && collation !~ /_ci\z/
        end

        def auto_increment?
          extra == 'auto_increment'
        end

        private

        def extract_default
          if blob_or_text_column?
            @default = null || strict ? nil : ''
          end
        end

        def assert_valid_default
          if blob_or_text_column? && default.present?
            raise ArgumentError, "#{type} columns cannot have a default value: #{default.inspect}"
          end
        end
      end
    end
  end
end
