local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end);
f:RegisterEvent("PLAYER_LOGIN");

function f:PLAYER_LOGIN(...)
  local class = select(2, UnitClass("player"));
  if class == "ROGUE" or class == "SHAMAN" or class == "WARLOCK" then f:RegisterEvent("READY_CHECK"); end
  f:UnregisterEvent("PLAYER_LOGIN"); self.PLAYER_LOGIN = nil;
end

function f:READY_CHECK(...)
  local class = select(2, UnitClass("player"));
  local mH, mHD, _, oH, oHD = GetWeaponEnchantInfo();
  local oHT = select(7, GetItemInfo(GetInventoryItemLink("player", GetInventorySlotInfo("SecondaryHandSlot")) or ""));
  if (mH ~= 1 or ((mHD or 0) <= 300000)) or ((oH ~= 1 or ((mHD or 0) <= 300000)) and oHT ~= "Shields") then
    StaticPopup_Show("TYLER_IS_A_NUB", class == "ROGUE" and "Poisons" or "Weapon Buff(s)");
  end
end

StaticPopupDialogs["TYLER_IS_A_NUB"] = {
  text = "Your %s need to be reapplied.",
  button1 = OKAY, timeout = 30, hideOnEscape = 1, showAlert = 1
};