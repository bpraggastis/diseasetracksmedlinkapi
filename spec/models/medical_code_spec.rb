require 'rails_helper'

describe MedicalCode do
  describe 'creates' do
    it 'creates a record' do
      z = MedicalCode.all.length
      MedicalCode.create(code_system: 'blaaaahhh', code_value: 'blah1')
      expect(MedicalCode.count).to eq(z + 1)
    end
  end

  describe 'validates' do
    it 'will not create duplicate records' do
      MedicalCode.create(code_system: 'BDiseaseDatabase', code_value: '123')
      z = MedicalCode.all.length
      MedicalCode.create(code_system: 'BDiseaseDatabase', code_value: '123')
      expect(MedicalCode.count).to eq(z)
    end
    it 'will create unique records' do
      MedicalCode.create(code_system: 'BDiseaseDatabase', code_value: '123')
      z = MedicalCode.all.length
      MedicalCode.create(code_system: 'BDiseaseDatabase', code_value: '456')
      expect(MedicalCode.count).to eq(z + 1)
    end
  end
end
