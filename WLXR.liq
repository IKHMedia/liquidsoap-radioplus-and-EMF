set("init.allow_root",true)
set("request.check_interval", 10.0)
set("playlist.preserve", 1)

# 1. Define the function FIRST
def rewrite(m) =
  # This creates a new list of metadata
  # 'm' is the original metadata coming from the source
  [("title", "Mix 97.9 FM & 96.1 FM #{m['title']}")]
end

# 2. Pull your source
radio = mksafe(input.http("https://live.amperwave.net/manifest/magnumbroadcasting-wkbhhd2aac-hlsc1.m3u8"))

# 3. Apply the function to the source
# Use 'rewrite' (the name of the function above)
radio = map_metadata(update=false, rewrite, radio)

# 4. Output the result
output.icecast(
  #%mp3,
  %ffmpeg(format="adts", %audio(codec="aac", b="64k")),
  host = "xxx.xxx.xxx.xxx",
  password = "use-your-own-password",
  mount = "WLXR",
  name = "Mix 97.9 FM & 96.1 FM ",
  description = "Mix 97.9 FM & 96.1 FM ",
  genre = "Adult Contemporary",
  send_icy_metadata = true, # Use 'icy_metadata="true"' if < 2.2
#  icy_metadata = "true", # Correct for your version
  radio
)
