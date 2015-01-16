require 'abanalyzer'
require_relative 'page_view.rb'
require_relative 'cohort.rb'

class Experiment
  CONFIDENCE_LEVEL      = 1.96
  PROBABILITY_THRESHOLD = 0.05

  def initialize(results)
    create_cohorts(pageviews(results))
    @test = ABAnalyzer::ABTest.new(format_for_abanalyzer)
  end

  def report
    if winner
      winner.to_s
    else
      "There is no clear winner!"
    end
  end

  def winner
    @cohorts.sort_by(&:conversion_percentage).last if difference?
  end

  def difference?
    @test.chisquare_p <= PROBABILITY_THRESHOLD
  end

  private

  def pageviews(results)
    results.map { |result| PageView.new(result["cohort"], result["result"]) }
  end

  def create_cohorts(pageviews)
    @cohorts = []
    pageviews.group_by(&:cohort).each do |name, views|
      @cohorts << Cohort.new(name, views)
    end
  end

  # adapter for abanalyzer could be extracted to its own class
  def format_for_abanalyzer
    # [Cohort obj, Cohort obj]->{A:{success:30, failure:5}, B:{sucs:0, fail:30}}
    @cohorts.each_with_object({}) do |(cohort), hash|
      hash[cohort.name.to_sym] = {
        success: cohort.conversions,
        failure: cohort.rejections,
      }
    end
  end
end
