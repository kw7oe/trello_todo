module TrelloTodo
  class TrelloAPI
    module Endpoint
      @@auth_url = ""

      def self.base_url
        'https://api.trello.com'
      end

      def self.auth_url(api_key: nil, auth_token: nil) 
        if @@auth_url.empty? && api_key && auth_token
          @@auth_url = "key=#{api_key}&token=#{auth_token}"
        else
          @@auth_url
        end
      end
    end
  end
end
