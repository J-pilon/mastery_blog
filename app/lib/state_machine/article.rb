module StateMachine
  class Article
    attr_reader :state

    def initialize(state)
      @state = state
    end

    def transition
      case state
      # event
      when :creating, :saving
        :draft
      when :cancelling
        :destroy
      when :publishing
        :public
      when :failing
        
      else
        :draft
      end
    end
  end
end
