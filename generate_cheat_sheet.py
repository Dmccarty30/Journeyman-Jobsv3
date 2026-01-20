import json
import re

file_path = 'assets/data/storm_roster.json'

def slugify(name):
    name = name.lower().strip()
    name = re.sub(r'[.\-\'"]+', '', name)
    name = re.sub(r'\s+', '_', name)
    name = re.sub(r'[^a-z0-9_]', '', name)
    return name

with open(file_path, 'r') as f:
    data = json.load(f)

# Clear Richardson & Sons or any others back to empty predicted URLs
bucket_name = 'journeyman-jobs.firebasestorage.app'
logo_path = 'storm_contractors/logos'

print(f"| Company Name | Filename to Upload |")
print(f"| :--- | :--- |")

for client in data:
    company = client.get('COMPANY', '').strip()
    slug = slugify(company)
    filename = f"{slug}.png"
    
    # Update JSON to the predicted link
    predicted_url = f"https://firebasestorage.googleapis.com/v0/b/{bucket_name}/o/{logo_path}%2F{slug}.png?alt=media"
    client['LOGO_URL'] = predicted_url
    
    print(f"| {company} | `{filename}` |")

with open(file_path, 'w') as f:
    json.dump(data, f, indent=4)
