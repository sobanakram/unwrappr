# frozen_string_literal: true

module Unwrappr
  module Writers
    # TODO
    # Implements the `annotation_writer` interface required by the
    # LockFileAnnotator.
    class GithubPullRequests
      def self.write(gem_change, gem_change_info)
        new(gem_change, gem_change_info).write
      end

      def initialize(_gem_change, gem_change_info)
        @gem_change_info = gem_change_info
      end

      def write
        return nil unless pull_requests&.any?

        collapsed_section('Pull Requests', <<~MESSAGE)
          Found **#{pull_requests.size}** pull requests based on commit messages:
          #{pull_request_messages.join("\n")}
        MESSAGE
      end

      private

      def pull_request_messages
        pull_requests.map do |pr|
          "- [##{pr.number}: #{pr.title}](#{pr.html_url})"
        end
      end

      def pull_requests
        @gem_change_info[:github_pull_requests]
      end

      def collapsed_section(summary, body)
        <<~MESSAGE
          <details>
          <summary>#{summary}</summary>

          #{body}

          </details>
        MESSAGE
      end
    end
  end
end
