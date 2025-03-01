class_name CostDisplay
extends RichTextLabel

## The view holding the items being shopped for which the cost is calculated from
## depending on the number and type of items selected.
@export var shop_view : ItemContainerView :
	set(value):
		if shop_view != null:
			shop_view.selected_items_changed.disconnect(_on_view_selected_items_changed)
			
		shop_view = value
		
		if shop_view != null:
			shop_view.selected_items_changed.connect(_on_view_selected_items_changed)

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
		
		total_cost += view.selected_count * view.item_stack.item.value
	
	return total_cost
	
func update_text() -> void:
	text = text_template % cost
	
func validate() -> bool:
	var no_problems := true
	
	if shop_view == null:
		push_warning("No stock view assigned, shopping cost will not update.")
		no_problems = false
		
	return no_problems

func _on_view_selected_items_changed(p_stack_views : Array[StackView]) -> void:
	cost = calculate_cost(p_stack_views)
