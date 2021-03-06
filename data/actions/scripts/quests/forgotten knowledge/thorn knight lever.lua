local config = {
	centerRoom = Position(32624, 32880, 14),
	BossPosition = Position(32624, 32880, 14),
	newPosition = Position(32624, 32886, 14)
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then
		if player:getPosition() ~= Position(32657, 32877, 14) then
			item:transform(9826)
			return true
		end
	end
	if item.itemid == 9825 then
		if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.ThornKnightTimer) >= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge Thorn Knight.")
			return true
		end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Thorn Knight.")
				return true
			end
		end
		for d = 1, 6 do
			Game.createMonster('possessed tree', Position(math.random(32619, 32629), math.random(32877, 32884), 14), true, true)
		end
		Game.createMonster("mounted thorn knight", config.BossPosition, true, true)
		for y = 32877, 32881 do
			local playerTile = Tile(Position(32657, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				playerTile:setExhaustion(Storage.ForgottenKnowledge.ThornKnightTimer, 20 * 60 * 60)
			end
		end
		Game.setStorageValue(GlobalStorage.ForgottenKnowledge.ThornKnightTimer, 1)
		addEvent(clearForgotten, 30 * 60 * 1000, Position(32613, 32869, 14), Position(32636, 32892, 14), Position(32678, 32888, 14), GlobalStorage.ForgottenKnowledge.ThornKnightTimer)
		item:transform(9826)
		elseif item.itemid == 9826 then
		item:transform(9825)
	end
	return true
end
		
		
		
		