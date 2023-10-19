switch (uname)
  case Darwin
  case Linux
    set -gx ALL_PROXY "socks5://127.0.0.1:7890"
  case '*'
end
# set -gx ALL_PROXY "http://127.0.0.1:7890"
set -x HF_API_KEY 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
