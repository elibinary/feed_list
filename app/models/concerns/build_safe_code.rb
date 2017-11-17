module BuildSafeCode
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def generate_code
    SecureRandom.uuid.gsub('-', '')
  end

  def ensure_safe_code
    self.safe_code ||= generate_code
  end
end