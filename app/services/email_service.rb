class EmailService

  attr_reader :client, :users, :type, :link

  def initialize(client:, users:, type:, link: nil)
    @client = client
    @users = Array(users)
    @type = type
    @link = link
  end

  def send_email!
    begin
      response = client.send_email(template)
      response.to_h
    rescue Aws::SES::Errors::ServiceError => error
      puts "Email not sent. Error message: #{error}"
    end
  end

  private

  def recipients
    users.map { |u| u.email }
  end

  def subject
    email_contents[:subject]
  end

  def html_body
    return html_body_with_link if link
    email_contents[:html_body]
  end

  # def personalized_body(first_name)
  #   personalized_body = email_contents[:html_body].dup
  #   personalized_body['<first_name>'] = first_name
  # end

  def encoding
    email_contents[:encoding]
  end

  def email_contents
    # what if there is a typeo in type?
    # how should you handle that?
    # the email type should be an enum
    @email_contents ||= I18n.t(type.to_sym)
  end

  def template
    {
      destination: {
        to_addresses: recipients,
      },
      message: {
        body: {
          html: {
            charset: encoding,
            data: html_body,
          }
          # text: {
          #   charset: encoding,
          #   data: "This is a test",
          # },
        },
        subject: {
          charset: encoding,
          data: subject,
        },
      },
      source: sender
      # configuration_set_name: configsetname
    }
  end

  def html_body_with_link
    email_contents_dup = email_contents[:html_body].dup
    email_contents_dup['href'] = "href=#{link}"
  end

  def sender
    ENV["EMAIL_SENDER"]
  end
end