Fabricator(:billing) do
  pay_date { Time.now }
  active_until { 1.month.from_now }
  amount 9.99
end
