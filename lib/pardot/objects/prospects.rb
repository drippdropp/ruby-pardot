module Pardot
  module Objects
    module Prospects

      def prospects
        @prospects ||= Prospects.new(self)
      end

      class Prospects

        def initialize(client)
          @client = client
        end

        def query(params={})
          result = get('/do/query', params, 'result')
          result['total_results'] = result['total_results'].to_i if result['total_results']
          result
        end

        def create(email, params={})
          post("/do/create/email/#{email}", params)
        end

        # assign_by_email(email, params={}), assign_by_id(id, params={})
        # read_by_email(email, params={}), read_by_id(id, params={})
        # update_by_email(email, params={}), update_by_id(id, params={})
        # upsert_by_email(email, params={}), upsert_by_id(id, params={})
        # delete_by_email(email, params={}), delete_by_id(id, params={})
        [:assign, :read, :update, :upsert, :delete].each do |verb|
          [:email, :id].each do |field|
            define_method("#{verb}_by_#{field}") do |value, params={}|
              post("/do/#{verb}/#{field}/#{value}", params)
            end
          end
        end

        protected

        def get(path, params={}, result='prospect')
          response = @client.get('prospect', path, params)
          result ? response[result] : response
        end

        def post(path, params={}, result='prospect')
          response = @client.post('prospect', path, params)
          result ? response[result] : response
        end

      end

    end
  end
end
