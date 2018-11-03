# frozen_string_literal: true

module Unwrappr
  module Researchers
    RSpec.describe GithubComparison do
      subject(:github_pull_requests) { GithubPullRequests.new(client) }

      let(:client) { instance_double(Octokit::Client, pull_request: 'not-expected') }

      describe '#research' do
        subject(:research) { github_pull_requests.research(gem_change, gem_change_info) }

        let(:gem_change) { instance_double(GemChange) }
        let(:gem_change_info) do
          {
            github_repo: github_repo,
            github_comparison: github_comparison
          }
        end
        let(:github_comparison) { nil }

        context 'given no Github repo' do
          let(:github_repo) { nil }

          it "doesn't add pull request data" do
            expect(research).to_not include(:github_pull_requests)
          end

          it 'returns the data provided in gem_change_info' do
            expect(research).to include(gem_change_info)
          end
        end

        context 'given a Github repo' do
          let(:github_repo) { 'envato/unwrappr' }

          context 'given no Github comparison' do
            let(:github_comparison) { nil }

            it "doesn't add pull request data" do
              expect(research).to include(github_pull_requests: [])
            end

            it 'returns the data provided in gem_change_info' do
              expect(research).to include(gem_change_info)
            end
          end

          context 'given a Github comparison with no PR commits' do
            let(:github_comparison) do
              double(
                commits: [
                  double(commit: double(message: 'not a pull request message'))
                ]
              )
            end

            it "doesn't add pull request data" do
              expect(research).to include(github_pull_requests: [])
            end

            it 'returns the data provided in gem_change_info' do
              expect(research).to include(gem_change_info)
            end
          end

          context 'given a Github comparison with a PR merge commit' do
            let(:github_comparison) do
              double(
                commits: [
                  double(commit: double(message: 'not a pull request message')),
                  double(commit: double(message: 'Merge pull request #42')),
                  double(commit: double(message: 'not a pull request message 2'))
                ]
              )
            end
            let(:response) { double }
            before do
              expect(client).to receive(:pull_request).with(github_repo, 42).and_return(response)
            end

            it 'adds the pull request data' do
              expect(research).to include(github_pull_requests: [response])
            end

            it 'returns the data provided in gem_change_info' do
              expect(research).to include(gem_change_info)
            end
          end
        end
      end
    end
  end
end
