-- SPDX-FileCopyrightText: Copyright (c) 2021-2026 Yegor Bugayenko
-- SPDX-License-Identifier: MIT

module = "clicks"
ctanupload = true
typesetopts = "-interaction=batchmode -shell-escape -halt-on-error"
checkopts = "-interaction=batchmode -shell-escape -halt-on-error"
sourcefiles = {"*.dtx", "*.ins", "*-????-??-??.sty"}
tagfiles = {"build.lua", "clicks.dtx"}
checkengines = {"pdftex", "luatex", "xetex"}

uploadconfig = {
  pkg = "clicks",
  version = "0.0.0",
  author = "Yegor Bugayenko",
  uploader = "Yegor Bugayenko",
  email = "yegor256@gmail.com",
  note = "Bug fixes",
  announcement = "Some non-critical bug fixes",
  ctanPath = "/macros/latex/contrib/clicks",
  bugtracker = "https://github.com/yegor256/clicks/issues",
  home = "",
  description = "With the help of this package you can simulate animation in your slide deck, making it look similar to what PowerPoint can do.",
  development = "",
  license = "mit",
  summary = "Slide Deck Animation",
  repository = "https://github.com/yegor256/clicks",
  support = "",
  topic = {"emulation", "layout", "presentation"}
}

function update_tag(file, content, tagname, tagdate)
  return string.gsub(
    string.gsub(content, "0%.0%.0", tagname),
    "0000/00/00", os.date("%Y/%m/%d")
  )
end
