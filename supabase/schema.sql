create table if not exists report_views (
  id bigint generated always as identity primary key,
  report_id text not null,
  viewer_id text not null,
  viewed_at timestamptz not null default now(),
  view_source text not null default 'web',
  metadata jsonb not null default '{}'::jsonb
);

create index if not exists idx_report_views_report_id
  on report_views (report_id);

create index if not exists idx_report_views_viewer_id
  on report_views (viewer_id);

create table if not exists report_acknowledgements (
  report_id text not null,
  viewer_id text not null,
  acknowledged_at timestamptz not null default now(),
  primary key (report_id, viewer_id)
);

create index if not exists idx_report_acknowledgements_viewer_id
  on report_acknowledgements (viewer_id);

create table if not exists system_logs (
  id bigint generated always as identity primary key,
  log_type text not null,
  log_level text not null,
  message text not null,
  context jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index if not exists idx_system_logs_created_at
  on system_logs (created_at desc);

create index if not exists idx_system_logs_type_level
  on system_logs (log_type, log_level);
