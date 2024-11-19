# Using ImageMagick

If you ever need to do some quick image or document conversions, ImageMagick is a command-line tool that can save you a ton of time. Here's a quick guide on how to install it and use it to convert images, PDFs, and more. Perfect for automating repetitive tasks.

## Installing ImageMagick 🪄 with Homebrew 🍺 (macOS)

To install ImageMagick on macOS, you can use Homebrew:

```bash
brew install imagemagick
```

## Basic Conversion Using `convert`

Once you’ve got it installed, you can jump right in. Here’s a super simple example of converting a `.psd` file to a `.jpg`:

```bash
convert input.psd output.jpg
```

Just like that, `input.psd` turns into `output.jpg`.

## Adding Options with `convert` (PDF to JPG)

Need more control over the output? No problem. You can adjust the quality and resolution with a few extra options. For example, to convert a PDF to a high-quality JPG:

```bash
convert -density 150 input.pdf -quality 90 output.jpg
```

### What Do These Options Do?

- **`-density 150`**: Sets the DPI (dots per inch). This controls the resolution of the output.
- **`-quality 90`**: Adjusts the compression quality for the JPG, balancing file size and image quality.

## Resize Images with `convert`

Want to resize the image as you convert it? You can do that too. Here's how to resize an image to 800x600 pixels:

```bash
convert input.psd -resize 800x600 output.jpg
```

This will resize the `.psd` to 800x600 and save it as `.jpg`.

## Batch Conversion Using `mogrify` (PSD to JPG)

If you need to convert a bunch of files at once, `mogrify` is the way to go. It’s part of ImageMagick and is great for batch processing. Unlike `convert`, `mogrify` modifies files in place or creates new versions if you’re changing formats.

To convert all `.psd` files in a directory to `.jpg`, use:

```bash
mogrify -format jpg *.psd
```

### Heads Up

If your `.psd` files have multiple layers, `mogrify` might create multiple output versions (`-0`, `-1`, etc.) for each layer.

## Using `mogrify` with Additional Options

If you only want a single output per file and don’t care about layers, add the `-flatten` option to merge everything into one:

```bash
mogrify -flatten -format jpg *.psd
```

- **`-flatten`**: Merges all the layers into one, so you get just one `.jpg` for each `.psd`.

## Resize Images with `mogrify`

You can also resize multiple images at once. To resize all `.psd` files to 800x600 and convert them to `.jpg`:

```bash
mogrify -resize 800x600 -format jpg *.psd
```

This will resize every `.psd` file and save it as a `.jpg` in the same directory.

ImageMagick is a fantastic tool for batch processing, converting formats, or simply resizing images. 👍

