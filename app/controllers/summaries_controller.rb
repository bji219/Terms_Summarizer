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

