# encoding: UTF-8

module PryRails
  class ModelFormatter
    def format_active_record(model)
      out = []
      out.push format_model_name model

      if model.table_exists?
        model.columns.each do |column|
          out.push format_column column.name, column.type
        end
      else
        out.push format_error "Table doesn't exist"
      end

      reflections = model.reflections.sort_by do |other_model, reflection|
        [reflection.macro.to_s, other_model.to_s]
      end

      reflections.each do |other_model, reflection|
        options = []

        if reflection.options[:through].present?
          options << "through #{text.blue ":#{reflection.options[:through]}"}"
        end

        if reflection.options[:class_name].present?
          options << "class_name #{text.green ":#{reflection.options[:class_name]}"}"
        end

        if reflection.options[:foreign_key].present?
          options << "foreign_key #{text.red ":#{reflection.options[:foreign_key]}"}"
        end

        out.push format_association reflection.macro, other_model, options
      end

      out.join("\n")
    end

    def format_mongoid(model)
      out = []
      out.push format_model_name model

      model.fields.values.sort_by(&:name).each do |column|
        out.push format_column column.name, column.options[:type]
      end

      model.relations.each do |other_model, ref|
        options = []
        options << 'autosave'  if ref.options[:autosave]
        options << 'autobuild' if ref.options[:autobuild]
        options << 'validate'  if ref.options[:validate]

        if ref.options[:dependent]
          options << "dependent-#{ref.options[:dependent]}"
        end

        out.push format_association \
          kind_of_relation(ref.relation), other_model, options
      end

      out.join("\n")
    end

    def format_model_name(model)
      text.bright_blue model
    end

    def format_column(name, type)
      "  #{name}: #{text.green type}"
    end

    def format_association(type, other, options = [])
      options_string = (options.any?) ? " (#{options.join(', ')})" : ''
      "  #{type} #{text.blue ":#{other}"}#{options_string}"
    end

    def format_error(message)
      "  #{text.red message}"
    end

    def kind_of_relation(relation)
      case relation.to_s.sub(/^Mongoid::Relations::/, '')
        when 'Referenced::Many' then 'has_many'
        when 'Referenced::One'  then 'has_one'
        when 'Referenced::In'   then 'belongs_to'
        when 'Embedded::Many'   then 'embeds_many'
        when 'Embedded::One'    then 'embeds_one'
        when 'Embedded::In'     then 'embedded_in'
      end
    end

    private

    def text
      Pry::Helpers::Text
    end
  end
end
