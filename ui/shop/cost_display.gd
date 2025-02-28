class_name CostDisplay
extends RichTextLabel

@export var stock_view : ItemContainerView :
	set(value):
		if stock_view != null:
			stock_view.selected_items_changed.disconnect(_on_view_selected_items_changed)
			
		stock_view == null
		
		if stock_view != null:
			stock_view.selected_items_changed.connect(_on_view_selected_items_changed)

## The cost of the current transaction being proposed
var cost : float = 0.0

## Adds the price of all the selected items in all stack views together to come up with
## a total cost.
## TODO: Modify by price multiplier if any
func calculate_cost(p_stack_views : Array[StackView]) -> float:
	var total_cost := 0.0
	
	for view in p_stack_views:
		total_cost += view.selected_count * view.item_stack.item.value
	
	return total_cost

func _on_view_selected_items_changed(p_stack_views : Array[StackView]) -> void:
	cost = calculate_cost(p_stack_views)
