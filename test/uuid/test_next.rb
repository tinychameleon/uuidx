# frozen_string_literal: true

require "test_helper"

class UuidTestNext < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Uuid::Next::VERSION
  end

  def test_that_it_has_the_nil_uuid
    refute_nil ::Uuid::Next::NIL_UUID
  end

  def test_that_it_has_the_max_uuid
    refute_nil ::Uuid::Next::MAX_UUID
  end

  def test_that_it_exposes_uuid6
    refute_nil ::Uuid::Next::V6
  end
end
