class_name CostDisplay
extends RichTextLabel

## The view holding the items being shopped for which the cost is calculated from
## depending on the number and type of items selected.
## TODO: This should probably be seperated from the view but use the underlying selection StackSelection instead
@export var shop_view : ItemContainerView :
	set(value):
		if shop_view != null:
			shop_view.stack_selection_amount_changed.disconnect(_on_view_stack_selection_amount_changed)
			
		shop_view = value
		
		if shop_view != null:
			shop_view.stack_selection_amount_changed.connect(_on_view_stack_selection_amount_changed)

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

## Adds the price of all the selected items in all stack views together to come up with
## a total cost.
## TODO: Modify by price multiplier if any
func calculate_cost(p_stack_views : Array[StackView]) -> float:
	var total_cost := 0.0
	
	for view in p_stack_views:
		if view.item_stack == null || view.item_stack.item == null: continue # No item to calculate
		
		total_cost += view.selection.amount * view.item_stack.item.value
	
	return total_cost
	
func update_text() -> void:
	text = text_template % cost
	
func validate() -> Array[String]:
	var problems : Array[String] = []
	
	if shop_view == null:
		problems.append("No stock view assigned, shopping cost will not update.")
		
	return problems

func _on_view_stack_selection_amount_changed(p_stack_selection : StackSelection) -> void:
	cost = calculate_cost(shop_view.stack_views)
