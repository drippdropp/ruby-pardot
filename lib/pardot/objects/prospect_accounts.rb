module Pardot
  module Objects
    module ProspectAccounts
      def prospect_accounts
        @prospect_accounts ||= ProspectAccounts.new self
      end

      class ProspectAccounts

        def initialize(client)
          @client = client
        end

        def query(params={})
          result = get('/do/query', params, 'result')
          result['total_results'] = result['total_results'].to_i if result['total_results']
          result
        end

        def assign(prospect_account_id, pardot_user_id, params={})
          post("/do/assign/id/#{prospect_account_id}", { user_id: pardot_user_id }.merge(params) )
        end

        # describe(params={})
        # create(params={})
        [:describe, :create].each do |verb|
          define_method(verb) do |params={}|
            post("/do/#{verb}", params)
          end
        end

        # read(id, params={})
        # update(id, params={})
        # delete(id, params={})
        [:read, :update, :delete].each do |verb|
          define_method(verb) do |id, params={}|
            post("/do/#{verb}/id/#{id}", params)
          end
        end

        private

        def get(path, params={}, result='prospectAccount')
          response = @client.get('prospectAccount', path, params)
          result ? response[result] : response
        end

        def post(path, params={}, result='prospectAccount')
          response = @client.post('prospectAccount', path, params)
          result ? response[result] : response
        end
      end
    end
  end
end
