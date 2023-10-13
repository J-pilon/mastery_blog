class EmailService

  attr_reader :client, :user, :contents, :link

  def initialize(client: Aws::SES::Client.new, user:, contents:, link: nil)
    @client = client
    @user = user
    @contents = contents
    @link = link
  end

  def send!
    begin
      resp = client.send_email(template)
      resp
    rescue Aws::SES::Errors::ServiceError => error
      puts "Email not sent. Error message: #{error}"
    end
  end

  private

  def template
    {
      destination: {
        to_addresses: [user.email],
      },
      message: {
        body: {
          html: {
            charset: encoding,
            data: html_body,
          }
        },
        subject: {
          charset: encoding,
          data: subject,
        },
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
    ENV['EMAIL_SENDER']
  end
end