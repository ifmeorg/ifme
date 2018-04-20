module ActiveRecord
  module ConnectionAdapters
    module MySQL
      module DatabaseStatements
        # Returns an ActiveRecord::Result instance.
        def select_all(arel, name = nil, binds = [], preparable: nil)
          result = if ExplainRegistry.collect? && prepared_statements
            unprepared_statement { super }
          else
            super
          end
          @connection.next_result while @connection.more_results?
          result
        end

        # Returns an array of arrays containing the field values.
        # Order is the same as that returned by +columns+.
        def select_rows(sql, name = nil, binds = [])
          select_result(sql, name, binds) do |result|
            @connection.next_result while @connection.more_results?
            result.to_a
          end
        end

        # Executes the SQL statement in the context of this connection.
        def execute(sql, name = nil)
          # make sure we carry over any changes to ActiveRecord::Base.default_timezone that have been
          # made since we established the connection
          @connection.query_options[:database_timezone] = ActiveRecord::Base.default_timezone

          super
        end

        def exec_query(sql, name = 'SQL', binds = [], prepare: false)
          if without_prepared_statement?(binds)
            execute_and_free(sql, name) do |result|
              ActiveRecord::Result.new(result.fields, result.to_a) if result
            end
          else
            exec_stmt_and_free(sql, name, binds, cache_stmt: prepare) do |_, result|
              ActiveRecord::Result.new(result.fields, result.to_a) if result
            end
          end
        end

        def exec_delete(sql, name, binds)
          if without_prepared_statement?(binds)
            execute_and_free(sql, name) { @connection.affected_rows }
          else
            exec_stmt_and_free(sql, name, binds) { |stmt| stmt.affected_rows }
          end
        end
        alias :exec_update :exec_delete

        protected

        def last_inserted_id(result)
          @connection.last_id
        end

        private

        def select_result(sql, name = nil, binds = [])
          if without_prepared_statement?(binds)
            execute_and_free(sql, name) { |result| yield result }
          else
            exec_stmt_and_free(sql, name, binds, cache_stmt: true) { |_, result| yield result }
          end
        end

        def exec_stmt_and_free(sql, name, binds, cache_stmt: false)
          # make sure we carry over any changes to ActiveRecord::Base.default_timezone that have been
          # made since we established the connection
          @connection.query_options[:database_timezone] = ActiveRecord::Base.default_timezone

          type_casted_binds = type_casted_binds(binds)

          log(sql, name, binds, type_casted_binds) do
            if cache_stmt
              cache = @statements[sql] ||= {
                stmt: @connection.prepare(sql)
              }
              stmt = cache[:stmt]
            else
              stmt = @connection.prepare(sql)
            end

            begin
              result = stmt.execute(*type_casted_binds)
            rescue Mysql2::Error => e
              if cache_stmt
                @statements.delete(sql)
              else
                stmt.close
              end
              raise e
            end

            ret = yield stmt, result
            result.free if result
            stmt.close unless cache_stmt
            ret
          end
        end
      end
    end
  end
end
