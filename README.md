# Terms and Conditions Summarizer
Nobody reads them anyway... Let ChatGPT summarize it for you! Customize the prompt and fine-tune the temperature to change the flavor of the results. 
Figure out how and to what degree the service you are signing up for is using your data!
Get a better understanding of the price increases built into the contract you are signing up for!

This project requires ruby and ruby on rails, make sure they're installed correctly on your machine before attempting! Also note: the folder "terms_summarizer_extension" should live in a different folder than the main project folder for your ruby on rails app. Just separate them when you download.

Anyways, enjoy.

### The Ruby Controller
```ruby
class SummariesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create] # dangerous for production

  def new
  end

  def create
    terms = params[:terms]
    summary = generate_summary(terms)
    render plain: summary
  end

  private

  def generate_summary(terms)
    client = OpenAI::Client.new
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", prompt: "You are a legal expert specializing in Terms & Conditions and contract law.", content: "Succintly summarize these terms and conditions 
and highlight important points, specifically personal data use or sneaky tactics: 
#{terms}"}], # Required.
        temperature: 0.7,
    })
    puts response.dig("choices", 0, "message", "content")
    return response.dig("choices", 0, "message", "content")
    # response['choices'][0]['text'].strip
  end
end
```

### The Chrome Extension
Visit the [Chrome Extensions site](chrome://extensions/) and turn on "Developer Mode". Choose "Load Unpacked" and upload the project folder containing the custom Chrome extension. Pin the extension to your most-used (notice the "T" icon lol).

Yes, the html is crap, so customize it to look as cool as you want!
![](/terms.png)

### Running the Chrome Extension
From your command line interface, simply run
```ruby
rails server
```
and everything should be ready to roll! The extension will send requests to the ruby app, and the ruby app will send responses back to the chrome extension.

### Safety
In the summarize controller, be sure to remove this line 
```ruby 
skip_before_action :verify_authenticity_token, only: [:create] # dangerous for production
```
if you plan to open up your computer to the winder internet. 
