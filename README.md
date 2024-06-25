# Terms and Conditions Summarizer
Nobody reads them anyway... Let ChatGPT summarize it for you! Customize the prompt and fine-tune the temperature to change the flavor of the results. 
Figure out how and to what degree the service you are signing up for is using your data!
Get a better understanding of the price increases built into the contract you are signing!

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
Visit the [Chrome Extensions site](chrome://extensions/) and turn on "Developer Mode". Choose "Load Unpacked" and upload the project folder containing the custom Chrome extension. 
![]()

### Running the Chrome Extension
From your command line interface, simple run
```ruby
rails server
```
and everything should be ready to roll!

### Safety
In the summarize controller, be sure to remove this line 
```ruby 
skip_before_action :verify_authenticity_token, only: [:create] # dangerous for production
```
if you plan to open up your computer to the winder internet. 
