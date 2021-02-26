# AtolServer

Provides API for ATOL cash machines software development

Developing software for ATOL cash machines requires two things:
1. Cash machine itself
2. ATOL web-server, that only works on OS Windows

Mock-server simplifies development process. Any OS available, no physical cash machine required

### Requirements:
```
Elixir 1.11.2 (compiled with Erlang/OTP 23)
```

### Installation
1. Get and compile dependencies by 
```
mix deps.get
mix peps.compile
```
2. Collect statics by
```
cd apps/api/assets
npm install
```
3. Start server by
```
mix phx.server
```

### Web-interface
Open http://localhost:16732/ to customize API response