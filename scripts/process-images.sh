#!/bin/bash
# Image processing script for Roam Outfitters website
# Converts all source images to optimized WebP + JPEG fallback

set -e

PROJ="/Users/davidmontague/Programming/brett-seng"
SRC="$PROJ/my_assets"
OUT="$PROJ/assets/images"

# Carousel images: 1920px wide for hero backgrounds
echo "=== Processing carousel images ==="
for f in "$SRC/carousel_photos"/*.jpg "$SRC/carousel_photos"/*.tif; do
    [ -f "$f" ] || continue
    base=$(basename "$f" | sed 's/\.[^.]*$//')
    echo "  Processing $base..."

    # Convert to JPEG at 1920w, quality 82
    magick "$f" -resize "1920x>" -quality 82 -strip "$OUT/carousel/${base}.jpg"

    # Convert to WebP at 1920w, quality 80
    magick "$f" -resize "1920x>" -quality 80 -strip "$OUT/carousel/${base}.webp"
done

# About pic (HEIC)
echo "=== Processing about pic ==="
magick "$SRC/about_pic.HEIC" -resize "800x>" -quality 82 -strip "$OUT/about/brett.jpg"
magick "$SRC/about_pic.HEIC" -resize "800x>" -quality 80 -strip "$OUT/about/brett.webp"

# Gallery images: 800px wide for gallery grid
echo "=== Processing gallery images ==="
for f in "$SRC/gallery_images"/*.jpg "$SRC/gallery_images"/*.jpeg "$SRC/gallery_images"/*.JPG "$SRC/gallery_images"/*.HEIC "$SRC/gallery_images"/*.heic; do
    [ -f "$f" ] || continue
    base=$(basename "$f" | sed 's/\.[^.]*$//' | sed 's/ /_/g')
    echo "  Processing $base..."

    # Convert to JPEG at 800w, quality 80
    magick "$f" -resize "800x>" -quality 80 -strip "$OUT/gallery/${base}.jpg"

    # Convert to WebP at 800w, quality 78
    magick "$f" -resize "800x>" -quality 78 -strip "$OUT/gallery/${base}.webp"
done

# Logo - optimize PNG
echo "=== Processing logo ==="
cp "$SRC/RoamOutfittersLogo_final.png" "$OUT/logo.png"

echo ""
echo "=== Done! ==="
echo "Checking output sizes..."
echo ""
echo "Carousel:"
ls -lh "$OUT/carousel/" | grep -v total
echo ""
echo "Gallery:"
ls -lh "$OUT/gallery/" | grep -v total
echo ""
echo "About:"
ls -lh "$OUT/about/" | grep -v total
echo ""
echo "Logo:"
ls -lh "$OUT/logo.png"
