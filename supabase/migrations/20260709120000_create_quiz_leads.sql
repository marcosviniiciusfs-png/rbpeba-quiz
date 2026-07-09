create extension if not exists pgcrypto;

create table if not exists public.quiz_leads (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  qualified boolean not null default true,
  status text not null default 'qualified',

  lead_name text not null,
  whatsapp text not null,
  whatsapp_digits text,

  interest text,
  has_down_payment text,
  down_payment_value numeric,
  monthly_payment_value numeric,
  purchase_timeline text,

  source_url text,
  landing_domain text,
  user_agent text,

  utm_source text,
  utm_medium text,
  utm_campaign text,
  utm_content text,
  utm_term text,
  fbclid text,
  fbp text,
  fbc text,

  meta_event_id text unique,
  meta_conversion_sent boolean not null default false,
  meta_conversion_response jsonb,
  meta_conversion_error text,

  raw_answers jsonb not null default '{}'::jsonb
);

create index if not exists quiz_leads_created_at_idx on public.quiz_leads (created_at desc);
create index if not exists quiz_leads_status_idx on public.quiz_leads (status);
create index if not exists quiz_leads_interest_idx on public.quiz_leads (interest);
create index if not exists quiz_leads_whatsapp_digits_idx on public.quiz_leads (whatsapp_digits);

alter table public.quiz_leads enable row level security;

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

drop policy if exists "No public lead reads" on public.quiz_leads;
create policy "No public lead reads"
  on public.quiz_leads
  for select
  to anon
  using (false);
