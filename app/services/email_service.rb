class EmailService
  attr_reader :client, :user, :contents, :link

  def initialize(user:, contents:, 
                 client: Aws::SES::Client.new(region: Rails.application.credentials.dig(:aws, :region), 
                                              credentials: Aws::Credentials.new(Rails.application.credentials.dig(:aws, :secret_access_key),
                                                                                Rails.application.credentials.dig(:aws, :access_key_id))), link: nil)
    @client = client
    @user = user
    @contents = contents
    @link = link
  end

  def send!
    client.send_email(template)
  rescue Aws::SES::Errors::ServiceError => e
    puts "Email not sent. Error message: #{e}"
  end

  private

  def template
    {
      destination: {
        to_addresses: [user.email]
      },
      message: {
        body: {
          html: {
            charset: encoding,
            data: html_body
          }
        },
        subject: {
          charset: encoding,
          data: subject
        }
      },
      source: sender
    }
  end

  def subject
    contents[:subject]
  end

  def html_body
    body = contents[:html_body]
    personalized = personalize(body)
    add_link(personalized)
  end

  def encoding
    contents[:encoding]
  end

  def personalize(contents)
    return contents unless contents['<first_name>']

    contents.gsub!('<first_name>', user.profile.first_name)
  end

  def add_link(contents)
    return contents unless contents['href'] && link

    contents.gsub!('href', 'href=#{link}')
  end

  def sender
    Rails.application.credentials.dig(:email, :sender)
  end
end
