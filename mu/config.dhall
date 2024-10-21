{ editorCommand = \(file : Text) -> ["nvim", file]
, musicPlayerCommand = \(songname : Text) -> ["mpv", "--really-quiet", "--no-video", songname]
, downloaderCommand = \(url : Text) -> \(filepath : Text) -> ["yt-dlp", url, "-x", "--audio-format", "mp3", "-o", filepath, "-q", "--progress"]
, audioFileStoreDir = "/Users/futar/Music"
}
