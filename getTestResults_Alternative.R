getTestResults_Alternative <- function(
	model, 
	prob_preds, 
	real_labels, 
	case = case, 
	control = control, 
	type_opt = "misclasserror", 
	type = "Test"
) {

cm_obj = getCM(
	model = model, 
	prob_preds = prob_preds, 
	real_labels = real_labels, 
	case = case, 
	control = control, 
	type_opt = type_opt
)

auroc_obj = PRROC::roc.curve(
    scores.class0 = prob_preds,
    weights.class0 = ifelse(real_labels == case, 1, 0),
    curve = TRUE
  )

}
