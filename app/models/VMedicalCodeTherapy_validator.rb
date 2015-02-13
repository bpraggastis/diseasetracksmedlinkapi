# class VmedicalcodetherapyValidator < ActiveModel::EachValidator
#
#   def validate_each record, attribute, value
#     # this method validates that a medical therapy does not get more than one code
#     # from the same organization
#
#     # codes that the medical therapy has already been assigned
#     codes = record.medical_therapy.codes
#     # the code systems of those codes
#     organizations = codes.map {|code| code.code_system}
#     # test if the new code is from a system that has already submitted a code
#     if organizations.include? MedicalCode.find(value).code_system
#       record.errors[attribute] << (
#         options[:message] || "is from an organization that has already assigned a code to this treatment. Organization: #{MedicalCode.find(value).code_system} Treatment: #{MedicalTherapy.find(record.medical_therapy_id).name}"
#       )
#     else
#       true
#     end
#   end
#
# end
