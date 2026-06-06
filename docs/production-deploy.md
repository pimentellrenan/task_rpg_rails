# Production Deploy

Target:
- GitHub: `pimentellrenan/task_rpg_rails`
- Supabase: `task-rpg-rails` (`wmntyxmgyvatqmzjcbsp`)
- Vercel: separate project, not `personal-finance`

Required Vercel environment variables:
- `DATABASE_URL`
- `SECRET_KEY_BASE`
- `RAILS_ENV=production`
- `RAILS_SERVE_STATIC_FILES=true`

Required GitHub Actions secrets:
- `VERCEL_TOKEN`
- `VERCEL_ORG_ID`
- `VERCEL_PROJECT_ID`

Notes:
- Vercel Ruby runtime is beta and maps `/api/*.rb` files to functions.
- This app uses `api/index.rb` as Rack bridge to Rails.
- Supabase MCP does not expose database password. Use Supabase dashboard connection string for `DATABASE_URL`.
