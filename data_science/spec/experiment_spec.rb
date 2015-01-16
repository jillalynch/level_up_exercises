require_relative '../experiment.rb'

describe Experiment do
  let(:experiment) do
    success_results = {
      a_conversions: 30,
      a_rejections:  5,
      b_conversions: 30,
      b_rejections:  30,
    }
    Experiment.new(results(success_results))
  end

  let(:tie_experiment) do
    tie_results = {
      a_conversions: 5,
      a_rejections:  5,
      b_conversions: 5,
      b_rejections:  5,
    }
    Experiment.new(results(tie_results))
  end

  def result(cohort, result)
    { "date" => "2014-03-20", "cohort" => cohort, "result" => result }
  end

  def results(a_conversions:, a_rejections:, b_conversions:, b_rejections:)
    [].tap do |result_set|
      a_conversions.times { result_set << result("A", 1) }
      a_rejections.times  { result_set << result("A", 0) }
      b_conversions.times { result_set << result("B", 1) }
      b_rejections.times  { result_set << result("B", 0) }
    end
  end

  describe '#format_for_abanlyzer' do
    let(:groups) { experiment.send(:format_for_abanalyzer) }
    it 'adds the cohorts' do
      expect(groups.keys).to match_array([:A, :B])
    end

    it 'adds successes and failures to groups' do
      expect(groups[:A].keys).to match_array([:failure, :success])
    end

    it 'groups by cohort name and counts successes and failures' do
      correct_output = {
        A: { success: 30, failure: 5 },
        B: { success: 30, failure: 30 },
      }
      expect(groups).to eq(correct_output)
    end
  end

  describe '#winner' do
    it "returns winner for a cohort above significant dif" do
      expect(experiment.winner.name).to eq("A")
    end
    it "returns nil if no statistical dif" do
      expect(tie_experiment.winner).to eq(nil)
    end
  end

  describe '#difference?' do
    it "returns if true there is a statistical difference" do
      expect(experiment.difference?).to eq(true) # 0.0004 <= 0.05
    end
    it "returns false if there is no statistical difference" do
      expect(tie_experiment.difference?).to eq(false) # 1 <= 0.05
    end
  end
end
