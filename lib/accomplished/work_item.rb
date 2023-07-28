# frozen_string_literal: true

module Accomplished
  class WorkItem
    ORGANIZATION = 'tr-commercial-eng'

    attr_reader :id, :fields

    def description
      @description ||= fields['System.Description']
    end

    def type
      @type ||= fields['System.WorkItemType']
    end

    def assigned_to
      return @assigned_to if defined? @assigned_to

      if fields['System.AssignedTo'].blank? || fields['System.AssignedTo']['displayName'].blank?
        return @assigned_to = 'No body'
      end

      @assigned_to = fields['System.AssignedTo']['displayName']
    rescue StandardError => e
      puts "Error: #{e.class}"
      puts e.backtrace

      exit 1
    end

    def state
      @state ||= fields['System.State']
    end

    def title
      @title ||= fields['System.Title']
    end

    def project
      @project ||= fields['System.TeamProject']
    end

    def url
      @url ||= "https://dev.azure.com/#{ORGANIZATION}/#{project}/_workitems/edit/#{id}".gsub(' ', '%20')
    end

    def iteration_path
      @iteration_path ||= fields['System.IterationPath']
    end

    def initialize(id, fields)
      @id = id
      @fields = fields
    end

    def to_markdown
      <<~MARKDOWN
        ## #{title}

        - I am a(n) **#{state}** #{type}
        - Assigned to #{assigned_to}
        - And I can be found at #{url}

        ### Description

        #{description}
      MARKDOWN
    end

    def to_h
      {
        id:,
        description:,
        state:,
        iteration_path:,
        fields:
      }
    end

    def to_s
      "#{type}, #{state}, AB##{id}, #{title}, #{url}"
    end
  end
end
