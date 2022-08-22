# Auto-Magic
Auto Magic is a simple cli based shell script that is used to change a files magic numbers. It utilizes xxd to create and rebuild the hex dumps which comes standard on most linux systems. Although it only comes with a few output formats by default, new formats can be added quickly and easily.

## Install
using wget
```bash
sudo bash -c "wget https://raw.githubusercontent.com/1337Rin/Auto-Magic/main/automagic.sh -O /usr/bin/automagic && chmod 755 /usr/bin/automagic"
```
using curl
```bash
sudo bash -c "curl wget https://raw.githubusercontent.com/1337Rin/Auto-Magic/main/automagic.sh > /usr/bin/automagic && chmod 755 /usr/bin/automagic"
```

## Usage
```bash
  AutoMagic is a simple shell script to change magic numbers of file to common image types.

  -p <payload>  payload to be edited.
  -f <format>   format to change payload to: jpg, png, gif or webm
  -o <output>   output file of the edited payload
  -h displays this message

  example: ./automagic.sh -p ~/Desktop/revshell.php -f png -o ~/Desktop/editedpayload

  example: ./automagic.sh -p ~/Desktop/revshell.php
 -f defaults to png format if empty or not provided.
 -o defaults to inputfile.output.format if empty or not provided.
```
## Example

```bash
$ file pentestmonkey.php 
pentestmonkey.php: PHP script, ASCII text

$ automagic -p pentestmonkey.php -f jpg
no output name provided, using: pentestmonkey.output.jpg

$ file pentestmonkey.output.jpg
pentestmonkey.output.jpg: JPEG image data

```
