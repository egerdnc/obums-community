ITEM.name = "Moonshine";
ITEM.model = Model("models/props_junk/garbage_glassbottle003a.mdl");
ITEM.width = 1;
ITEM.height = 1;
ITEM.description = "Some moonshine, you might be able to sell it for some tokens.";
ITEM.category = "Brewing";
ITEM.noBusiness = true;

function ITEM:PopulateTooltip(tool)
  local quality = tool:AddRow("quality");
  quality:SetText("Quality: " .. self:GetData("quality", 0));
  quality:SetBackgroundColor(Color(0, 110, 230));
  quality:SetExpensiveShadow(0.5);
  quality:SizeToContents();

  local warning = tool:AddRow("warning");
  warning:SetBackgroundColor(derma.GetColor("Error", tool));
  warning:SetText("This item is illegal.");
  warning:SetFont("BudgetLabel");
  warning:SetExpensiveShadow(0.5);
  warning:SizeToContents();
end;
