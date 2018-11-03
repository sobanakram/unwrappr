# frozen_string_literal: true

module Unwrappr
  module Writers
    RSpec.describe GithubPullRequests do
      describe '.write' do
        subject(:write) { described_class.write(gem_change, gem_change_info) }

        let(:gem_change) { double }

        context 'given no pull requests' do
          let(:gem_change_info) { {} }

          it { is_expected.to be_nil }
        end

        context 'given zero pull requests' do
          let(:gem_change_info) { { github_pull_requests: [] } }

          it { is_expected.to be_nil }
        end

        context 'given 3 pull requests' do
          let(:gem_change_info) do
            {
              github_pull_requests: [
                double(
                  title: 'test-pr-title-1',
                  html_url: 'test-pr-html-url-1',
                  number: 1
                ),
                double(
                  title: 'test-pr-title-2',
                  html_url: 'test-pr-html-url-2',
                  number: 2
                ),
                double(
                  title: 'test-pr-title-3',
                  html_url: 'test-pr-html-url-3',
                  number: 3
                )
              ]
            }
          end

          it { is_expected.to eq <<~MESSAGE }
            <details>
            <summary>Pull Requests</summary>

            Found **3** pull requests based on commit messages:
            - [#1: test-pr-title-1](test-pr-html-url-1)
            - [#2: test-pr-title-2](test-pr-html-url-2)
            - [#3: test-pr-title-3](test-pr-html-url-3)


            </details>
          MESSAGE
        end
      end
    end
  end
end
