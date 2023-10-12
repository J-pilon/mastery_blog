module StateMachine
  class Article
    attr_reader :state

    def initialize(state)
      @state = state
    end

    def transition
      case state
      when :draft
        :published
      when :published
        :draft
      else
        :draft
      end
    end
  end
end