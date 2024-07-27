class NefrocheckService

  def initialize(patient)
    @patient = patient
  end

  def evaluate_and_save
    result = evaluate
    save_evaluation(result)
    result
  end

  private

  def evaluate
    return { referral_needed: false, message: "Não há indicação de encaminhamento para o nefrologista" } unless has_prior_exams?

    tfg = calculate_tfg

    if tfg <= 30
      return referral("TFG <= 30 ml/min/1.73 m²")
    elsif tfg > 60
      return handle_tfg_above_60
    else
      return handle_tfg_between_30_and_60
    end
  end

  def save_evaluation(result)
    NefrochekEvaluation.create(
      patient: @patient,
      tfg: result[:tfg],
      referral_needed: result[:referral_needed],
      message: result[:message],
      details: result[:details]
    )
  end

  def has_prior_exams?
    patient.exams.present?
  end

  def calculate_tfg
    (140 - @patient.age) * @patient.weight /  @patient.height
  end

  def handle_tfg_above_60
    if @patient.has_polycystic_kidney_disease?
      return referral("Doença renal policística")
    elsif @patient.has_nephrolithiasis?
      return referral("Nefrolitíase")
    elsif @patient.has_recurrent_uti?
      return referral("ITU de repetição")
    elsif @patient.has_ckd_and_hypertension?
      return referral("DRC e hipertensão ou hipertensão secundária")
    else
      return { referral_needed: false, message: "Não há indicação de encaminhamento para o nefrologista" }
    end
  end

  def handle_tfg_between_30_and_60
    if @patient.has_rapid_kidney_function_loss?
      return referral("Perda Rapída de Função Renal")
    elsif @patient.has_proteinura?
      return referral("Proteinura")
    elsif @patient.has_persistent_glomerular_hematuria?
      return referral("Hematuria Glomerular Persistente")
    elsif @patient.has_pathological_cylinders?
      return referral("Cilíndros com potencial patológico")
    else
      return { referral_needed: false, message: "Não há indicação de encaminhamento para o nefrologista" }
    end
  end

  def referral(reason)
    { referral_needed: true, message: "Encaminhamento para nefrologista por #{reason}" }
  end
end