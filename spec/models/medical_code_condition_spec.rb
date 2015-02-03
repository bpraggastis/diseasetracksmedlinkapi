require 'rails_helper'

describe MedicalCodeCondition do
  describe 'validations' do
    it 'fails if you add a code from a system that has already assigned a code' do
      d = MedicalCondition.create(
        name: "Hypochondria",
        description: "Subject has every disease, ever"
      )
      d.codes.create(code_system: "Linnea's Diseases", code_value: "1234woo")
      y = MedicalCode.create(code_system: "Linnea's Diseases", code_value: "1")
      expect(MedicalCodeCondition.new(medical_code_id: y.id, medical_condition_id: d.id)).to be_invalid
    end

    it 'passes if you add a code from a new system' do
      d = MedicalCondition.create(
        name: "Hypochondria",
        description: "Subject has every disease, ever"
      )
      d.codes.create(code_system: "Linnea's Diseases", code_value: "1234woo")
      y = MedicalCode.create(code_system: "Brenda's Diseases", code_value: '1234hoo')
      expect(MedicalCodeCondition.new(medical_code_id: y.id, medical_condition_id: d.id)).to be_valid
    end
  end
end
