# 🍥 ShinobiDex

### A Flutter app connected to real REST APIs, built with Clean Architecture, Riverpod, JWT authentication and offline caching.

ShinobiDex is a Flutter application that lets users explore Naruto characters through a public REST API while providing a complete authentication flow powered by Supabase.

The project was built to demonstrate how a Flutter application can interact with real backend services while keeping a clean, testable and maintainable architecture.

> 🎯 **Project goal:** build a production-oriented Flutter application combining REST APIs, authentication, local persistence, offline support, error handling and Clean Architecture.

---

## ✨ Features

### 🔐 Authentication

- User registration
- User login
- User logout
- Persistent authentication session
- JWT access-token management
- Automatic access-token refresh after expiration
- Secure local storage of authentication data
- Authentication implemented through Supabase REST endpoints
- No `supabase_flutter` SDK used for authentication

### 🥷 Naruto Characters

- Browse Naruto characters
- Search characters
- View character details
- Filter characters by village affiliation
- Random "Character of the Day"
- REST API integration through Dio

### 📡 Offline Mode

- Local character caching with Hive
- Previously loaded characters remain available without an internet connection
- Automatic fallback to cached data when the network is unavailable
- Connectivity detection through `internet_connection_checker`

### ⚠️ Error Handling

- Centralized exception handling
- Typed application failures
- Network/server/cache/authentication error mapping
- User-friendly network error screen
- Retry mechanism
- Presentation layer works with `AsyncValue` instead of raw exceptions

### 🧪 Testing

Repository-layer unit tests covering:

- Successful remote data retrieval and caching
- Offline fallback to cached data
- Exception-to-Failure mapping

Testing is done with `flutter_test` and `mocktail`.

---

# 🏗️ Architecture

ShinobiDex follows a **Feature-First Clean Architecture**.

Each feature is divided into three layers:

```text
Presentation
     │
     ▼
  Domain
     │
     ▼
   Data