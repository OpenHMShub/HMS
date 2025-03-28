SELECT cc.id, cc.name, cc.canAdd, cc.canDeduct
FROM participant.CampusStoreCategory cc
WHERE cc.name in ('Purchase','Adjustment','Incident','Award','What''s Inn Store Voucher Purchase')