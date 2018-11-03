# frozen_string_literal: true

module Unwrappr
  module Researchers
    # Inspects Github comparison commits identifying pull request merges, then
    # enriches the gem change info with pull request info from Github:
    # https://developer.github.com/v3/pulls/#get-a-single-pull-request
    #
    # Implements the `gem_researcher` interface required by the
    # LockFileAnnotator.
    class GithubPullRequests
      MERGE_PR_NUMBER_PATERN = /^Merge pull request #(?<pr_number>[\d]+)/.freeze

      def initialize(client)
        @client = client
      end

      def research(_gem_change, gem_change_info)
        repo = gem_change_info[:github_repo]
        return gem_change_info if repo.nil?

        gem_change_info.merge(
          github_pull_requests:
            pull_requests(repo, pr_numbers(commit_messages(gem_change_info)))
        )
      end

      private

      def commit_messages(gem_change_info)
        comparison = gem_change_info[:github_comparison]
        return [] if comparison.nil?

        comparison.commits.map do |commit|
          commit.commit.message.lines.first.strip
        end
      end

      def pr_numbers(commit_messages)
        commit_messages
          .map { |message| pr_number(message, MERGE_PR_NUMBER_PATERN) }
          .compact
          .sort
      end

      def pr_number(message, pattern)
        match = pattern.match(message)
        match[:pr_number].to_i unless match.nil?
      end

      def pull_requests(repo, pr_numbers)
        pr_numbers
          .map { |pr_number| pull_request(repo, pr_number) }
          .compact
      end

      def pull_request(repo, pr_number)
        @client.pull_request(repo, pr_number)
      rescue Octokit::NotFound
        nil
      end
    end
  end
end
