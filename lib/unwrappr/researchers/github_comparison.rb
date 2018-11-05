# frozen_string_literal: true

module Unwrappr
  module Researchers
    # Compares the old version to the new via the Github API:
    # https://developer.github.com/v3/repos/commits/#compare-two-commits
    #
    # Implements the `gem_researcher` interface required by the
    # LockFileAnnotator.
    class GithubComparison
      GITHUB_SOURCE_URI_PATTERN =
        %r{^https?://github.com/(?<repo>[^/]+/[^/]+)}i.freeze

      def initialize(client)
        @client = client
      end

      def research(gem_change, gem_change_info)
        source_uri = gem_change_info[:ruby_gems]&.source_code_uri
        repo = GITHUB_SOURCE_URI_PATTERN.match(source_uri)&.[](:repo)
        return gem_change_info if repo.nil?

        gem_change_info.merge(
          github_comparison: try_comparing(
            repo: repo,
            base: gem_change.base_version,
            head: gem_change.head_version
          )
        )
      end

      private

      def try_comparing(repo:, base:, head:)
        comparison = compare(repo, "v#{base}", "v#{head}")
        comparison ||= compare(repo, base.to_s, head.to_s)
        comparison
      end

      def compare(repo, base, head)
        @client.compare(repo, base, head)
      rescue Octokit::NotFound
        nil
      end
    end
  end
end