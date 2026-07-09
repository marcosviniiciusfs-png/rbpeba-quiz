drop policy if exists "Allow public qualified lead inserts" on public.quiz_leads;

create policy "Allow public qualified lead inserts"
  on public.quiz_leads
  for insert
  to anon
  with check (
    qualified = true
    and status = 'qualified'
    and lead_name is not null
    and length(trim(lead_name)) >= 2
    and whatsapp_digits is not null
    and length(whatsapp_digits) >= 10
  );
