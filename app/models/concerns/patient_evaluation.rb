# frozen_string_literal: true

class PatientEvaluation
  extend ActiveSupport::Concern

  included do
    def has_rapid_kidney_function_loss?

    end

    def has_proteinura?

    end

    def has_persistent_glomerular_hematuria?

    end

    def has_pathological_cylinders?

    end

    def has_polycistic_kidney_disease?

    end

    def has_nephrolithiasis?

    end

    def has_recurrent_uti?

    end

    def has_ckd_and_hypertension?

    end
  end
end
