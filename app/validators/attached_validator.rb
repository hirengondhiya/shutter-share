# code attribution https://gist.github.com/carlosramireziii/73f2c7b12dd6716482e41a3cd8e0a94d#file-attached_validator-rb
# To validate presence of attachment
class AttachedValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors.add(attribute, :attached, options) unless value.attached?
    end
end