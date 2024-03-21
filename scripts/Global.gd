extends Node

signal seed_changed(seed)
signal update_station
signal gained_coin(int)
signal removed_coin(int)

var coins : int = 1000
var time : float = 0.0
var hour : int 

func gain_coin(newCoin : int):
	coins += newCoin
	emit_signal("gained_coin", coins)

func remove_coin(amount : int) :
	coins -= amount
	emit_signal("removed_coin", coins)
	
	
