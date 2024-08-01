# From https://stackoverflow.com/a/24132171
function paste_html
  osascript -e 'the clipboard as «class HTML»' | perl -ne 'print chr foreach unpack("C*",pack("H*",substr($_,11,-3)))'
end
