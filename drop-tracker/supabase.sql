-- Drop Tracker online veritabanı kurulumu
create table if not exists public.drops (
  id uuid primary key default gen_random_uuid(),
  tracker_code text not null,
  type text not null check (type in ('Rare','Big Rare','Epic','Legendary')),
  created_at timestamptz not null default now()
);

create index if not exists drops_tracker_code_created_at_idx
on public.drops (tracker_code, created_at);

alter table public.drops enable row level security;

-- Demo/personal tracker modeli: Tracker Kodu bilen cihazlar aynı listeye erişebilir.
drop policy if exists "public read drops" on public.drops;
drop policy if exists "public insert drops" on public.drops;
drop policy if exists "public delete drops" on public.drops;

create policy "public read drops"
on public.drops for select
using (true);

create policy "public insert drops"
on public.drops for insert
with check (true);

create policy "public delete drops"
on public.drops for delete
using (true);
