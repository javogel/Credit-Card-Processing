# frozen_string_literal: true

module LuhnVerifier
  def valid_luhn_number?(num)
    digits = num.chars.map(&:to_i)
    check = digits.pop
    sum = m_sum(digits)
    check.zero? ? (sum % 10).zero? : (10 - sum % 10) == check
  end

  def m_sum(digits)
    digits.reverse.each_slice(2).flat_map do |x, y|
      [(x * 2).divmod(10), y || 0]
    end.flatten.inject(:+)
  end
end
