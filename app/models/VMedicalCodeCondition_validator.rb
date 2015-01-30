class VMedicalCodeConditionValidator < ActiveModel::EachValidator

  def validate_each record, attribute, value
    # this method validates that
    codes = MedicalCondition.find(record.medical_condition_id)
    organizations = codes.map {|code| code.code_system}
    if organizations.include? MedicalCode.find(value).code_system
      record.errors[attribute] << (
        options[:message] || "is from an organization that has already assigned a code to this disease"
      )
    else
      true
    end
  end

end
