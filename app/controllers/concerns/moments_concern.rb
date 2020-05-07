# frozen_string_literal: true
module MomentsConcern
  extend ActiveSupport::Concern

  included do
    helper_method :publishing?, :saving_as_draft?,
                  :empty_array_for
  end

  def publishing?
    params[:publishing] == '1'
  end

  def saving_as_draft?
    !publishing?
  end

  def empty_array_for(*symbols)
    symbols.each do |symbol|
      if moment_params[symbol].nil? && @moment.has_attribute?(symbol)
        @moment[symbol] = []
      end
    end
  end
end
