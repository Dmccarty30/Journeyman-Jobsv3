import json

file_path = 'assets/data/storm_roster.json'

with open(file_path, 'r') as f:
    data = json.load(f)

for client in data:
    if 'LOGO_URL' not in client:
        client['LOGO_URL'] = ""

with open(file_path, 'w') as f:
    json.dump(data, f, indent=4)

print(f"Updated {len(data)} records.")
