class_name CostView
extends RichTextLabel

@export var item_container : ItemContainer :
	set(value):
		item_container = value
		item_container.selected_totals_changed.connect(_on_selected_totals_changed)

## The template for showing the cost. Keep %d so the calculated cost
## can be added to the string.
@export var text_template : String = "COST: %d"

## The cost of the current transaction being proposed
var cost : float = 0.0 :
	set(value):
		cost = value
		update_text()

func _ready() -> void:
	validate()
	update_text()

## TODO: Move this calculation to the shop model cost_view should only show not calculate
func calculate_cost(p_items : Dictionary[BaseItem, int]) -> float:
	var total_cost := 0.0

	for item in p_items.keys() as Array[BaseItem]:
		total_cost += p_items[item] * item.value

	return total_cost

func update_text() -> void:
	text = text_template % cost

func validate() -> Array[String]:
	var issues : Array[String] = []

	return issues

func _on_selected_totals_changed(p_item_totals : Dictionary[BaseItem, int]) -> void:
	cost = calculate_cost(p_item_totals)
	update_text()
