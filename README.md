# ShinobiDex — Flutter App Connected to a Real Backend

A mobile application built with **Flutter**, following a **Clean Architecture / Feature-First** structure and **Riverpod**, connected to a public Naruto character REST API and to a **Supabase** backend for authentication — without using the `supabase_flutter` SDK, in order to implement the JWT interceptor and token-refresh logic from scratch.

The app lets users browse, search and view Naruto characters, create an account and sign in, keep browsing already-loaded characters while offline thanks to a local cache, and handles network errors explicitly instead of letting them crash the UI.

---

# Features

- Full authentication (sign up, sign in, sign out) through Supabase Auth's REST endpoints
- Automatic refresh of expired JWT access tokens, via a dedicated Dio interceptor
- Persistent session: on app restart, the user stays signed in if a valid session is stored locally
- Browsing Naruto characters (list, search, detail) from a public REST API
- Filtering characters by village affiliation
- "Character of the day" picked at random, with a local-cache fallback when offline
- Offline mode: already-loaded characters remain viewable without a connection, via a local Hive cache
- Centralized network error handling, with a dedicated retry screen
- Favorites synced with Supabase *(work in progress)*
- Unit tests on the repository layer

---

# Project Architecture

The project follows a **Clean Architecture** organized by feature (**Feature-First**): each feature owns its three layers (`data`, `domain`, `presentation`), independent from one another.

```
lib/
│
├── core/
│   ├── constant/            # Constants (API, Supabase, Hive)
│   ├── error/                # Exceptions, Failures, exception → failure mapping
│   ├── network/               # Dio clients, auth interceptor, secure storage
│   ├── providers/              # Cross-cutting Riverpod providers (Dio, storage)
│   ├── screens/                 # Shared screens (splash, network error, offline)
│   ├── theme/
│   ├── usecase/
│   └── widgets/                  # Reusable widgets
│
├── features/
│   ├── auth/
│   │   ├── data/              # Remote datasource, models, repository implementation
│   │   ├── domain/             # Entities, repository contract, usecases
│   │   └── presentation/        # Riverpod providers, screens (login, register)
│   │
│   ├── characters/
│   │   ├── data/               # Remote/local datasources, models, repository
│   │   ├── domain/               # Entities, repository contract, usecases
│   │   └── presentation/          # Riverpod providers, screens
│   │
│   ├── favorite/
│   │   └── presentation/
│   │
│   └── profile/
│       └── presentation/
│
└── main.dart
```

Each layer only talks to the one directly beneath it: presentation depends on domain (never the other way around), and domain has no knowledge of Flutter, Dio or Hive.

---

# Design Choices

## Clean Architecture + Feature-First

Every feature is self-contained and follows the same split:
- **domain** — pure entities (`Character`, `AppUser`), repository contracts (interfaces), and usecases. No dependency on Flutter, Dio or Hive.
- **data** — models (`CharacterModel`, `AppUserModel`), remote datasources (Dio) and local datasources (Hive, secure storage), and the concrete repository implementation.
- **presentation** — Riverpod providers (`AsyncNotifier`, `FutureProvider`) and screens, which only ever talk to the domain layer.

## Error handling: Exception → Failure

Errors travel through two distinct representations: the `data` layer throws typed `CustomException`s (`NetworkException`, `ServerException`, `NotFoundException`, `CacheException`, `AuthException`), which the repository converts into sealed `Failure`s through an exhaustive mapping (`failure_mapper.dart`). The `presentation` layer never handles a raw exception — only `Failure`s, exposed through `AsyncValue`.

## Authentication without the Supabase SDK

Instead of using `supabase_flutter`, the app calls Supabase's REST endpoints directly (PostgREST / GoTrue) through Dio, in order to implement from scratch:
- an **authentication interceptor** (`AuthInterceptor`, `QueuedInterceptor`) that attaches the access token to every outgoing request, and, on a `401` response, automatically refreshes the token, saves the new session, and transparently replays the original request;
- secure local storage of tokens and the current user (`flutter_secure_storage`), read back on startup to restore the session without a manual sign-in.

## Local cache and offline mode

Characters fetched from the API are cached in Hive after every successful call. When the device is offline (`NetworkInfo`, backed by `internet_connection_checker`), the repository automatically falls back to the cached data instead of failing.

---

# Data Handling

The app talks to two separate backends:

1. **[dattebayo-api.onrender.com](https://dattebayo-api.onrender.com)** — a public REST API providing Naruto character data (list, search, detail).
2. **Supabase** — the authentication backend (PostgREST / GoTrue REST endpoints), and eventually the favorites store.

Every request follows the same path: Dio call → `CustomException` on failure → converted into a `Failure` by the repository → exposed to the UI through Riverpod's `AsyncValue`.

---

# Application Workflow

```
User
   │
   ▼
Screens (ConsumerWidget / ConsumerStatefulWidget)
   │
   ▼
Riverpod Providers (AsyncNotifier / FutureProvider)
   │
   ▼
Usecases (domain)
   │
   ▼
Repository (domain interface) ──implemented by──▶ Repository Impl (data)
   │
   ├──▶ Remote datasource (Dio → Naruto API / Supabase)
   └──▶ Local datasource (Hive / secure storage)
```

---

# Technologies

- Flutter / Dart
- Riverpod 2.x — state management
- Dio — HTTP client
- Supabase — backend (authentication and Postgres database, via its REST endpoints)
- Hive — local cache
- flutter_secure_storage — secure token storage
- internet_connection_checker — connectivity detection
- flutter_dotenv — environment configuration
- mocktail — unit testing
- Public Naruto API: dattebayo-api.onrender.com

---

# Installation

Clone the repository:
```bash
git clone <repository-url>
```

Move into the project:
```bash
cd shinobi_desk
```

Install dependencies:
```bash
flutter pub get
```

Create a `.env` file at the project root (not committed, see `.env.example`):
```
SUPABASE_URL=https://<your-project>.supabase.co
SUPABASE_KEY=<your-anon-public-key>
```

---

# Running the Application

```bash
flutter run
```

> The app is designed and tested for mobile/emulator targets. Some requests to the Naruto API currently fail on Flutter Web, due to missing CORS headers on the third-party server — a known, identified limitation outside the client's control.

---

# Tests

```bash
flutter test
```

Unit tests cover the repository layer (using `mocktail`): a successful network fetch with caching, falling back to the cache while offline, and correctly mapping exceptions to `Failure`s.

---

# Author

This project was built as part of a graded Flutter assignment ("App connected to a real backend"), to demonstrate:

- JWT authentication against a real backend (Supabase), including refresh-token handling
- Integration of a public REST API across multiple screens
- Local caching and offline mode
- Clean Architecture / Feature-First structure with the Repository pattern
- Unit tests on the repository layer

# Screenshots

<table>
  <tr>
    <td><img src="1.png" width="200"/></td>
    <td><img src="2.png" width="200"/></td>
    <td><img src="3.png" width="200"/></td>
    <td><img src="4.png" width="200"/></td>
    <td><img src="5.png" width="200"/></td>
  </tr>
</table>
