# frozen_string_literal: true

module Accomplished
  class AzureDevOps
    def initialize(password)
      @password = password
    end

    def list_developed_work_item_ids(org, project, query_item_id)
      url = "https://dev.azure.com/#{org}/#{project}/_apis/wit/wiql/#{query_item_id}?api-version=7.0"
      headers = {
        'Authorization' => "Basic #{credentials}"
      }

      response = RestClient.get url, headers

      JSON.parse(response.body)['workItems']
        .map { |item| item['id'] }
        .map(&:to_i)
    rescue StandardError => e
      puts 'Error!'
      puts e

      exit 1
    end

    def list_developed_work_item_ids_by_wiql(org, project, wiql)
      url = "https://dev.azure.com/#{org}/#{project}/_apis/wit/wiql?api-version=7.0"
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => "Basic #{credentials}"
      }

      response = RestClient::Request.execute(
        method: :post,
        url:,
        payload: JSON.generate({ query: wiql }),
        headers:
      )

      JSON.parse(response.body)['workItems']
        .map { |item| item['id'] }
        .map(&:to_i)
    rescue StandardError => e
      puts 'Error!'
      puts e

      exit 1
    end

    def get_work_items(org, project, work_item_ids)
      work_item_ids = Array(work_item_ids).join(',')

      url = "https://dev.azure.com/#{org}/#{project}/_apis/wit/workitems?ids=#{work_item_ids}&api-version=7.0"
      headers = {
        'Authorization' => "Basic #{credentials}"
      }

      response = RestClient.get url, headers

      JSON.parse(response.body)['value']
        .map { |item| WorkItem.new(item['id'], item['fields']) }
    rescue StandardError => e
      puts 'Error!'
      puts e

      exit 1
    end

    private

    def credentials
      Base64.encode64(":#{password}").gsub("\n", '')
    end

    attr_reader :password
  end
end
