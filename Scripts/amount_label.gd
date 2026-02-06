extends Label
class_name AmountLabel

var amount = 0
	
func increment_amount():
	amount += 1
	text = "%d" % amount
