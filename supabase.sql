-- Jodhpur Local: starter schema for Supabase PostgreSQL
-- Review and test policies before production. This schema alone is not a complete secure application.

create table if not exists public.businesses (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(name) between 2 and 120),
  category text not null,
  area text not null,
  phone text not null check (phone ~ '^[0-9]{10}$'),
  description text not null default '',
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  created_at timestamptz not null default now()
);

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  is_admin boolean not null default false
);

alter table public.businesses enable row level security;
alter table public.profiles enable row level security;

-- Public visitors can see only approved listings.
create policy "Public can read approved businesses"
on public.businesses for select
to anon, authenticated
using (status = 'approved');

-- Public visitors can submit a pending listing. Do not let the client choose approved status.
create policy "Anyone can submit pending listing"
on public.businesses for insert
to anon, authenticated
with check (status = 'pending');

-- Admins can read all listings.
create policy "Admins can read all businesses"
on public.businesses for select
to authenticated
using (
  exists (select 1 from public.profiles p where p.id = auth.uid() and p.is_admin = true)
);

-- Admins can update listing status/details.
create policy "Admins can update businesses"
on public.businesses for update
to authenticated
using (
  exists (select 1 from public.profiles p where p.id = auth.uid() and p.is_admin = true)
)
with check (
  exists (select 1 from public.profiles p where p.id = auth.uid() and p.is_admin = true)
);

create policy "Admins can delete businesses"
on public.businesses for delete
to authenticated
using (
  exists (select 1 from public.profiles p where p.id = auth.uid() and p.is_admin = true)
);

-- IMPORTANT:
-- 1. Create a profile row for your admin user using a trusted SQL/editor process.
-- 2. Never allow public users to insert/update their own profiles.is_admin.
-- 3. Keep Supabase service_role key secret; never place it in frontend code.
-- 4. Test policies with anon, normal authenticated user, and admin accounts before launch.
