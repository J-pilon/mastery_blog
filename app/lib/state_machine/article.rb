module StateMachine
  class Article
    attr_reader :article, :state

    def initialize(article)
      @article = article
      @state = article.state.to_sym
    end

    def drafting!
      raise "Invalid state #{state}" if state != :created

      article.update(state: :drafted)
    end

    def publishing!
      raise "Invalid state #{state}" if state != :drafted

      article.update(state: :published)
    end
  end
end
