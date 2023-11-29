module StateMachine
  class Article

    attr_reader :article, :state

    def initialize(article)
      @article = article
      @state = article.state
    end

    def drafting!
      raise "Invalid state #{state}" if state != :created

      article.state = :drafted
    end

    def publishing!
      raise "Invalid state #{state}" if state != :draft

      article.state = :published
    end
  end
end