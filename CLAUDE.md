# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
bundle exec rspec spec                        # run all tests
bundle exec rspec spec/models/user_spec.rb    # run single test file
bundle exec rspec spec/models/user_spec.rb:5  # run single test by line number
bundle exec rake db:migrate                   # run pending migrations
bin/rails server                              # start Puma on port 3000
```

No linter is configured.

## Architecture

JSON-only Rails 7 API (`config.api_only = true`) serving a personal portfolio site. No views or helpers.

**Database**: SQLite3 in development/test, PostgreSQL in production. Active Storage uses local disk in dev/test and Google Cloud Storage in production.

**Auth**: JWT via the `jwt_sessions` gem (HS256). The `JWTSessions` token pair (access + refresh) is issued on login and validated in controllers via `before_action :authorize_access_request!`. Passwords use bcrypt. Failed logins are tracked and accounts can be locked out (`UserLockedOut` error in `app/errors/`).

**Key models**:
- `User` — authentication, login failure tracking, lockout
- `Post` — publishable blog/content entries with permalinks (`permalink` gem) and tags
- `Pic` — photos with EXIF extraction (GPS, camera settings), reverse geocoding (`geocoder` gem), image variants/watermarking via MiniMagick, tags
- `Asset` — Active Storage file attachments
- `Slogan`, `Contact` — simple content types

**Serialization**: Active Model Serializers (AMS). `PicSerializer` is the most complex, handling EXIF data, variants, and location.

**Tagging**: `acts-as-taggable-on` gem, used on both `Post` and `Pic`.

**Pagination**: Kaminari — Pics default 24/page, Posts default 4/page.

**Caching**: Redis-backed in production (`REDIS_URL`). Cache is busted via model callbacks. Null store in test, memory store in development.

**EXIF**: Custom initializer at `config/initializers/exif.rb` parses JPEG metadata on upload.

**CORS**: Configured in `config/initializers/cors.rb`; allowed origin set via `CORS_ORIGIN` env var.

## Key Environment Variables

| Variable | Purpose |
|---|---|
| `RAILS_MASTER_KEY` | Credentials decryption |
| `JWT_ENCYPTION_KEY` | JWT signing (note: typo in var name is intentional) |
| `REDIS_URL` | Caching |
| `CORS_ORIGIN` | Allowed CORS origin(s) |
| `DB_NAME`, `DB_HOST`, `DB_USER`, `DB_PW` | Production PostgreSQL |
| `GCS_*` | Google Cloud Storage credentials |
| `SMTP_*` | Outbound mail |

## Test Setup

RSpec with FactoryBot (`spec/factories/`), Shoulda-matchers, and Database Cleaner (truncation strategy). Request specs in `spec/requests/` test full API endpoints including auth headers.