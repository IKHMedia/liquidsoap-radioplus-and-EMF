set("init.allow_root",true)
set("request.check_interval", 10.0)
set("playlist.preserve", 1)

# 1. Define the function FIRST
def rewrite(m) =
  # This creates a new list of metadata
  # 'm' is the original metadata coming from the source
  [("title", "The Source - WFDL AM & W277AC / W229DE#{m['title']}")]
end

# 2. Pull your source
radio = mksafe(input.http("http://ice24.securenetsystems.net/WFDL"))

# 3. Apply the function to the source
# Use 'rewrite' (the name of the function above)
radio = map_metadata(update=false, rewrite, radio)

# 4. Output the result
output.icecast(
  #%mp3,
  %ffmpeg(format="adts", %audio(codec="aac", b="64k")),
  host = "xxx.xxx.xxx.xxx",
  password = "use-your-own-password",
  mount = "WFDL",
  name = "The Source - WFDL AM & W277AC / W229DE",
  description = "The Source - WFDL AM & W277AC / W229DE",
  genre = "Adult Contemporary",
  send_icy_metadata = true, # Use 'icy_metadata="true"' if < 2.2
#  icy_metadata = "true", # Correct for your version
  radio
)
