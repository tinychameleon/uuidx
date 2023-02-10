# frozen_string_literal: true

require_relative "uuid/gem_version"
require_relative "uuid/errors"
require_relative "uuid/version4"
require_relative "uuid/version6"
require_relative "uuid/version7"
require_relative "uuid/version8"

# NOTE: clock slewing is OS dependent. We use Process::CLOCK_REALTIME.
# NOTE: clock resolution can be verified for v6 and v7.
# :include: README.md
module Uuid
  # The nil UUID as defined by
  # {§5.10 of RFC 4122 BIS-01}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-nil-uuid].
  #
  # This UUID is written as +00000000-0000-0000-0000-000000000000+ and is less than all other UUIDs in comparisons.
  # It does not act as +nil+.
  def self.nil_uuid
    "00000000-0000-0000-0000-000000000000"
  end

  # The maximum UUID as defined by
  # {§5.10 of RFC 4122 BIS-01}[https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-max-uuid].
  #
  # This UUID is written as +ffffffff-ffff-ffff-ffff-ffffffffffff+ and is greater than all other UUIDs in comparisons.
  def self.max_uuid
    "ffffffff-ffff-ffff-ffff-ffffffffffff"
  end

  # :nodoc:
  def self.format(value)
    b = +value.to_s(16).rjust(32, "0")
    b.insert(8, "-")
    b.insert(13, "-")
    b.insert(18, "-")
    b.insert(23, "-")
    b.freeze
  end
end
