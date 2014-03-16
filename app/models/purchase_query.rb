class PurchaseQuery
  def self.gross_revenue(purchase_ids)
    PurchaseRecord.joins('INNER JOIN items ON items.id = purchases.item_id').
      where('purchases.id IN (?)', purchase_ids).sum('purchases.count*items.price')
  end
end
