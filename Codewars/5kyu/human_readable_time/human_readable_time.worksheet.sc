def makeReadable(seconds: Int): String =
  f"${seconds/3600}%02d:${seconds/60%60}%02d:${seconds%60}%02d"