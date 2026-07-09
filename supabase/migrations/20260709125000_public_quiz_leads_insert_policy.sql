drop policy if exists "Allow public qualified lead inserts" on public.quiz_leads;

grant usage on schema public to public;
grant insert on public.quiz_leads to public;

create policy "Allow public qualified lead inserts"
  on public.quiz_leads
  for insert
  to public
  with check (
    qualified = true
    and status = 'qualified'
    and lead_name is not null
    and length(trim(lead_name)) >= 2
    and whatsapp_digits is not null
    and length(whatsapp_digits) >= 10
  );
