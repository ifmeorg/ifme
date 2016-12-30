module Comments
  class BaseService
    attr_reader :comment, :current_user

    def initialize(comment: nil, user: nil)
      @comment = comment
      @current_user = user
    end

    def create
    end

    def delete
    end

    protected

    def klass
      raise 'Not Implemented yet'
    end
  end
end
