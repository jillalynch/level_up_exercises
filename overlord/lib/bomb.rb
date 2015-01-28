class Bomb
  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :state, :deactivation_attempts,
              :activation_code, :deactivation_code

  attr_accessor :activation_code, :deactivation_code

  def initialize(options = {})
    @state = :disarmed
    @deactivation_attempts = 0
    @deactivation_code = DEFAULT_DEACTIVATION_CODE
    @activation_code = DEFAULT_ACTIVATION_CODE
  end

  def armed?
    @state == :armed
  end

  def disarmed?
    @state == :disarmed
  end

  def detonated?
    @state == :detonated
  end

  def enter_code(code)
    if code == activation_code && disarmed?
      arm!
    elsif armed?
      attempt_deactivation(code)
    end
  end

  def valid_code?(code)
    code.numeric? && (code.length == 4)
  end

  private

  # private :activation_code
  # private :deactivation_code
  private :deactivation_attempts

  def detonate!
    change_state(:detonated)
  end

  def disarm!
    change_state(:disarmed)
  end

  def arm!
    change_state(:armed)
  end

  def attempt_deactivation(code)
    if deactivation_code == code
      disarm!
    else
      @deactivation_attempts += 1
      detonate! if @deactivation_attempts >= MAX_DEACTIVATION_ATTEMPTS
    end
  end

  def change_state(new_state)
    allowed_state_changes =
        {
        armed: [:detonated, :disarmed],
        disarmed: [:armed],
        detonated: [],
        }
    @state = new_state if allowed_state_changes.include?(new_state)
  end
end

# should I use extends string here?
class String
  def numeric?
    /^\d{4}$/ === self
  end
end