# frozen_string_literal: true

require_relative "../lib/uuidx"

class ConstantGeneratorDefinition # :nodoc:
  def custom_a
    1
  end

  def custom_b
    2
  end

  def custom_c
    3
  end
end

g = Uuidx::Version8.new(ConstantGeneratorDefinition)
100_000.times { g.generate }
