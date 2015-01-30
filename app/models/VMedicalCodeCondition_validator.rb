class VmedicalcodeconditionValidator < ActiveModel::EachValidator

  def validate_each record, attribute, value
    # this method validates that a medical condition does not get more than one code
    # from the same organization

    # codes that the medical condition has already been assigned
    codes = MedicalCondition.find(record.medical_condition_id).codes

    # the code systems of those codes
    organizations = codes.map {|code| code.code_system}

    # test if the new code is from a system that has already submitted a code
    if organizations.include? MedicalCode.find(value).code_system
      record.errors[attribute] << (
        options[:message] || "is from an organization that has already assigned a code to this disease"
      )
    else
      true
    end
  end

end
