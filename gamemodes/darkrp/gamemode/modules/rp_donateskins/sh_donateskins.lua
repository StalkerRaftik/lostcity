DonateSkins = {}
for key, dTable in pairs(rp.shop:GetTable()) do
	if dTable.Cat == "Модели" then
		DonateSkins[dTable.RefJob] = DonateSkins[dTable.RefJob] or {}

		table.insert(DonateSkins[dTable.RefJob], dTable.Icon)
	end
end

DonateSkinsDict = {}
for key, dTable in pairs(rp.shop:GetTable()) do
	if dTable.Cat == "Модели" then
		DonateSkinsDict[dTable.RefJob] = DonateSkinsDict[dTable.RefJob] or {}

		DonateSkinsDict[dTable.RefJob][dTable.Icon] = dTable.UID
	end
end

function IsDonateModel(job, model)
    return DonateSkinsDict[job] and isstring(DonateSkinsDict[job][model]) or false
end