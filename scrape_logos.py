"""
Storm Contractor Logo Scraper
Scrapes company logos from websites listed in storm_roster.json
and saves them as JPG files to assets/images directory.
"""

import json
import os
import requests
from urllib.parse import urljoin, urlparse
from bs4 import BeautifulSoup
from PIL import Image
from io import BytesIO
import re
import time


class LogoScraper:
    def __init__(self, json_path, output_dir):
        self.json_path = json_path
        self.output_dir = output_dir
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }
        
        # Create output directory if it doesn't exist
        os.makedirs(output_dir, exist_ok=True)
    
    def sanitize_filename(self, company_name):
        """Convert company name to a safe filename."""
        # Remove special characters and convert to lowercase
        filename = re.sub(r'[^\w\s-]', '', company_name.lower())
        # Replace spaces with underscores
        filename = re.sub(r'[-\s]+', '_', filename)
        # Remove trailing/leading underscores
        filename = filename.strip('_')
        return filename
    
    def find_logo_url(self, soup, base_url):
        """
        Attempt to find the logo URL from the webpage.
        Tries multiple strategies in order of reliability.
        """
        logo_url = None
        
        # Strategy 1: Look for Open Graph image
        og_image = soup.find('meta', property='og:image')
        if og_image and og_image.get('content'):
            logo_url = og_image['content']
            if logo_url:
                return urljoin(base_url, logo_url)
        
        # Strategy 2: Look for common logo class/id patterns
        logo_patterns = [
            {'class_': re.compile(r'logo', re.I)},
            {'id': re.compile(r'logo', re.I)},
            {'class_': re.compile(r'brand', re.I)},
            {'id': re.compile(r'brand', re.I)},
        ]
        
        for pattern in logo_patterns:
            logo_img = soup.find('img', pattern)
            if logo_img and logo_img.get('src'):
                logo_url = logo_img['src']
                return urljoin(base_url, logo_url)
        
        # Strategy 3: Look in header/nav for images
        header = soup.find(['header', 'nav'])
        if header:
            logo_img = header.find('img')
            if logo_img and logo_img.get('src'):
                logo_url = logo_img['src']
                return urljoin(base_url, logo_url)
        
        # Strategy 4: Look for favicon (last resort)
        favicon = soup.find('link', rel=re.compile(r'icon', re.I))
        if favicon and favicon.get('href'):
            logo_url = favicon['href']
            return urljoin(base_url, logo_url)
        
        return None
    
    def download_and_convert_image(self, image_url, output_path):
        """Download image and convert to JPG format."""
        try:
            response = requests.get(image_url, headers=self.headers, timeout=10)
            response.raise_for_status()
            
            # Open image with PIL
            img = Image.open(BytesIO(response.content))
            
            # Convert to RGB if necessary (for PNG with transparency)
            if img.mode in ('RGBA', 'LA', 'P'):
                # Create white background
                background = Image.new('RGB', img.size, (255, 255, 255))
                if img.mode == 'P':
                    img = img.convert('RGBA')
                background.paste(img, mask=img.split()[-1] if img.mode == 'RGBA' else None)
                img = background
            elif img.mode != 'RGB':
                img = img.convert('RGB')
            
            # Save as JPG
            img.save(output_path, 'JPEG', quality=95)
            return True
            
        except Exception as e:
            print(f"  ❌ Error downloading/converting image: {e}")
            return False
    
    def scrape_logo(self, company_name, website_url):
        """Scrape logo for a single company."""
        print(f"\n🔍 Processing: {company_name}")
        print(f"   URL: {website_url}")
        
        # Create filename
        filename = self.sanitize_filename(company_name)
        output_path = os.path.join(self.output_dir, f"{filename}.jpg")
        
        # Skip if already exists
        if os.path.exists(output_path):
            print(f"  ⏭️  Logo already exists, skipping...")
            return True
        
        try:
            # Fetch the webpage
            response = requests.get(website_url, headers=self.headers, timeout=15)
            response.raise_for_status()
            
            # Parse HTML
            soup = BeautifulSoup(response.content, 'html.parser')
            
            # Find logo URL
            logo_url = self.find_logo_url(soup, website_url)
            
            if not logo_url:
                print(f"  ⚠️  Could not find logo on page")
                return False
            
            print(f"  📥 Found logo: {logo_url}")
            
            # Download and convert to JPG
            if self.download_and_convert_image(logo_url, output_path):
                print(f"  ✅ Saved: {output_path}")
                return True
            else:
                return False
                
        except requests.RequestException as e:
            print(f"  ❌ Error fetching webpage: {e}")
            return False
        except Exception as e:
            print(f"  ❌ Unexpected error: {e}")
            return False
    
    def run(self):
        """Main execution method."""
        print("=" * 70)
        print("🚀 Storm Contractor Logo Scraper")
        print("=" * 70)
        
        # Load JSON data
        try:
            with open(self.json_path, 'r', encoding='utf-8') as f:
                contractors = json.load(f)
        except Exception as e:
            print(f"❌ Error loading JSON file: {e}")
            return
        
        print(f"\n📊 Found {len(contractors)} contractors in roster")
        print(f"📁 Output directory: {self.output_dir}\n")
        
        # Track statistics
        stats = {
            'total': 0,
            'success': 0,
            'failed': 0,
            'skipped': 0
        }
        
        # Process each contractor
        for contractor in contractors:
            company = contractor.get('COMPANY', 'Unknown')
            website = contractor.get('WEBSITE', '')
            
            # Skip if no website
            if not website or website.strip() == '':
                print(f"\n⏭️  Skipping {company} - No website URL")
                stats['skipped'] += 1
                continue
            
            stats['total'] += 1
            
            # Scrape logo
            success = self.scrape_logo(company, website)
            
            if success:
                stats['success'] += 1
            else:
                stats['failed'] += 1
            
            # Be polite - add delay between requests
            time.sleep(1)
        
        # Print summary
        print("\n" + "=" * 70)
        print("📈 SUMMARY")
        print("=" * 70)
        print(f"Total contractors: {len(contractors)}")
        print(f"Processed: {stats['total']}")
        print(f"✅ Successful: {stats['success']}")
        print(f"❌ Failed: {stats['failed']}")
        print(f"⏭️  Skipped (no URL): {stats['skipped']}")
        print("=" * 70)


def main():
    # Paths
    json_path = r"d:\Journeyman-Jobs\assets\data\storm_roster.json"
    output_dir = r"d:\Journeyman-Jobs\assets\images"
    
    # Create and run scraper
    scraper = LogoScraper(json_path, output_dir)
    scraper.run()


if __name__ == "__main__":
    main()
