import json
import re

file_path = 'assets/data/storm_roster.json'
bucket_name = 'journeyman-jobs.firebasestorage.app'
logo_path = 'storm_contractors/logos'

def slugify(name):
    # Match the Dart logic exactly
    name = name.lower().strip()
    name = re.sub(r'[.\-\'"]+', '', name)
    name = re.sub(r'\s+', '_', name)
    name = re.sub(r'[^a-z0-9_]', '', name)
    return name

with open(file_path, 'r') as f:
    data = json.load(f)

print(f"Slugify results for manual upload mapping:")
print("-" * 40)

for client in data:
    company = client.get('COMPANY', '').strip()
    slug = slugify(company)
    firebase_url = f"https://firebasestorage.googleapis.com/v0/b/{bucket_name}/o/{logo_path}%2F{slug}.png?alt=media"
    
    # Only update if it's currently empty (don't overwrite their manual work like Richardson & Sons)
    if not client.get('LOGO_URL'):
        client['LOGO_URL'] = firebase_url
        print(f"LINKED: {company:30} -> {slug}.png")

with open(file_path, 'w') as f:
    json.dump(data, f, indent=4)

print("-" * 40)
print(f"Updated {len(data)} records with predicted Firebase URLs.")
print("The app will now show logos automatically once you upload 'slug_name.png' to Firebase.")
