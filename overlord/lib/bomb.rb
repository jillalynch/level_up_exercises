class Bomb
  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :state, :count

  def initialize
    @state = :disarmed
    @count = 0
    @deactivation_code = DEFAULT_DEACTIVATION_CODE
    @activation_code = DEFAULT_ACTIVATION_CODE
  end

  def default_activation_code
    DEFAULT_ACTIVATION_CODE
  end

  def default_deactivation_code
    DEFAULT_DEACTIVATION_CODE
  end

  def enter_code(code)
    # return false unless valid_code?(code)

    arm    if disarmed? && @activation_code == code
    disarm if armed?    && @deactivation_code == code
    detonate unless count < 2
    attempt_deactivation if count < 2


    if code == DEFAULT_DEACTIVATION_CODE
      disarm
    else
      arm
    end
    # elsif code == DEFAULT_ACTIVATION_CODE
    #   arm
    # elsif
    #   if (count > MAX_DEACTIVATION_ATTEMPTS + 1)
    #     failed disarmaments
    #   end
    # else
    #   detonate
    # end


  end

  def action

  end

  def valid_code?(code)

  end

  def is_number?
    true if Float(self) rescue false
  end

  def attempt_deactivation
    @count += 1
  end
  
  def configured?
    configured?
  end

  def armed?
    @state == :armed
  end

  def arm
    @state = :armed
  end

  def disarmed?
    @state == :disarmed
  end

  def disarm
    @state = :disarmed
  end

  def detonate
    @state = :detonated
  end

  def detonated?
    @state == :detonated
  end
end