class EmailService

  attr_reader :client, :user, :contents, :link

  def initialize(user:, contents:, link: nil, client: nil)
    @client = client || Aws::SES::Client.new
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
      destination: { to_addresses: [ user.email ] },

      message: {
        body: {
          html: { charset: encoding, data: html_body, },
          text: { charset: encoding, data: html_body, },
        },
        subject: { charset: encoding, data: subject_param, },
      },
      source: sender,
    }
  end

  def subject_param
    contents[:subject]
  end

  def html_body
    personalized = personalize
    add_link(personalized)
  end

  def encoding
    contents[:encoding]
  end

  def personalize
    html_string =  contents[:html_body]

    return html_string unless html_string['<first_name>']
    html_string.gsub!('<first_name>', user.profile.first_name)
  end

  def add_link(personalized)


    return personalized unless personalized['href'] && link

    personalized.gsub!('href', 'href=#{link}')
  end

  def sender
    ENV['EMAIL_SENDER'] || user.email
  end
end