drop policy if exists "Allow public qualified lead inserts" on public.quiz_leads;

create policy "Allow public qualified lead inserts"
  on public.quiz_leads
  for insert
  to public
  with check (true);
