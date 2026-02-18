# JSON Server

This folder contains the backend server for the Flutter WebAPI course project.

## Prerequisites

- Use an LTS Node.js version (`18.x` or `20.x` recommended)
- Check your Node.js version: `node --version`

## Why `json-server-auth` was failing

`json-server-auth` is not fully compatible with `json-server` `1.x` beta.
This project is pinned to:
- `json-server@0.17.4`
- `json-server-auth@2.1.0`

## How to Run

1. Install dependencies once:
```bash
cd server
npm install
```

2. Run without auth:
```bash
npm run start
```

3. Run with auth:
```bash
npm run auth
```

Server runs at:
- `http://localhost:3000`
- `http://<your-local-ip>:3000` (for mobile emulator/device)

## Quick One-Liner (no install)

If you want to test directly with `npx`, use both packages pinned:
```bash
npx --yes --package=json-server@0.17.4 --package=json-server-auth@2.1.0 json-server-auth --watch db.json --host 0.0.0.0 --port 3000
```

## Troubleshooting

### `Cannot find module 'json-server'` or `'express'`
This means only `json-server-auth` was installed/resolved.
Install and run from local dependencies:
```bash
npm install
npm run auth
```

### Node version too new/unstable for old tooling
If you still get startup errors, use Node LTS:
```bash
nvm use 20
```

### Port Already in Use
If port 3000 is already in use, change it:
```bash
npx --yes --package=json-server@0.17.4 json-server --watch db.json --host 0.0.0.0 --port 3001
```

Remember to update the port in your Flutter app's `journal_service.dart` file as well.
