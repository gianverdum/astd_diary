# JSON Server

This folder contains the backend server for the Flutter WebAPI course project.

## Prerequisites

- **Node.js v20+** is required to run the latest version of json-server
- Check your Node.js version: `node --version`
- If you're using an older version, update Node.js or use an older json-server version

## How to Run the Server

1. Navigate to the server directory:
   ```bash
   cd server
   ```

2. Start the json-server:
   ```bash
   npx json-server --watch db.json --host 192.168.15.88 --port 3000
   ```

   Or use a specific version if needed:
   ```bash
   npx json-server@0.17.4 --watch db.json --host 192.168.15.88 --port 3000
   ```

## Server Details

- **Host**: `192.168.15.88`
- **Port**: `3000`
- **Endpoint**: `http://192.168.15.88:3000/learnhttp`

## Verify It's Running

You should see output like:
```
\{^_^}/ hi!

Loading db.json
Done

Resources
http://192.168.15.88:3000/learnhttp

Home
http://192.168.15.88:3000
```

## Troubleshooting

### Node.js Version Error
If you see: `SyntaxError: The requested module 'node:buffer' does not provide an export named 'File'`

**Solution**: Update Node.js to v20+ or use:
```bash
npx json-server@0.17.4 --watch db.json --host 192.168.15.88 --port 3000
```

### Port Already in Use
If port 3000 is already in use, change it:
```bash
npx json-server --watch db.json --host 192.168.15.88 --port 3001
```

Remember to update the port in your Flutter app's `journal_service.dart` file as well.
