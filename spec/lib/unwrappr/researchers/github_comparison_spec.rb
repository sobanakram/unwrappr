# frozen_string_literal: true

module Unwrappr
  module Researchers
    RSpec.describe GithubComparison do
      subject(:github_comparison) { GithubComparison.new(client) }

      let(:client) { instance_double(Octokit::Client) }
      before do
        allow(client).to receive(:compare).and_raise(Octokit::NotFound)
      end

      describe '#research' do
        subject(:research) { github_comparison.research(gem_change, gem_change_info) }

        let(:gem_change) do
          instance_double(
            GemChange,
            base_version: base_version,
            head_version: head_version
          )
        end
        let(:gem_change_info) { { github_repo: github_repo } }
        let(:base_version) { GemVersion.new('1.0.0') }
        let(:head_version) { GemVersion.new('1.1.0') }
        let(:response) { double }

        context 'given no Github repo' do
          let(:github_repo) { nil }

          it "doesn't add data from Github" do
            expect(research[:github_comparision]).to be_nil
          end

          it 'returns the data provided in gem_change_info' do
            expect(research).to include(gem_change_info)
          end
        end

        context 'given a Github repo' do
          let(:github_repo) { 'envato/unwrappr' }

          context 'given the gem is added' do
            let(:base_version) { nil }
            let(:head_version) { GemVersion.new('1.1.0') }

            it "doesn't contact GitHub for a result we already know" do
              research
              expect(client).to_not have_received(:compare)
            end

            it "doesn't add data from Github" do
              expect(research[:github_comparision]).to be_nil
            end

            it 'returns the data provided in gem_change_info' do
              expect(research).to include(gem_change_info)
            end
          end

          context 'given the gem is removed' do
            let(:base_version) { GemVersion.new('1.0.0') }
            let(:head_version) { nil }

            it "doesn't contact GitHub for a result we already know" do
              research
              expect(client).to_not have_received(:compare)
            end

            it "doesn't add data from Github" do
              expect(research[:github_comparision]).to be_nil
            end

            it 'returns the data provided in gem_change_info' do
              expect(research).to include(gem_change_info)
            end
          end

          context 'given the gem version changed' do
            let(:base_version) { GemVersion.new('1.0.0') }
            let(:head_version) { GemVersion.new('1.1.0') }

            context 'given the repo has "vx.x.x" tags' do
              before do
                allow(client).to receive(:compare)
                  .with('envato/unwrappr', 'v1.0.0', 'v1.1.0')
                  .and_return(response)
              end

              it 'returns the data from Github' do
                expect(research[:github_comparison]).to eq(response)
              end

              it 'returns the data provided in gem_change_info' do
                expect(research).to include(gem_change_info)
              end
            end

            context 'given the repo has "x.x.x" tags' do
              before do
                allow(client).to receive(:compare)
                  .with('envato/unwrappr', '1.0.0', '1.1.0')
                  .and_return(response)
              end

              it 'returns the data from Github' do
                expect(research[:github_comparison]).to eq(response)
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
end
