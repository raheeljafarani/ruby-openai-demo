# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("openai_key"))

message_list = [
  {
    "role" => "system",
    "content" => "You are a Chicago local who knows every street like they have lived there"
  }
]

user_message = "" #User message start

while user_message != "bye" #Loop until bye is said

pp "Hello! How can I help you today?"
pp "-"*50

user_message = gets.chomp #User question

  if user_message != "bye" #Adds user message to a running list
  message_list.push({ "role" => "user", "content" => user_message })

  # Call the API to get the next message from GPT
  api_response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: message_list
  }
)

 # Dig through the JSON response to get the content
 choices = api_response.fetch("choices")
 first_choice = choices.at(0)
 message = first_choice.fetch("message")
 assistant_response = message["content"]

# Print the assistant's response
puts assistant_response
puts "-" * 50

# Add the assistant's response to the message list
message_list.push({ "role" => "assistant", "content" => assistant_response })

end
end

pp "See you later!"
