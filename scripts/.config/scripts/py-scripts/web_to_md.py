import requests
from bs4 import BeautifulSoup
import html2text
from pathlib import Path
import os
import sys

EXPORT_DIR = "~/Downloads/docs"


def fetch_html(url):
    resp = requests.get(url)
    resp.raise_for_status()
    return resp.text


def extract_main_content(html):
    soup = BeautifulSoup(html, "html.parser")
    main = soup.find("main")
    content = main if main else soup.body
    for tag in content.find_all(['nav', 'footer', 'aside', 'script', 'style', 'header', 'form']):
        tag.decompose()
    return str(content)


def save_file(directory, filename, data):
    directory = Path(os.path.expanduser(directory))
    directory.mkdir(parents=True, exist_ok=True)
    file_path = directory / filename
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(data)


def filename_from_url(url, ext):
    base = url.rstrip('/').replace('https://', '').replace('http://', '').replace('/', '_')
    return f"{base}.{ext}"


def process_url(url, export_dir):
    html = fetch_html(url)
    main_content = extract_main_content(html)
    base_md = filename_from_url(url, "md")
    base_html = filename_from_url(url, "html")
    save_file(export_dir, base_html, main_content)
    markdown = html2text.html2text(main_content)
    save_file(export_dir, base_md, markdown)
    print(f"Saved to: {export_dir}/{base_html}, {export_dir}/{base_md}")


def main():
    if len(sys.argv) < 2:
        print("Usage: python script.py <urls.txt>")
        sys.exit(1)
    url_file = sys.argv[1]
    export_dir = EXPORT_DIR
    with open(url_file, encoding="utf-8") as f:
        urls = [line.strip() for line in f if line.strip()]
    for url in urls:
        try:
            process_url(url, export_dir)
        except Exception as e:
            print(f"Failed to process {url}: {e}")


if __name__ == "__main__":
    main()
