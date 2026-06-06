create table if not exists users (
  id bigserial primary key,
  email varchar not null,
  password_digest varchar not null,
  api_token varchar not null,
  created_at timestamp(6) not null,
  updated_at timestamp(6) not null
);
create unique index if not exists index_users_on_email on users(email);
create unique index if not exists index_users_on_api_token on users(api_token);

create table if not exists projects (
  id bigserial primary key,
  user_id bigint not null references users(id),
  name varchar not null,
  color varchar not null default '#1f7a8c',
  created_at timestamp(6) not null,
  updated_at timestamp(6) not null
);
create index if not exists index_projects_on_user_id on projects(user_id);

create table if not exists tasks (
  id bigserial primary key,
  user_id bigint not null references users(id),
  project_id bigint references projects(id),
  title varchar not null,
  notes text,
  status varchar not null default 'inbox',
  priority varchar not null default 'normal',
  due_at timestamp(6),
  completed_at timestamp(6),
  created_at timestamp(6) not null,
  updated_at timestamp(6) not null
);
create index if not exists index_tasks_on_user_id on tasks(user_id);
create index if not exists index_tasks_on_project_id on tasks(project_id);
create index if not exists index_tasks_on_user_id_and_status_and_due_at on tasks(user_id, status, due_at);

create table if not exists tags (
  id bigserial primary key,
  user_id bigint not null references users(id),
  name varchar not null,
  created_at timestamp(6) not null,
  updated_at timestamp(6) not null
);
create index if not exists index_tags_on_user_id on tags(user_id);
create unique index if not exists index_tags_on_user_id_and_name on tags(user_id, name);

create table if not exists task_tags (
  id bigserial primary key,
  task_id bigint not null references tasks(id),
  tag_id bigint not null references tags(id),
  created_at timestamp(6) not null,
  updated_at timestamp(6) not null
);
create index if not exists index_task_tags_on_task_id on task_tags(task_id);
create index if not exists index_task_tags_on_tag_id on task_tags(tag_id);
create unique index if not exists index_task_tags_on_task_id_and_tag_id on task_tags(task_id, tag_id);

create table if not exists xp_events (
  id bigserial primary key,
  user_id bigint not null references users(id),
  task_id bigint references tasks(id),
  points integer not null,
  reason varchar not null,
  happened_at timestamp(6) not null,
  created_at timestamp(6) not null,
  updated_at timestamp(6) not null
);
create index if not exists index_xp_events_on_user_id on xp_events(user_id);
create index if not exists index_xp_events_on_task_id on xp_events(task_id);
create unique index if not exists index_xp_events_on_task_id_and_reason on xp_events(task_id, reason) where task_id is not null;

create table if not exists badge_awards (
  id bigserial primary key,
  user_id bigint not null references users(id),
  badge_key varchar not null,
  awarded_at timestamp(6) not null,
  created_at timestamp(6) not null,
  updated_at timestamp(6) not null
);
create index if not exists index_badge_awards_on_user_id on badge_awards(user_id);
create unique index if not exists index_badge_awards_on_user_id_and_badge_key on badge_awards(user_id, badge_key);

create table if not exists daily_stats (
  id bigserial primary key,
  user_id bigint not null references users(id),
  date date not null,
  completed_count integer not null default 0,
  xp_total integer not null default 0,
  created_at timestamp(6) not null,
  updated_at timestamp(6) not null
);
create index if not exists index_daily_stats_on_user_id on daily_stats(user_id);
create unique index if not exists index_daily_stats_on_user_id_and_date on daily_stats(user_id, date);
